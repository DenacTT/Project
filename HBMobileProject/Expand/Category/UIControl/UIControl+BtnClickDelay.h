//
//  UIControl+BtnClickDelay.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/18.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//
//  button 延迟响应

#import <UIKit/UIKit.h>

@interface UIControl (BtnClickDelay)

/** 延迟时间 */
@property(nonatomic)NSTimeInterval jp_acceptEventInterval;

/** 是否接受延迟 */
@property(nonatomic)BOOL jp_ignoreEvent;

@end
