//
//  CircleView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CircleView.h"
#import "StrokeCircleLayerConfigure.h"

@interface CircleView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createCircleLayer];
    }
    return self;
}

+ (instancetype)circleViewWithFrame:(CGRect)frame lineWidth:(CGFloat)width lineColor:(UIColor *)color
                          clockWise:(BOOL)clockWise startAngle:(CGFloat)angle {
    CircleView *circleView = [[CircleView alloc] initWithFrame:frame];
    circleView.lineWidth = width;
    circleView.lineColor = color;
    circleView.clockWise = clockWise;
    circleView.startAngle = angle;
    [circleView makeConfigEffective];
    return circleView;
}

#pragma mark - Private Instance methods
- (void)createCircleLayer {
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
}

- (void)makeConfigEffective {
    
    CGFloat lineWidth  = (self.lineWidth <= 0 ? 1 : self.lineWidth);
    UIColor *lineColor = (self.lineColor == nil ? [UIColor whiteColor] : self.lineColor);
    CGSize  size       = self.bounds.size;
    CGFloat radius     = self.width/2.f - lineWidth/2.f;
    BOOL    clockWise  = self.clockWise;
    CGFloat startAngle = 0;
    CGFloat endAngle   = 0;
    
    if (clockWise == YES) {
        startAngle = -M_PI;
        endAngle   = M_PI;
    } else {
        startAngle = M_PI;
        endAngle   = -M_PI;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width/2.f, size.height/2.f)
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:clockWise];
    self.circleLayer.path = path.CGPath;
    self.circleLayer.strokeColor = lineColor.CGColor;
    self.circleLayer.fillColor   = [UIColor clearColor].CGColor;
    self.circleLayer.lineWidth   = lineWidth;
    self.circleLayer.strokeEnd   = 0.f;
}

// 度(°)转弧度
- (CGFloat)radianFromDegree:(CGFloat)degree {
    
    return ((M_PI * (degree))/ 180.f);
}

































@end
