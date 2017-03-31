//
//  CAShapeLayerConfigure.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//
//  CAShapeLayer初始化设置基础类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayerConfigure : NSObject

/**
 *  线条宽度
 */
@property (nonatomic) CGFloat lineWidth;

/**
 *  线条填充色
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  线条包围区域填充色
 */
@property (nonatomic, strong) UIColor *fillColor;

/**
 *  端点类型
 *  kCGLineCapButt,     // 无端点
 *  kCGLineCapRound,    // 圆形端点
 *  kCGLineCapSquare    // 方形端点
 */
@property (nonatomic, copy) NSString *lineCap;

/**
 *  lineJoinStyle:交叉点的类型
 *  kCGLineJoinMiter,    // 尖角衔接
 *  kCGLineJoinRound,    // 圆角衔接
 *  kCGLineJoinBevel     // 斜角衔接
 */
@property (nonatomic, copy) NSString *lineJoin;

/**
 *  配置CAShapeLayer
 *  Config the CAShapeLayer
 *
 *  @param shapeLayer CAShapeLayer
 */
- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer;

@end
