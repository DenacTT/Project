//
//  ConfigMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigMovieViewController.h"
#import "MakeMovieViewController.h"
#import <QPSDK/QPSDK.h>

@interface ConfigMovieViewController ()

@end

@implementation ConfigMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"配置";
    
}

- (IBAction)startMakeMovie:(id)sender
{
    QupaiSDK *qupai = [QupaiSDK shared];
    [qupai setDelegte:(id<QupaiSDKDelegate>)self];
    
    /* 基础设置 */
    [qupai setEnableWatermark:_enableWaterMask.on];
    [qupai setEnableMoreMusic:_enableMoreMusic.on];
    [qupai setEnableVideoEffect:_enableEditVideo.on];
    [qupai setEnableImport:_enableImportVideo.on];
    [qupai setEnableBeauty:_enableBeautyFunction.on];

    /* 前后置摄像头 */
    [qupai setCameraPosition:_enableFrontCamera.on ? QupaiSDKCameraPositionFront : QupaiSDKCameraPositionBack];
    /* TintColor */
    [qupai setTintColor:RGB(_colorR.value, _colorG.value, _colorB.value)];
    /* 第一帧图片质量 */
    [qupai setThumbnailCompressionQuality:[_photoQuality.text floatValue]];
    
    /* 设置水印 */
    [qupai setWatermarkImage:_enableBeautyFunction.on ? Image(@"watermask") : nil];
    
    MakeMovieViewController *vc = [[MakeMovieViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
