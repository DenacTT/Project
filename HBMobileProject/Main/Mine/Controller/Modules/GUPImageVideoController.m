//
//  GUPImageVideoController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/23.
//  Copyright © 2016年 HarbingWang. All rights reserved.

//  GPUImage /usr/local/bin/appledoc: No such file or directory
//  http://stackoverflow.com/questions/34408930/gpuimage-usr-local-bin-appledoc-no-such-file-or-directory

#import "GUPImageVideoController.h"
#import "VideoCameraExample.h"
#import "GPUImage.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "GPUImageBeautifyFilter.h"

@interface GUPImageVideoController ()



@end

@implementation GUPImageVideoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Example 1
//    CGRect frame = [[UIScreen mainScreen] bounds];
//    VideoCameraView *view = [[VideoCameraView alloc] initWithFrame:frame];
//    [self.view addSubview:view];
    
    // Example 2
    CGRect aframe = [[UIScreen mainScreen] bounds];
    VideoCameraExample *videoView = [[VideoCameraExample alloc] initWithFrame:aframe];
    videoView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:videoView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
