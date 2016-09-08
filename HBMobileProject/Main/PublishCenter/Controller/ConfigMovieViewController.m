//
//  ConfigMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigMovieViewController.h"
#import "MoreMusicViewController.h"
#import <QPSDK/QPSDK.h>

@interface ConfigMovieViewController ()
{
    BOOL _down;
}
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
    
    /* 可选设置 */
    [qupai setEnableWatermark:_enableWaterMask.on];
    [qupai setEnableMoreMusic:_enableMoreMusic.on];
    [qupai setEnableVideoEffect:_enableEditVideo.on];
    [qupai setEnableImport:_enableImportVideo.on];
    [qupai setEnableBeauty:_enableBeautyFunction.on];

    /* 前后置摄像头 */
    [qupai setCameraPosition:_enableFrontCamera.on ? QupaiSDKCameraPositionFront : QupaiSDKCameraPositionBack];
    /* TintColor */
    [qupai setTintColor:RGB(_colorR.value, _colorG.value, _colorB.value)];
    /* 首帧图片质量 */
    [qupai setThumbnailCompressionQuality:[_photoQuality.text floatValue]];
    
    /* 设置水印 */
    [qupai setWatermarkImage:_enableBeautyFunction.on ? Image(@"watermask") : nil];
    /* 水印位置 */
    [qupai setWatermarkPosition:QupaiSDKWatermarkPositionBottomRight];
    
    /* 基础设置 */
    // 快速创建录制页面,参数默认
//    UIViewController *makeMovieController = [qupai createRecordViewController];
    
    // 创建录制页面
    UIViewController *makeMovieController = [qupai createRecordViewControllerWithMinDuration:[_mineDuration.text integerValue] maxDuration:[_maxDuration.text integerValue] bitRate:[_bitRate.text integerValue]];
    
    // 需要以 NavigationController 为父容器
    UINavigationController *makeMovieNavigationController = [[UINavigationController alloc] initWithRootViewController:makeMovieController];
    makeMovieNavigationController.navigationBarHidden = YES;
    [self presentViewController:makeMovieNavigationController animated:YES completion:nil];
}

/**
 * @param videoPath      保存拍摄好视频的存储路径
 * @param thumbnailPath  保存拍摄好视频首侦图的存储路径
 */
- (void)qupaiSDK:(id<QupaiSDKDelegate>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    NSLog(@"视频保存路径: %@", videoPath);
    // 推出控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 保存视频到相册
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    
    // 保存首帧图片到相册
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
}

// more music
- (NSArray *)qupaiSDKMusics:(id<QupaiSDKDelegate>)sdk
{
    // 获取本地背景音乐
    NSString *configPath = [[NSBundle mainBundle] pathForResource:_down ? @"music2" : @"music1" ofType:@"json"];
    NSData *configData = [NSData dataWithContentsOfFile:configPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingAllowFragments error:nil];
    NSArray *items = [dic objectForKey:@"music"];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *baseBundle = [[NSBundle mainBundle] bundlePath];
    
    for (NSDictionary *item in items) {
        NSString *path = [baseBundle stringByAppendingPathComponent:[item objectForKey:@"resourceUrl"]];
        
        QPEffectMusic *music = [[QPEffectMusic alloc] init];
        music.name = item[@"name"];
        music.eid = [item[@"id"] intValue];
        music.musicName = [path stringByAppendingPathComponent:@"audio.mp3"];
        music.icon = [path stringByAppendingPathComponent:@"icon.png"];
        [array addObject:music];
    }
    return array;
}

- (void)qupaiSDKShowMoreMusicView:(id<QupaiSDKDelegate>)sdk viewController:(UIViewController *)viewController
{
    MoreMusicViewController *moreMusicViewController = [[MoreMusicViewController alloc] init];
    [viewController presentViewController:moreMusicViewController animated:YES completion:nil];
    
    _down = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
