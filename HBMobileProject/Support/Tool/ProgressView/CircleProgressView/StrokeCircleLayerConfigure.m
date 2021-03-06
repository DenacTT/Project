//
//  StrokeCircleLayerConfigure.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "StrokeCircleLayerConfigure.h"

@implementation StrokeCircleLayerConfigure

- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer {
    self.fillColor = [UIColor clearColor];
    [super configCAShapeLayer:shapeLayer];
    
    shapeLayer.bounds = CGRectMake(0, 0, (self.lineWidth+self.radius)*2, (self.lineWidth+self.radius)*2);
    shapeLayer.position = self.circleCenter;
              
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.lineWidth+self.radius, self.lineWidth+self.radius)
                                                        radius:self.radius+self.lineWidth/2.f
                                                    startAngle:self.startAngle
                                                      endAngle:self.endAngle
                                                     clockwise:self.clockWise];
    shapeLayer.path = path.CGPath;
}

@end
