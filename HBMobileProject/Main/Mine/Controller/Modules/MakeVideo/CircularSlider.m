//
//  CircularSlider.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/27.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "CircularSlider.h"

@implementation CircularSlider
{
    CAShapeLayer *_shapeLayer;
}

- (instancetype)initWithRadius:(CGFloat)radius
{
    self = [super initWithFrame:CGRectMake(0, 0, radius, radius)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self drawBackGroundProgress];
        [self drawPercentageProgress];
    }
    return self;
}

- (void)drawBackGroundProgress
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.frame;
    layer.position = self.center;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    layer.lineWidth = 5.f;
    layer.strokeColor = unFillColor.CGColor;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.frame];
    layer.path = circlePath.CGPath;
    [self.layer addSublayer:layer];
}

- (void)drawPercentageProgress
{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.frame;
    _shapeLayer.position = self.center;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    _shapeLayer.lineWidth = 5.f;
    _shapeLayer.strokeColor = FillColor.CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.height/2 startAngle: -M_PI_2 endAngle:2*M_PI-M_PI_2 clockwise:YES];
    circlePath.lineCapStyle = kCGLineCapRound;
    circlePath.lineJoinStyle = kCGLineCapRound;
    
    _shapeLayer.path = circlePath.CGPath;
    _shapeLayer.strokeStart = 0;
    _shapeLayer.strokeEnd = 0;
    [self.layer addSublayer:_shapeLayer];
}

- (void)strokeEndNumberChange
{
    if (_shapeLayer.strokeEnd <= 1) {
        _shapeLayer.strokeEnd += 0.01;
    }
    if (_shapeLayer.strokeEnd >1) {
        _isStrokeEndMax = YES;
    }
}

- (void)returnCircularStroke
{
    _shapeLayer.strokeEnd = 0;
}

@end
