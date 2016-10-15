//
//  VideoCameraExample.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "VideoCameraExample.h"
#import "GPUImageBeautifyFilter.h"

@interface VideoCameraExample ()<CAAnimationDelegate>
@property (nonatomic , strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic , strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic , strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic , strong) GPUImageView *filterView;

@property (nonatomic , strong) UIButton *mButton;
@property (nonatomic , strong) UILabel  *mLabel;
@property (nonatomic , assign) long     mLabelTime;
@property (nonatomic , strong) NSTimer  *mTimer;
@end

@implementation VideoCameraExample

- (instancetype) initWithFrame:(CGRect)frame{
    if (!(self = [super initWithFrame:frame]))
    {
        return nil;
    }
    mainScreenFrame = frame;
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [_videoCamera addAudioInputsAndOutputs];
    
    _filter = [[GPUImageBeautifyFilter alloc] init];
    _filterView = [[GPUImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_videoCamera addTarget:_filter];
    [_filter addTarget:_filterView];
    
    [_videoCamera startCameraCapture];
    
    [self setUpVideoCamera];
    [self addSubview:_filterView];

    return self;
}

- (void)setUpVideoCamera
{
    _mButton = [[UIButton alloc] initWithFrame:CGRectMake(self.center.x-25, self.size.height-50, 50, 50)];
    [_mButton setTitle:@"录制" forState:UIControlStateNormal];
    [_mButton sizeToFit];
    [self.filterView addSubview:_mButton];
    [_mButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _mLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x-50, 64, 100, 50)];
    _mLabel.hidden = YES;
    _mLabel.textColor = [UIColor whiteColor];
    [self.filterView addSubview:_mLabel];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, self.size.height-103, self.size.width - 20.0, 40.0)];
    [slider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    slider.minimumValue = 0.0;
    slider.maximumValue = 2.0;
    slider.value = 1.0;
    [self.filterView addSubview:slider];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }];
}

- (void)onTimer:(id)sender {
    _mLabel.text  = [NSString stringWithFormat:@"录制时间:%lds", _mLabelTime++];
    [_mLabel sizeToFit];
}

- (void)onClick:(UIButton *)sender {
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie6.mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    if([sender.currentTitle isEqualToString:@"录制"]) {
        [sender setTitle:@"结束" forState:UIControlStateNormal];
        NSLog(@"Start recording");
        unlink([pathToMovie UTF8String]); // 如果已经存在文件，AVAssetWriter会有异常，删除旧文件
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(320.0, 480.0)];
        _movieWriter.encodingLiveVideo = YES;
        [_filter addTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = _movieWriter;
        [_movieWriter startRecording];
        
        _mLabelTime = 0;
        _mLabel.hidden = NO;
        [self onTimer:nil];
        _mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    else {
        [sender setTitle:@"录制" forState:UIControlStateNormal];
        NSLog(@"End recording");
        _mLabel.hidden = YES;
        if (_mTimer) {
            [_mTimer invalidate];
        }
        [_filter removeTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = nil;
        [_movieWriter finishRecording];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self compressVideo];
        });
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
        {
            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{

                     if (error) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                         [alert show];
                     } else {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功"
                                                                         message:nil
                                                                        delegate:self
                                                               cancelButtonTitle:@"OK"
                                                               otherButtonTitles:nil];
                         [alert show];



                     }
                 });
             }];
        }
        
    }
}

- (void)updateSliderValue:(UISlider *)sender
{
    //    [(GPUImageSaturationFilter *)filter setSaturation:[sender value]];
}

- (void)compressVideo
{
    //    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *savePath=[cachePath stringByAppendingPathComponent:MOVIEPATH];
    //    NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
    
    
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie6.mp4"];
    NSLog(@"\n pathToMovie %@", pathToMovie);
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    // 通过文件的 url 获取到这个文件的资源
    AVURLAsset *avAsset = [[AVURLAsset alloc] initWithURL:movieURL options:nil];
    // 用 AVAssetExportSession 这个类来导出资源中的属性
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    // 压缩视频
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) { // 导出属性是否包含低分辨率
        // 通过资源（AVURLAsset）来定义 AVAssetExportSession，得到资源属性来重新打包资源 （AVURLAsset, 将某一些属性重新定义
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        // 设置导出文件的存放路径
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        NSDate    *date = [[NSDate alloc] init];
        NSString *outPutPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"output-%@.mp4",[formatter stringFromDate:date]]];
        exportSession.outputURL = [NSURL fileURLWithPath:outPutPath];
        NSLog(@"\n outPutPath %@", outPutPath);
        CMTime start = CMTimeMakeWithSeconds(0.0, 0);
        CMTimeRange range = CMTimeRangeMake(start, [avAsset duration]);
        exportSession.timeRange = range;
        
        //        exportSession.videoComposition;
        
        // 是否对网络进行优化
        exportSession.shouldOptimizeForNetworkUse = true;
        
        // 转换成MP4格式
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        // 开始导出,导出后执行完成的block
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            // 如果导出的状态为完成
            
            NSLog(@"state %zi", exportSession.status);
            
            if ([exportSession status] == AVAssetExportSessionStatusFailed) {
                
                NSLog(@"压缩失败的--%@", exportSession.error);
                
            }
            
            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新一下显示包的大小
                    NSLog(@"压缩后的大小--%@", [NSString stringWithFormat:@"%f MB",[self getfileSize:outPutPath]]);
                });
            }
        }];
    } else {
        NSLog(@"faile ");
    }
}

- (CGFloat)getfileSize:(NSString *)path
{
    NSDictionary *outputFileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSLog (@"file size: %f", (unsigned long long)[outputFileAttributes fileSize]/1024.00 /1024.00);
    return (CGFloat)[outputFileAttributes fileSize]/1024.00 /1024.00;
}

@end
