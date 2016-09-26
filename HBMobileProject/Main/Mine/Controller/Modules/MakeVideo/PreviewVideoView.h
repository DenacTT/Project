//
//  PreviewVideoView.h
//  scale
//
//  Created by HarbingWang on 16/9/24.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  预览小视频

#import <UIKit/UIKit.h>
@protocol PreviewVideoDelegate<NSObject>

@optional
- (void)uploadPreviewVideoUrl:(NSURL *)url;
- (void)uploadVideoUrl:(NSURL *)videoUrl photoUrl:(NSURL *)photoUrl;
- (void)cancelPreviewVideo;

@end

@interface PreviewVideoView : UIView

@property (nonatomic, strong) NSURL *videoPath;
@property (nonatomic, strong) NSURL *photoPath;

@property (nonatomic, weak) id<PreviewVideoDelegate>delegate;

@end
