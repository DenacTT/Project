//
//  CAShapeLayerConfigure.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CAShapeLayerConfigure.h"

@implementation CAShapeLayerConfigure

- (void)configCAShapeLayer:(CAShapeLayer *)shapeLayer {
    shapeLayer.lineWidth    = self.lineWidth;
    shapeLayer.strokeColor  = (self.strokeColor.CGColor == nil ? [UIColor whiteColor].CGColor : self.strokeColor.CGColor);
    shapeLayer.fillColor    = (self.fillColor.CGColor == nil ? [UIColor blackColor].CGColor : self.fillColor.CGColor);
    shapeLayer.lineCap      = (self.lineCap == nil) ? kCALineCapRound : self.lineCap;
    shapeLayer.lineJoin     = (self.lineJoin == nil) ? kCALineJoinRound : self.lineJoin;
}

@end
