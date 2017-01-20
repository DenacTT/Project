//
//  NSThread+Extend.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/20.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (Extend)

+ (void)runInMain:(void (^)(void))func;

+ (void)runAfter:(void (^)(void))func second:(float)second;

+ (void)runInBackground:(void (^)(void))func;

+ (void)runInBackground:(void (^)(void))func afterSecond:(float)second;

@end
