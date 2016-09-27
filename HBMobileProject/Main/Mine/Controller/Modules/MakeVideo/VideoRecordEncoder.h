//
//  VideoRecordEncoder.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  数据写入与编码的工具类

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoRecordEncoder : NSObject

/**
 * 视频保存路径
 */
@property (nonatomic, readonly) NSString *path;

/**
 *  VideoRecordEncoder 遍历构造器方法
 *
 *  @param path     媒体存放路径
 *  @param height   视频分辨率的高
 *  @param width    视频分辨率的宽
 *  @param channel  音频通道
 *  @param rate     音频的采样比率
 *
 *  @return VideoRecordEncoder的实体
 */
+ (VideoRecordEncoder *)encoderForPath:(NSString *)path videoHeight:(NSInteger)videoHeight videoWidth:(NSInteger)videoWidth audioChannel:(int)audioChannel audioSamples:(Float64)audioRate;

/**
 *  VideoRecordEncoder 初始化方法
 *
 *  @param path     媒体存放路径
 *  @param height   视频分辨率的高
 *  @param width    视频分辨率的宽
 *  @param channel  音频通道
 *  @param rate     音频的采样比率
 *
 *  @return VideoRecordEncoder的实体
 */
- (instancetype)initVideoRecordPath:(NSString *)path videoHeight:(NSInteger)videoHeight videoWidth:(NSInteger)videoWidth  audioChannel:(int)audioChannel audioSamples:(Float64)audioRate;

/**
 * 录制完成时调用
 *
 * @param handler 录制完成时回调 block
 */
- (void)finishedRecordWithCompletionHandler:(void (^)(void))handler;

/**
 *  写入数据
 *
 *  @param sampleBuffer 要写入的数据
 *  @param isVideo      是否写入的是视频
 *
 *  @return 写入是否成功
 */
- (BOOL)encodeFrame:(CMSampleBufferRef)sampleBuffer isVideo:(BOOL)isVideo;

@end
