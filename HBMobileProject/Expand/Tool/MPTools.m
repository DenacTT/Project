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
        UIWindow *window = [windowArr objectAtIndex:0];
        
        if ([window isKindOfClass:[UIWindow class]])
        {
            return window;
        }
    }
    return nil;
}

@end
