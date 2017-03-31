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

#pragma mark - Instance Methods
- (void)strokeStart:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    // 异常处理
    if (value <= 0) {
        value = 0;
    }else if (value >= 1){
        value = 1.0f;
    }
    
    if (animated) {
        
        // CAKeyframeAnimation
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeStart";
        keyAnimation.duration             = duration;
        keyAnimation.values               = [YXEasing calculateFrameFromValue:self.circleLayer.strokeStart
                                                                      toValue:value
                                                                         func:func
                                                                   frameCount:duration * 60];
        // Start animation
        self.circleLayer.strokeStart = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // DisalbeActions
        //事务嵌套,用于设置动画变化过程是否显示,默认为YES不显示
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeStart = value;
        [CATransaction setDisableActions:NO];
    }
}

- (void)strokeEnd:(CGFloat)value animationType:(AHEasingFunction)func animated:(BOOL)animated duration:(CGFloat)duration {
    
    // 异常处理
    if (value <= 0) {
        value = 0;
    }else if (value >= 1){
        value = 1.0f;
    }
    
    if (animated) {
        
        // CAKeyframeAnimation
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
        keyAnimation.keyPath              = @"strokeEnd";
        keyAnimation.duration             = duration;
        keyAnimation.values               = [YXEasing calculateFrameFromValue:self.circleLayer.strokeStart
                                                                      toValue:value
                                                                         func:func
                                                                   frameCount:duration * 60];
        // Start animation
        self.circleLayer.strokeStart = value;
        [self.circleLayer addAnimation:keyAnimation forKey:nil];
        
    } else {
        
        // DisalbeActions
        //事务嵌套,用于设置动画变化过程是否显示,默认为YES不显示
        [CATransaction setDisableActions:YES];
        self.circleLayer.strokeStart = value;
        [CATransaction setDisableActions:NO];
    }
}

@end
