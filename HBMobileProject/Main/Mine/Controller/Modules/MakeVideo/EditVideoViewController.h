//
//  EditVideoViewController.h
//  scale
//
//  Created by HarbingWang on 16/9/21.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  

#import "BaseViewController.h"

@interface EditVideoViewController : BaseViewController

@property (nonatomic, strong) NSURL *videoPath;

@property (nonatomic, strong) NSData *videoData;
@property (nonatomic, strong) UIImage *thumbnailImage;

@end
