//
//  FillCircleLayerConfigure.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  绘制饼图,实心圆等的配置类

#import "CAShapeLayerConfigure.h"

@interface FillCircleLayerConfigure : CAShapeLayerConfigure

/**
 *  Layer中心点
 */
@property (nonatomic) CGPoint   circleCenter;

/**
 *  内圆半径
 */
@property (nonatomic) CGFloat   radius;

/**
 *  开始角度
 */
@property (nonatomic) CGFloat   startAngle;

/**
 *  结束角度
 */
@property (nonatomic) CGFloat   endAngle;

/**
 *  YES顺时针,NO逆时针
 */
@property (nonatomic) BOOL      clockWise;

@end
