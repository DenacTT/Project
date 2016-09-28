//
//  RecordVideoController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/24.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "RecordVideoController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoTopView.h"
#import "VideoRecordEngine.h"
#import "VideoRecordStatusView.h"
#import "NSTimer+Addition.h"
#import "CircularSlider.h"
#import "EditVideoViewController.h"

@interface RecordVideoController ()<VideoTopViewDelegate, RecordEngineDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) VideoTopView  *topView;       // 延时工具栏
@property (nonatomic, strong) UIButton      *cameraBtn;     // 摄像头切换
@property (nonatomic, strong) UIButton      *cancelBtn;     // 取消
@property (nonatomic, strong) UILabel       *delayLabel;    // 倒计时

@property (nonatomic, strong) UIButton      *recordBtn;     // 录制按钮
@property (strong, nonatomic) CircularSlider                *circularSlider; // 圆形进度条

@property (nonatomic, strong) VideoRecordStatusView *recordView;   // 录制状态View

@property (strong, nonatomic) VideoRecordEngine             *recordEngine;

@property (assign, nonatomic) BOOL                          allowRecord;    //允许录制
@property (strong, nonatomic) UIImagePickerController       *moviePicker;   //视频选择器
@property (strong, nonatomic) MPMoviePlayerViewController   *playerVC;

@property (nonatomic,weak) NSTimer * delayTimer;    //倒计时定时器
@property (nonatomic,weak) NSTimer * recordTimer;   //录制定时器

@end

@implementation RecordVideoController
{
    CGFloat     _recordSeconds; //已录制时间
    NSInteger   _delaySeconds;  //延时倒计时;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 开启录制功能
    [self.recordEngine startUp];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[UIApplication sharedApplication] setStatusBarHidden: NO];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 关闭录制功能
    [self.recordEngine shutdown];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view.layer insertSublayer:[self.recordEngine previewLayer] atIndex:0];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.delayLabel];
    [self.view addSubview:self.recordView];
//    [self.view addSubview:self.circularSlider];
//    [self.view addSubview:self.recordBtn];
    
    
    UIButton *useBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    useBtn.frame = CGRectMake(ScreenWidth - 44 - 15, self.recordBtn.center.y-22, 44, 44);
    useBtn.frame = CGRectMake(ScreenWidth - 44 - 15, self.recordView.center.y-22, 44, 44);
    [useBtn setTitle:@"使用" forState:(UIControlStateNormal)];
    [useBtn addTarget: self action: @selector(useBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:useBtn];
    
    // 开启录制功能
    [self.recordEngine startUp];
    
    self.allowRecord = YES;
}

#pragma mark - 使用
- (void)useBtnClick:(UIButton *)sender
{
//    EditVideoViewController *vc = [[EditVideoViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    __weak typeof(self) weakSelf = self;
    [self.recordEngine stopCaptureHandler:^(UIImage *movieImage) {
        NSLog(@"videoPath : %@", weakSelf.recordEngine.videoPath);
        weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[weakSelf.playerVC moviePlayer]];
        [[weakSelf.playerVC moviePlayer] prepareToPlay];
        
        [weakSelf presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
        [[weakSelf.playerVC moviePlayer] play];
    }];
    
}

#pragma mark - set、get方法
- (VideoRecordEngine *)recordEngine {
    if (!_recordEngine) {
        _recordEngine = [[VideoRecordEngine alloc] init];
        [self.recordEngine previewLayer].frame = CGRectMake(0, 64, ScreenWidth, ScreenWidth);
        _recordEngine.delegate = self;
    }
    return _recordEngine;
}

- (UIImagePickerController *)moviePicker {
    if (!_moviePicker) {
        _moviePicker = [[UIImagePickerController alloc] init];
        _moviePicker.delegate = self;
        _moviePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        _moviePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _moviePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
    }
    return _moviePicker;
}

