//
//  StrokeCircleLayerConfigure.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//  绘制圆弧的配置类

#import "CAShapeLayerConfigure.h"

@interface StrokeCircleLayerConfigure : CAShapeLayerConfigure

/**
 *  Layer中心点位置
 */
@property (nonatomic) CGPoint circleCenter;

/**
 * 内圆半径
 */
@property (nonatomic) CGFloat radius;

/**
 *  起始角度
 */
@property (nonatomic) CGFloat startAngle;

/**
 *  终止角度
 */
@property (nonatomic) CGFloat endAngle;

/**
 * YES,顺时针方向. NO,逆时针方向
 */
@property (nonatomic) BOOL clockWise;

@end
