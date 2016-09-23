//
//  VideoCameraView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//


#import "VideoCameraView.h"

@interface VideoCameraView ()<CAAnimationDelegate>

@end

@implementation VideoCameraView

- (instancetype) initWithFrame:(CGRect)frame{
    if (!(self = [super initWithFrame:frame]))
    {
        return nil;
    }
    mainScreenFrame = frame;
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    [videoCamera addAudioInputsAndOutputs];
    
    filter = [[GPUImageSaturationFilter alloc] init];
    filteredVideoView = [[GPUImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [videoCamera addTarget:filter];
    [filter addTarget:filteredVideoView];
    [videoCamera startCameraCapture];
    [self addSomeView];
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cameraViewTapAction:)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    [filteredVideoView addGestureRecognizer:singleFingerOne];
    [self addSubview:filteredVideoView];
    
    return self;
}
- (void) addSomeView{
    UISlider *filterSettingsSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, mainScreenFrame.size.height-50, mainScreenFrame.size.width - 20.0, 40.0)];
    [filterSettingsSlider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    filterSettingsSlider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    filterSettingsSlider.minimumValue = 0.0;
    filterSettingsSlider.maximumValue = 2.0;
    filterSettingsSlider.value = 1.0;
    [filteredVideoView addSubview:filterSettingsSlider];
    
    UIButton *photoCaptureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [photoCaptureButton.layer setCornerRadius:8];
    photoCaptureButton.frame = CGRectMake(20, mainScreenFrame.size.height - 90.0, 50.0, 40.0);
    [photoCaptureButton setTitle:@"开始" forState:UIControlStateNormal];
    photoCaptureButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [photoCaptureButton addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    [photoCaptureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [filteredVideoView addSubview:photoCaptureButton];
    
    UIButton *cameraChangeButton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cameraChangeButton.layer setCornerRadius:8];
    cameraChangeButton.frame = CGRectMake(photoCaptureButton.right + 50, mainScreenFrame.size.height - 90.0, 50.0, 40.0);
    [cameraChangeButton setTitle:@"结束" forState:UIControlStateNormal];
    cameraChangeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [cameraChangeButton addTarget:self action:@selector(stopRecording:) forControlEvents:UIControlEventTouchUpInside];
    [cameraChangeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [filteredVideoView addSubview:cameraChangeButton];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainScreenFrame.size.width-120, cameraChangeButton.top+5, 100, 30.0)];
    timeLabel.font = [UIFont systemFontOfSize:15.0f];
    timeLabel.text = @"00:00:00";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor whiteColor];
    [filteredVideoView addSubview:timeLabel];
}

- (void)updateSliderValue:(UISlider *)sender
{
    [(GPUImageSaturationFilter *)filter setSaturation:[(UISlider *)sender value]];
}

- (void)stopRecording:(UIButton *)sender {
    
    //[filter removeTarget:movieWriter];
    videoCamera.audioEncodingTarget = nil;
    NSLog(@"Path %@",pathToMovie);
    UISaveVideoAtPathToSavedPhotosAlbum(pathToMovie, nil, nil, nil);
    [movieWriter finishRecording];
    
    // 压缩
    dispatch_async(dispatch_get_main_queue(), ^{
        [self compressVideo];
    });
    
    [filter removeTarget:movieWriter];
    timeLabel.text = @"00:00:00";
    [myTimer invalidate];
    myTimer = nil;
}

- (void)startRecording:(UIButton *)sender {
    pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    unlink([pathToMovie UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(360.0, 640.0)];
    
    movieWriter.encodingLiveVideo = YES;
    movieWriter.shouldPassthroughAudio = YES;
    [filter addTarget:movieWriter];
    videoCamera.audioEncodingTarget = movieWriter;
    [movieWriter startRecording];
    NSTimeInterval timeInterval =1.0;
    fromdate = [NSDate date];
    myTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                               target:self
                                             selector:@selector(updateTimer:)
                                             userInfo:nil
                                              repeats:YES];
}

- (void)updateTimer:(NSTimer *)sender{
    NSDateFormatter *dateFormator = [[NSDateFormatter alloc] init];
    dateFormator.dateFormat = @"HH:mm:ss";
    NSDate *todate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:fromdate toDate:todate options:NSCalendarWrapComponents];
    //NSInteger hour = [comps hour];
    //NSInteger min = [comps minute];
    //NSInteger sec = [comps second];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *timer = [gregorian dateFromComponents:comps];
    NSString *date = [dateFormator stringFromDate:timer];
    timeLabel.text = date;
}

- (void)setfocusImage{
    UIImage *focusImage = [UIImage imageNamed:@"focusImage"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, focusImage.size.width, focusImage.size.height)];
    imageView.image = focusImage;
    CALayer *layer = imageView.layer;
    layer.hidden = YES;
    [filteredVideoView.layer addSublayer:layer];
    _focusLayer = layer;
}

- (void)layerAnimationWithPoint:(CGPoint)point {
    if (_focusLayer) {
        CALayer *focusLayer = _focusLayer;
        focusLayer.hidden = NO;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [focusLayer setPosition:point];
        focusLayer.transform = CATransform3DMakeScale(2.0f,2.0f,1.0f);
        [CATransaction commit];
        
        
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
        animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0f,1.0f,1.0f)];
        animation.delegate = self;
        animation.duration = 0.3f;
        animation.repeatCount = 1;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [focusLayer addAnimation: animation forKey:@"animation"];
        
        // 0.5秒钟延时
        [self performSelector:@selector(focusLayerNormal) withObject:self afterDelay:0.5f];
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}

- (void)focusLayerNormal {
    filteredVideoView.userInteractionEnabled = YES;
    _focusLayer.hidden = YES;
}

-(void)cameraViewTapAction:(UITapGestureRecognizer *)tgr
{
    if (tgr.state == UIGestureRecognizerStateRecognized && (_focusLayer == NO || _focusLayer.hidden)) {
        CGPoint location = [tgr locationInView:filteredVideoView];
        [self setfocusImage];
        [self layerAnimationWithPoint:location];
        AVCaptureDevice *device = videoCamera.inputCamera;
        CGPoint pointOfInterest = CGPointMake(0.5f, 0.5f);
        NSLog(@"taplocation x = %f y = %f", location.x, location.y);
        CGSize frameSize = [filteredVideoView frame].size;
        
        if ([videoCamera cameraPosition] == AVCaptureDevicePositionFront) {
            location.x = frameSize.width - location.x;
        }
        
        pointOfInterest = CGPointMake(location.y / frameSize.height, 1.f - (location.x / frameSize.width));
        
        
        if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            NSError *error;
            if ([device lockForConfiguration:&error]) {
                [device setFocusPointOfInterest:pointOfInterest];
                
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                
                if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
                {
                    
                    [device setExposurePointOfInterest:pointOfInterest];
                    [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
                }
                
                [device unlockForConfiguration];
                
                NSLog(@"FOCUS OK");
            } else {
                NSLog(@"ERROR = %@", error);
            }
        }
    }
}

- (void)compressVideo
{
    //    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *savePath=[cachePath stringByAppendingPathComponent:MOVIEPATH];
    //    NSURL *saveUrl=[NSURL fileURLWithPath:savePath];
    
    
    NSString *moviePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
    NSLog(@"\n pathMovie %@", moviePath);
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
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
                NSLog(@"压缩失败! error :%@", exportSession.error);
            }
            
            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新一下显示包的大小
                    NSLog(@"压缩后的大小 : %@", [NSString stringWithFormat:@"%f MB",[self getfileSize:outPutPath]]);
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
