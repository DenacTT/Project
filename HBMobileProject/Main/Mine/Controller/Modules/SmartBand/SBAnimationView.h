//
//  SBAnimationView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBAnimationView : UIView

// 进度条线宽
@property (nonatomic, assign) CGFloat lineWidth;

// 进度条颜色
@property (nonatomic, strong) UIColor *strokeColor;

// 进度
@property (nonatomic, assign) CGFloat progress;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
