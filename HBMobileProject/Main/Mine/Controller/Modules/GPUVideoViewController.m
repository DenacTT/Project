//
//  GPUVideoViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "GPUVideoViewController.h"
#import "GPUImage.h"
#import "GPUImageBeautifyFilter.h"
#import "Masonry.h"

#import "VideoRecordTopView.h"
#import "VideoRecordStatusView.h"
#import "VideoRecordEngine.h"
#import "NSTimer+Addition.h"
#import "CircularSlider.h"

@interface GPUVideoViewController ()

@property (nonatomic, strong) VideoRecordTopView    *topView;       // 延时工具栏
@property (nonatomic, strong) UIButton              *beautyBtn;     // 美颜功能
@property (nonatomic, strong) UIButton              *cameraBtn;     // 摄像头切换
@property (nonatomic, strong) UIButton              *cancelBtn;     // 取消按钮
@property (nonatomic, strong) UILabel               *delayLabel;    // 倒计时Label
@property (nonatomic, strong) VideoRecordStatusView *recordView;    // 录制状态View
@property (strong, nonatomic) VideoRecordEngine     *recordEngine;  // 视频录制器

@property (nonatomic,weak) NSTimer *delayTimer;    //倒计时定时器
@property (nonatomic,weak) NSTimer *recordTimer;   //录制定时器

@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *captureVideoPreview;

@end

@implementation GPUVideoViewController
{
    CGFloat     _recordSeconds; //已录制时间
    NSInteger   _delaySeconds;  //延时倒计时
}

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    [self.videoCamera stopCameraCapture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.beautyBtn];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.delayLabel];
    [self.view addSubview:self.recordView];
    
    // 创建视频源
    // SessionPreset:屏幕分辨率，AVCaptureSessionPresetHigh 会自适应高分辨率
    // cameraPosition:摄像头方向
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    // 创建最终预览View
    self.captureVideoPreview = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenWidth)];
    _captureVideoPreview.fillMode = kGPUImageFillModePreserveAspectRatioAndFill; /* 填充模式*/
    [self.view insertSubview:_captureVideoPreview atIndex:0];
    
    // 设置处理链
    [_videoCamera addTarget:_captureVideoPreview];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [_videoCamera startCameraCapture];
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(10, ScreenHeight - 60, 40, 40)];
    switchBtn.on = NO;
    [switchBtn addTarget:self action:@selector(openBeautifyFilter:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:switchBtn];
}

- (void)openBeautifyFilter:(UIButton *)sender {
    
    self.beautyBtn.selected = !self.beautyBtn.selected;
    // 切换美颜效果原理：移除之前所有处理链，重新设置处理链
    if (sender.selected) {
        
        // 移除之前所有处理链
        [_videoCamera removeAllTargets];
        
        // 创建美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        
        // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
        [_videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:_captureVideoPreview];
    } else {
        // 移除之前所有处理链
        [_videoCamera removeAllTargets];
        [_videoCamera addTarget:_captureVideoPreview];
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
//        [self resetAndUseVideo];
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
//        [self startRecording];
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

#pragma mark - 切换摄像头
- (void)onCameraChange:(UIButton *)sender
{
    self.cameraBtn.selected = !self.cameraBtn.selected;
    if (self.cameraBtn.selected) {
        
    }else{
        
    }
}

#pragma mark - set、get方法

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
        [_beautyBtn setImage: [UIImage imageNamed: @"RecordIcoMackup"] forState: UIControlStateNormal];
        [_beautyBtn setImage: [UIImage imageNamed: @"RecordIcoMackup_1"] forState: UIControlStateHighlighted];
        _beautyBtn.frame = CGRectMake(ScreenWidth - 44 - 54, 20, 44, 44);
        [_beautyBtn addTarget: self action: @selector(openBeautifyFilter:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
