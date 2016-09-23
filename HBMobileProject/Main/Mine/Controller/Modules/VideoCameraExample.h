//
//  VideoCameraExample.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "GPUImageBeautifyFilter.h"

@interface VideoCameraExample : UIView
{
//    GPUImageVideoCamera *_videoCamera;
//    GPUImageOutput<GPUImageInput> *filter;
//    GPUImageMovieWriter *movieWriter;
//    GPUImageView *filteredVideoView;
//    NSString *pathToMovie;
    CALayer *_focusLayer;
    NSTimer *myTimer;
    UILabel *timeLabel;
    NSDate *fromdate;
    CGRect mainScreenFrame;
}

- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

@end
