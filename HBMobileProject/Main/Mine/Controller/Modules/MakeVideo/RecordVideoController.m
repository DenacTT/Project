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
#import "VideoRecordTopView.h"
#import "VideoRecordEngine.h"
#import "VideoRecordStatusView.h"
#import "NSTimer+Addition.h"
#import "CircularSlider.h"
#import "EditVideoViewController.h"

@interface RecordVideoController ()<RecordEngineDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) VideoRecordTopView    *topView;       // 延时工具栏
@property (nonatomic, strong) UIButton              *beautyBtn;     // 美颜功能
@property (nonatomic, strong) UIButton              *cameraBtn;     // 摄像头切换
@property (nonatomic, strong) UIButton              *cancelBtn;     // 取消按钮
@property (nonatomic, strong) UILabel               *delayLabel;    // 倒计时Label
@property (nonatomic, strong) VideoRecordStatusView *recordView;    // 录制状态View
@property (strong, nonatomic) VideoRecordEngine     *recordEngine;  // 视频录制器

@property (nonatomic,weak) NSTimer *delayTimer;    //倒计时定时器
@property (nonatomic,weak) NSTimer *recordTimer;   //录制定时器

@end

@implementation RecordVideoController
{
    CGFloat     _recordSeconds; //已录制时间
    NSInteger   _delaySeconds;  //延时倒计时
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view.layer insertSublayer:[self.recordEngine previewLayer] atIndex:0];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.beautyBtn];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.delayLabel];
    [self.view addSubview:self.recordView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 预先开启录制功能
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

#pragma mark - NSTimer
// 延时倒计时
- (NSTimer *)delayTimer
{
    if (!_delayTimer) {
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                           target:self
                                                         selector:@selector(delayTimerRun)
                                                         userInfo:nil
                                                          repeats:YES];
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
        [self startRecording];
        _delayLabel.hidden = YES;
        [_delayTimer pauseTimer];
    }
}

// 录制倒计时
- (NSTimer *)recordTimer
{
    if (!_recordTimer) {
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                           target:self
                                                         selector:@selector(recordTimerRun)
                                                         userInfo:nil
                                                          repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _recordTimer = timer;
    }
    return _recordTimer;
}

- (void)recordTimerRun
{
    _recordSeconds += 0.1;
    [_recordView strokeEndNumberChange];
    if (_recordSeconds > 10) {
        [self resetAndUseVideo];
        [self endRecording];
    }
}

#pragma  mark - 录制按钮
- (void)onRecord:(UITapGestureRecognizer *)sender
{
    if (_delaySeconds > 0 && !_delayLabel.hidden) {
        [self.delayTimer pauseTimer];
        _delayLabel.hidden = YES;
        [_recordView setType:YMRecordType_RecordVideo];
        return;
    }
    
    if (self.recordEngine.isCapturing) {
        [self.recordEngine pauseCapture];
        [_recordTimer pauseTimer];
        [_recordView setType:YMRecordType_RecordVideo];
        [self resetAndUseVideo];
        return;
    }
    
    // 延时播放
    if ([_topView getDelaySecond] != 0) {
        // 获取延时时间
        _delaySeconds = [_topView getDelaySecond];
        _delayLabel.hidden = NO;
        // 开启定时器
        [self.delayTimer resumeTimer];
        [_recordView setType: YMRecordType_StopDelay];
    }else{
        [self startRecording];
    }
}

#pragma mark - 录制与暂停控制
// 开始录制
- (void)startRecording
{
    // 开启录制功能
    [self.recordEngine startUp];
    // 开始录制
    [self.recordEngine startCapture];
    // 启动定时器
    _recordSeconds = 0;
    [self.recordTimer resumeTimer];
    // 设置为结束状态
    [_recordView setType:YMRecordType_StopRecord];
}

// 结束录制
- (void)endRecording
{
    if (self.recordEngine.isCapturing) {
        // 关闭录制功能
        [self.recordEngine shutdown];
        // 暂停录制
        [self.recordEngine pauseCapture];
        // 停止定时器
        [self.recordTimer pauseTimer];
        // 设置为可录状态
        [self.recordView setType:YMRecordType_RecordVideo];
        return;
    }
    
}

#pragma mark - 取消
// 取消
- (void)cancelRecord:(UIButton *)sender
{
    [self.recordEngine pauseCapture];
    [self.recordEngine shutdown];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)resetAndUseVideo
{
    [self.recordView returnCircularStroke];
    [self.recordTimer pauseTimer];
    
    __weak typeof(self) weakSelf = self;
    [self.recordEngine stopCaptureHandler:^(UIImage *movieImage) {
        NSLog(@"videoPath : %@ \n 视频大小: %.2f M", weakSelf.recordEngine.videoPath, [weakSelf.recordEngine getfileSize:weakSelf.recordEngine.videoPath]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *outPutPath = weakSelf.recordEngine.videoPath;
            NSData *videData = [NSData dataWithContentsOfFile:outPutPath];
            
            EditVideoViewController *vc = [[EditVideoViewController alloc] init];
            vc.videoPath = [NSURL fileURLWithPath:outPutPath];
            
            vc.videoLength = _recordSeconds;
            vc.videoData = videData;
            vc.thumbnailImage = movieImage;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        });

    }];
}


#pragma mark - 切换摄像头
- (void)onCameraChange:(UIButton *)sender
{
    self.cameraBtn.selected = !self.cameraBtn.selected;
    if (self.cameraBtn.selected) {
        [self.recordEngine changeCameraInputDeviceisFront:YES];
    }else{
        [self.recordEngine changeCameraInputDeviceisFront:NO];
    }
}

#pragma mark - 美颜
- (void)onBeautyBtnChange:(UIButton *)sender
{
    
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

- (VideoRecordTopView *)topView
{
    if (!_topView) {
        _topView = [[VideoRecordTopView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
    }
    return _topView;
}

- (UIButton *)beautyBtn
{
    if (!_beautyBtn) {
        _beautyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cameraBtn setImage: [UIImage imageNamed: @"RecordIcoMackup"] forState: UIControlStateNormal];
        [_cameraBtn setImage: [UIImage imageNamed: @"RecordIcoMackup_1"] forState: UIControlStateHighlighted];
        _cameraBtn.frame = CGRectMake(ScreenWidth - 44 - 54, 20, 44, 44);
        [_cameraBtn addTarget: self action: @selector(onBeautyBtnChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beautyBtn;
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
        _delayLabel.hidden = YES;
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

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [self.recordEngine shutdown];
    [_delayTimer invalidate];
    _delayTimer = nil;
    [_recordTimer invalidate];
    _recordTimer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
