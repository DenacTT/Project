//
//  VideoRecordEngine.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  视频录制的工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>

@protocol RecordEngineDelegate <NSObject>

@optional
- (void)recordProgress:(CGFloat)progress;

@end

@interface VideoRecordEngine : NSObject

@property (atomic, assign, readonly) BOOL isCapturing;   // 正在录制
@property (atomic, assign, readonly) BOOL isPaused;      // 是否暂停
@property (atomic, assign, readonly) CGFloat currentRecordTime;  // 当前录制时间
@property (atomic, strong) NSString *videoPath;         // 视频路径
@property (atomic, assign) CGFloat maxRecordTime;       // 录制最长时间
@property (nonatomic, weak) id<RecordEngineDelegate>delegate;

//捕获到视频呈现的layer
- (AVCaptureVideoPreviewLayer *)previewLayer;

//启动录制功能
- (void)startUp;

//关闭录制功能
- (void)shutdown;

//开始录制
- (void)startCapture;

//暂停录制
- (void)pauseCapture;

//继续录制
- (void)resumeCapture;

//停止录制回调
- (void)stopCaptureHandler:(void (^)(UIImage *movieImage))handler;

//开启闪光灯
- (void)openFlashLight;

//关闭闪光灯
- (void)closeFlashLight;

//切换前后置摄像头
- (void)changeCameraInputDeviceisFront:(BOOL)isFront;

//将mov的视频转成mp4
- (void)changeMovToMp4:(NSURL *)mediaURL dataBlock:(void (^)(UIImage *movieImage))handler;

@end
