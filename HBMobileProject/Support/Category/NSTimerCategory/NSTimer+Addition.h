//
//  NSTimer+Addition.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/28.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

// 添加一个定时器
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

// 启动定时器
- (void)resumeTimer;

// 关闭定时器
- (void)pauseTimer;

@end
