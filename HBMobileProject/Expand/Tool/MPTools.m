//
//  MPTools.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MPTools.h"

@implementation MPTools

/**
 * 获取 Window
 */
+ (UIWindow *)getMainWindow
{
    NSArray *windowArr = [[UIApplication sharedApplication] windows];
    if (windowArr && [windowArr count]>0)
    {
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        
        if ([window isKindOfClass:[UIWindow class]])
        {
            return window;
        }
    }
    return nil;
}

/*
 * 获取根控制器
 */
+ (UIViewController *)getRootViewController
{
    UIViewController *rootVC = [[self getMainWindow] rootViewController];
    UIViewController *topVC = rootVC;
    
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 * 获取视图所在的控制器
 */
+ (UIViewController *)viewControllerWithSuperView:(UIView *)superView; {
    for (UIView *next = superView; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
