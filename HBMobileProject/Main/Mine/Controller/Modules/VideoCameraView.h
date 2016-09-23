//
//  VideoCameraView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCameraView : UIView
{
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageMovieWriter *movieWriter;
    NSString *pathToMovie;
    GPUImageView *filteredVideoView;
    CALayer *_focusLayer;
    NSTimer *myTimer;
    UILabel *timeLabel;
    NSDate *fromdate;
    CGRect mainScreenFrame;
}
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
