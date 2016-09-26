//
//  PreviewVideoView.m
//  scale
//
//  Created by HarbingWang on 16/9/24.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "PreviewVideoView.h"

@implementation PreviewVideoView

{
    AVPlayer *_player;
    AVPlayerLayer * _playerLayer;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        UIButton * remakeBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [self addSubview: remakeBtn];
        remakeBtn.top = self.height - 74;
        remakeBtn.width = 62;
        remakeBtn.height = 74;
        remakeBtn.titleLabel.font = [UIFont systemFontOfSize: 18.f];
        [remakeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [remakeBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [remakeBtn setTitle: STR(@"RePlay") forState: UIControlStateNormal];
        [remakeBtn addTarget: self action: @selector(reMakeVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * useVieoBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [self addSubview: useVieoBtn];
        useVieoBtn.top = self.height - 74;
        useVieoBtn.width = 94;
        useVieoBtn.height = 74;
        useVieoBtn.left = self.width - 94;
        useVieoBtn.titleLabel.font = [UIFont systemFontOfSize: 18.f];
        [useVieoBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [useVieoBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
        [useVieoBtn setTitle: STR(@"UseShortVideo") forState: UIControlStateNormal];
        [useVieoBtn addTarget: self action: @selector(onUseVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma  mark --UIButton
- (void)reMakeVideoBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector: @selector(cancelPreviewVideo)]) {
        [self stopAnything];
        [self.delegate cancelPreviewVideo];
        [self removeFromSuperview];
    }
}
- (void)onUseVideoBtnClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector: @selector(uploadPreviewVideoUrl:)]) {
        [self stopAnything];
        [self.delegate uploadPreviewVideoUrl: _videoPath];
        [self removeFromSuperview];
    }
    
    if (self.delegate && [self.delegate respondsToSelector: @selector(uploadVideoUrl:photoUrl:)]) {
        [self stopAnything];
        _photoPath = [self getPhotoUrlWithVideoUrl:_videoPath];
        [self.delegate uploadVideoUrl:_videoPath photoUrl:_photoPath];
        [self removeFromSuperview];
    }
}

- (void)setVideoPath:(NSURL *)videoPath
{
    _videoPath = videoPath;
    [self addNotificationWithUrl: _videoPath];
}

- (NSURL *)getPhotoUrlWithVideoUrl:(NSURL *)url
{
    if (url == nil) {
        return nil;
    }
    
    UIImage *image = [self getScreenShotImageFromVideoPath:[NSString stringWithFormat:@"%@", url]];
    
    if (image == nil) {
        NSLog(@"获取缩略图失败");
        return nil;
    }else{
    
        //设置录制视频保存的路径
        NSString *pngPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent: @"videoThumbnail.png"];
//        NSString *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/videoThumbnail.png"];
        [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];

        NSURL *thumbnailUrl = [NSURL fileURLWithPath:pngPath];
        NSLog(@"获取缩略图成功: %@", thumbnailUrl);
        return thumbnailUrl;
    }
}

/**
 *  获取视频的缩略图
 *
 *  @param filePath 视频的本地路径
 *
 *  @return 视频截图
 */
- (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL URLWithString:filePath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return shotImage;
}


/**
 *  添加播放器通知
 */
-(void)addNotificationWithUrl:(NSURL *)url{
    //给AVPlayerItem添加播放完成通知
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL: url];
    _player = [AVPlayer playerWithPlayerItem: item];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer: _player];
    
    //    layer.videoGravity=AVLayerVideoGravityResizeAspect;
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _playerLayer.frame = CGRectMake(0, 44.f, ScreenWidth, (ScreenWidth * 4 * 100)/(3*100));
    
    
    [self.layer addSublayer: _playerLayer];
    [_player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object: _player.currentItem];
}
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [_player seekToTime:CMTimeMake(0, 1)];
    [_player play];
}
- (void)stopAnything
{
    [_playerLayer removeFromSuperlayer];
    _player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
-(void)dealloc
{
    [self stopAnything];
}

@end