- (VideoTopView *)topView
{
    if (!_topView) {
        _topView = [[VideoTopView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    }
    return _topView;
}

- (UIButton *)cameraBtn
{
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_cameraBtn setImage: [UIImage imageNamed: @"CameraChange"] forState: UIControlStateNormal];
        [_cameraBtn setImage: [UIImage imageNamed: @"CameraChange"] forState: UIControlStateHighlighted];
        _cameraBtn.frame = CGRectMake(ScreenWidth - 44, 20, 44, 44);
        [_cameraBtn addTarget: self action: @selector(onCameraChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        _cancelBtn.frame = CGRectMake(15, ScreenHeight - 120, 44, 100);
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize: 18.f];
        [_cancelBtn setTitle:STR(@"取消") forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [_cancelBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [_cancelBtn addTarget: self action: @selector(cancelRecord:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)delayLabel
{
    if (!_delayLabel) {
        _delayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _delayLabel.width = 60;
        _delayLabel.height = 60;
        _delayLabel.top = ScreenWidth + 44.f - 60.f;
        _delayLabel.left = ScreenWidth - 40.f - 18.f;
        
        _delayLabel.textColor = [UIColor whiteColor];
        _delayLabel.font = Font(55.f);
        _delayLabel.text = @"1";
//        _delayLabel.hidden = YES;
    }
    return _delayLabel;
}

- (VideoRecordStatusView *)recordView
{
    if (!_recordView) {
        _recordView = [[VideoRecordStatusView alloc] initWithFrame:CGRectZero];
        _recordView.width = 66;
        _recordView.height = 66;
        _recordView.top = _cancelBtn.center.y - _recordView.height/2;
        _recordView.left = (ScreenWidth - _recordView.width)/2;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget: self action:@selector(onRecord:)];
        [_recordView addGestureRecognizer: tap];
    }
    return _recordView;
}

- (CircularSlider *)circularSlider
{
    if (!_circularSlider) {
        _circularSlider = [[CircularSlider alloc] initWithRadius:90.f];
        _circularSlider.width = 90.f;
        _circularSlider.height = 90.f;
        _circularSlider.top = _cancelBtn.center.y - _circularSlider.height/2;
        _circularSlider.left = (ScreenWidth - _circularSlider.width)/2;
    }
    return _circularSlider;
}

- (UIButton *)recordBtn
{
    if (!_recordBtn) {
        _recordBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _recordBtn.width = 80;
        _recordBtn.height = 80;
        _recordBtn.center = _circularSlider.center;
        [_recordBtn setImage:Image(@"RecodeButton") forState:(UIControlStateNormal)];
        [_recordBtn setImage:Image(@"RecordPasureButton") forState:(UIControlStateHighlighted)];
        
        [_recordBtn addTarget:self action:@selector(recordAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _recordBtn;
}

#pragma mark - NSTimer
- (NSTimer *)delayTimer
{
    if (!_delayTimer) {
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(delayTimerRun) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _delayTimer = timer;
    }
    return _delayTimer;
}

- (void)delayTimerRun
{
    _delaySeconds --;
    _delayLabel.text = [NSString stringWithFormat:@"%d", (int)_delaySeconds];
    if (_delaySeconds <= 0) {
        [self.recordEngine startCapture];
        _delayLabel.hidden = YES;
        [_delayTimer pauseTimer];
    }
}

#pragma mark - button
- (void)cancelRecord:(UIButton *)sender
{
    [self.recordEngine shutdown];
//    [self dismissViewControllerAnimated:YES completion:^{
//        _recordEngine = nil;
//        _moviePicker = nil;
//    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    _recordEngine = nil;
    _moviePicker = nil;
}

//当点击Done按键或者播放完毕时调用此函数
- (void) playVideoFinished:(NSNotification *)theNotification {
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [self.playerVC dismissMoviePlayerViewControllerAnimated];
    self.playerVC = nil;
}

- (void)onCameraChange:(UIButton *)sender
{
    
    self.cameraBtn.selected = !self.cameraBtn.selected;
    if (self.cameraBtn.selected) {
        // 前置
        [self.recordEngine changeCameraInputDeviceisFront:YES];
    }else{
        // 后置
        [self.recordEngine changeCameraInputDeviceisFront:NO];
    }
}

#pragma  mark - 录制按钮
- (void)onRecord:(UITapGestureRecognizer *)sender
{
    [self.recordEngine startCapture];
    [_recordView strokeEndNumberChange];
}

- (void)recordAction:(UIButton *)sender
{
    [self.recordEngine startCapture];
}

#pragma mark - Apple相册选择代理
//选择了某个照片的回调函数/代理回调
/*
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie]) {
        //获取视频的名称
        NSString * videoPath=[NSString stringWithFormat:@"%@",[info objectForKey:UIImagePickerControllerMediaURL]];
        NSRange range =[videoPath rangeOfString:@"trim."];//匹配得到的下标
        NSString *content=[videoPath substringFromIndex:range.location+5];
        //视频的后缀
        NSRange rangeSuffix=[content rangeOfString:@"."];
        NSString * suffixName=[content substringFromIndex:rangeSuffix.location+1];
        //如果视频是mov格式的则转为MP4的
        if ([suffixName isEqualToString:@"MOV"]) {
            NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            __weak typeof(self) weakSelf = self;
            [self.recordEngine changeMovToMp4:videoUrl dataBlock:^(UIImage *movieImage) {
                
                [weakSelf.moviePicker dismissViewControllerAnimated:YES completion:^{
                    weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[weakSelf.playerVC moviePlayer]];
                    [[weakSelf.playerVC moviePlayer] prepareToPlay];
                    
                    [weakSelf presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
                    [[weakSelf.playerVC moviePlayer] play];
                }];
            }];
        }
    }
}
 */

#pragma mark - RecordEngineDelegate
- (void)recordProgress:(CGFloat)progress {
//    if (progress >= 1) {
//        [self recordAction:self.recordBt];
//        self.allowRecord = NO;
//    }
//    self.progressView.progress = progress;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
