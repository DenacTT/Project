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

@interface GPUVideoViewController ()



@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *captureVideoPreview;

@end

@implementation GPUVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
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

- (void)openBeautifyFilter:(UISwitch *)sender {
    
    // 切换美颜效果原理：移除之前所有处理链，重新设置处理链
    if (sender.on) {
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
