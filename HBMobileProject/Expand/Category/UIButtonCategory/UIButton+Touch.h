//
//  UIButton+Touch.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

// ButtonCategory for delayBtn btn延时
@interface UIButton (Touch)

/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end
