//
//  VideoRecordEncoder.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "VideoRecordEncoder.h"

@interface VideoRecordEncoder()

@property (nonatomic, strong) AVAssetWriter *writer;            // 媒体写入对象
@property (nonatomic, strong) AVAssetWriterInput *videoInput;   // 视频写入对象
@property (nonatomic, strong) AVAssetWriterInput *audioInput;   // 音频写入对象
@property (nonatomic, strong) NSString *path;                   // 媒体写入路径

@end

@implementation VideoRecordEncoder

/**
 *  VideoRecordEncoder 遍历构造器方法
 */
+ (VideoRecordEncoder *)encoderForPath:(NSString *)path videoHeight:(NSInteger)videoHeight videoWidth:(NSInteger)videoWidth audioChannel:(int)audioChannel audioSamples:(Float64)audioRate
{
    VideoRecordEncoder *recoderEncoder = [[VideoRecordEncoder alloc] init];
    return [recoderEncoder initVideoRecordPath:path
                                   videoHeight:videoHeight
                                    videoWidth:videoWidth
                                  audioChannel:audioChannel
                                  audioSamples:audioRate];
}

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
- (instancetype)initVideoRecordPath:(NSString *)path videoHeight:(NSInteger)videoHeight videoWidth:(NSInteger)videoWidth  audioChannel:(int)audioChannel audioSamples:(Float64)audioRate
{
    if (self = [super init]) {
        
        self.path = path;
        
        //先把路径下的文件给删除掉，保证录制的文件是最新的
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        // 创建路径
        NSURL *url = [NSURL fileURLWithPath:self.path];
        
        // 初始化写入媒体类型为 MP4 类型
        _writer = [AVAssetWriter assetWriterWithURL:url fileType:AVFileTypeMPEG4 error:nil];
        // 使其合适在网络上播放
        _writer.shouldOptimizeForNetworkUse = YES;
        
        // 初始化视频输出
        [self initVideoInputHeight:videoHeight videoWidth:videoWidth];
        // 初始化音频输出
        if (audioRate != 0 && audioChannel != 0) {  /* 确保采集到 rate 和 channel */
            [self initAudioInputChannel:audioChannel audioSamples:audioRate];
        }
        
    }
    return self;
}

#pragma mark - 初始化视频输出
- (void)initVideoInputHeight:(NSInteger)videoHeight videoWidth:(NSInteger)videoWidth
{
    //录制视频时的一些配置 : 分辨率,编码方式等
//    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey, [NSNumber numberWithInteger:videoWidth], AVVideoWidthKey, [NSNumber numberWithInteger:videoHeight], AVVideoHeightKey, nil];
    
    // 视频尺寸
    NSInteger numPixels = videoWidth * videoHeight;
    // 每像素比特
    CGFloat bitsPerPixel = 6.0;
    // 数值越大,显示越精细
    NSInteger bitsPerSecond = numPixels * bitsPerPixel;
    
    // 码率和帧率(FPS)设置
    NSDictionary *compressionProperties = @{
                                            AVVideoAverageBitRateKey : @(bitsPerSecond),
                                            AVVideoExpectedSourceFrameRateKey : @(25),
                                            AVVideoAverageBitRateKey : @(25)
                                            };
    // 输出视频压缩设置
    NSDictionary *videoCompressionSettings = @{
                                               AVVideoCodecKey : AVVideoCodecH264,
                                               AVVideoScalingModeKey : AVVideoScalingModeResizeAspectFill,
                                               AVVideoWidthKey : @(videoHeight),
                                               AVVideoHeightKey : @(videoWidth),
                                               AVVideoCompressionPropertiesKey : compressionProperties
                                               };
    
    self.videoInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:videoCompressionSettings];
    // 人像方向;
//    self.videoInput.transform = CGAffineTransformMakeRotation(M_PI_2);
    // 表明输入是否应该调整其处理为实时数据源的数据
    _videoInput.expectsMediaDataInRealTime = YES;
    
    // 将视频加入到输入源
    [_writer addInput:_videoInput];
}

#pragma mark - 初始化音频输出
- (void)initAudioInputChannel:(int)audioChannel audioSamples:(Float64)audioRate
{
    // 音频相关的设置, 主要是 AAC, 音频通道,采样率,以及音频的比特率
    NSDictionary *settings = @{
                               AVFormatIDKey : [NSNumber numberWithInt:kAudioFormatMPEG4AAC],
                               AVNumberOfChannelsKey : [NSNumber numberWithInt:audioChannel],
                               AVSampleRateKey : [NSNumber numberWithFloat:audioRate],
                               AVEncoderBitRateKey : @(128000),
                               };
    
    // 初始化音频写入
    self.audioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:settings];
    _audioInput.expectsMediaDataInRealTime = YES;
    // 将音频添加到输入源
    [_writer addInput:_audioInput];
}

/**
 * 录制完成时调用
 *
 * @param handler 录制完成时回调 block
 */
- (void)finishedRecordWithCompletionHandler:(void (^)(void))handler
{
    [_writer finishWritingWithCompletionHandler:handler];
}

/**
 *  写入数据
 *
 *  @param sampleBuffer 要写入的数据
 *  @param isVideo      是否写入的是视频
 *
 *  @return 写入是否成功
 */
- (BOOL)encodeFrame:(CMSampleBufferRef)sampleBuffer isVideo:(BOOL)isVideo
{
    // 数据是否准备写入
    if (CMSampleBufferDataIsReady(sampleBuffer))
    {
        // 1> 写入状态为未知,保证视频先写入
        if (_writer.status == AVAssetWriterStatusUnknown && isVideo)
        {
            // 获取开始写入的 CMTime
            CMTime startTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
            
            // 开始写入
            [_writer startWriting];
            [_writer startSessionAtSourceTime:startTime];
        }
        
        // 2> 写入状态为失败
        if (_writer.status == AVAssetWriterStatusFailed) {
            NSLog(@"writer error %@", _writer.error.localizedDescription);
            return NO;
        }
        
        // 3> 判断是否写入视频
        if (isVideo) {
            // 视频输入是否准备接受更多的媒体数据
            if (_videoInput.readyForMoreMediaData == YES) {
                // 拼接数据
                [_videoInput appendSampleBuffer:sampleBuffer];
                return YES;
            }
        }else{
            // 音频输入是否准备接受更多的媒体数据
            if (_audioInput.readyForMoreMediaData) {
                // 拼接数据
                [_audioInput appendSampleBuffer:sampleBuffer];
                return YES;
            }
        }
        
    }
    return NO;
}

- (void)dealloc
{
    _writer = nil;
    _path   = nil;
    _audioInput = nil;
    _videoInput = nil;
}

@end
