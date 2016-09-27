//
//  VideoTopView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VideoTopViewDelegate<NSObject>

@optional
- (void)cameraBeforeOrAfterChange;//摄像头前后切换

@end


@interface VideoTopView : UIView

@property (nonatomic,weak)id<VideoTopViewDelegate>delegate;
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流

- (NSInteger)getDelaySecond;//获取延时时间

@end
