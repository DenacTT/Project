//
//  VideoRecordTopView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoRecordTopView : UIView

@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流

- (NSInteger)getDelaySecond;//获取延时时间

@end
