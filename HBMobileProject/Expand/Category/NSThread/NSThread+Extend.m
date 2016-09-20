//
//  NSThread+Extend.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/20.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "NSThread+Extend.h"

@implementation NSThread (Extend)

+ (void)runInMain:(void (^)(void))func
{
    if ([NSThread isMainThread]) {
        func();
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        func();
    });
}

+ (void)runAfter:(void (^)(void))func second:(float)second
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        func();
    });
}

+ (void)runInBackground:(void (^)(void))func
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        func();
    });
}

+ (void)runInBackground:(void (^)(void))func afterSecond:(float)second
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        func();
    });
}

@end
