//
//  NSTimer+Addition.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/28.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

// 添加一个定时器
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

// 启动定时器
- (void)resumeTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];// 继续
}

// 关闭定时器
- (void)pauseTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]]; // 暂停
}

@end
