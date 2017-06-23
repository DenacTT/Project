//
//  MPTools.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MPTools : NSObject

/**
 * 获取主Window
 */
+ (UIWindow *)getMainWindow;

/**
 * 获取根控制器
 */
+ (UIViewController *)getRootViewController;

/**
 * 获取视图所在的控制器
 * superView = [self superView]; // self 为当前视图
 */
+ (UIViewController *)viewControllerWithSuperView:(UIView *)superView;

/**
 *  获取视频的缩略图
 *  @param filePath 视频的本地路径
 *  @return 视频截图
 */
+ (UIImage *)getThumbnailImageFromVideoPath:(NSString *)filePath;
@end
