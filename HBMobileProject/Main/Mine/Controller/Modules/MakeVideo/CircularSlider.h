//
//  CircularSlider.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//  弧形进度条

#import <UIKit/UIKit.h>

// 填充色值
#define FillColor [UIColor whiteColor]
// 未填充时的色值
#define unFillColor RGB(65, 65, 65)

@interface CircularSlider : UIView

@property (nonatomic,assign)BOOL isStrokeEndMax;

- (instancetype)initWithRadius:(CGFloat)radius;

// 开始圆周运动
- (void)strokeEndNumberChange;

// 还原
- (void)returnCircularStroke;

@end
