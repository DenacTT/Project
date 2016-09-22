//
//  ConfigMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigMovieViewController.h"
#import "MoreMusicViewController.h"
#import "EditVideoViewController.h"
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
 * @param thumbnailPath  保存拍摄好视频首侦图的存储路径
 */
- (void)qupaiSDK:(id<QupaiSDKDelegate>)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 保存视频和图片到临时目录
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
    
//    // 拷贝出来
//    if (videoPath && thumbnailPath) {
//        [self saveVideo:videoPath thumbnail:thumbnailPath];
//    }
    NSLog(@"视频保存路径: %@ \n 照片保存路径: %@", videoPath, thumbnailPath);
    
    if (videoPath != nil) {
        EditVideoViewController *vc = [[EditVideoViewController alloc] init];
        vc.videoPath = videoPath;
        vc.photoPath = thumbnailPath;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

// 需要将视频从临时目录中拷贝出来,因为下次录制的时候会清空临时目录,亲测!
- (void)saveVideo:(NSString *)videoPath thumbnail:(NSString *)thumbnailPath
{
    NSString *doucumetPaht = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [doucumetPaht stringByAppendingString:@"Test"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:testDirPath]) {
        // 创建目录
        [fileManager createDirectoryAtPath:testDirPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *testVideoPath = [testDirPath stringByAppendingPathComponent:[videoPath lastPathComponent]];
    NSString *testThumbnailPath = [testDirPath stringByAppendingPathComponent:[thumbnailPath lastPathComponent]];
    
    [[NSFileManager defaultManager] copyItemAtPath:videoPath toPath:testVideoPath error:nil];
    [[NSFileManager defaultManager] copyItemAtPath:thumbnailPath toPath:testThumbnailPath error:nil];
    
    QPUploadTask *task = [[QPUploadTaskManager shared] createUploadTaskWithVideoPath:testVideoPath thumbnailPath:testThumbnailPath];
    
}

// music List
- (NSArray *)qupaiSDKMusics:(id<QupaiSDKDelegate>)sdk
{
    // 获取本地背景音乐
    NSString *baseDir = [[NSBundle mainBundle] bundlePath];
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:_down ? @"music2" : @"music1" ofType:@"json"];
    NSData *configData = [NSData dataWithContentsOfFile:configPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:configData options:NSJSONReadingAllowFragments error:nil];
    NSArray *items = dic[@"music"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *item in items) {
        NSString *path = [baseDir stringByAppendingPathComponent:item[@"resourceUrl"]];
        QPEffectMusic *effect = [[QPEffectMusic alloc] init];
        effect.name = item[@"name"];
        effect.eid = [item[@"id"] intValue];
        effect.musicName = [path stringByAppendingPathComponent:@"audio.mp3"];
        effect.icon = [path stringByAppendingPathComponent:@"icon.png"];
        [array addObject:effect];
    }
    return array;
}

- (void)qupaiSDKShowMoreMusicView:(id<QupaiSDKDelegate>)sdk viewController:(UIViewController *)viewController
{
    MoreMusicViewController *moreMusicViewController = [[MoreMusicViewController alloc] init];
    [viewController presentViewController:moreMusicViewController animated:YES completion:nil];
    
    _down = YES;
}

- (IBAction)dismissController:(UIButton *)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 触摸屏幕回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.view.subviews) {
        [view resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
