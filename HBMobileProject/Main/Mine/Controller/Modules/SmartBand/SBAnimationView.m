//
//  SBAnimationView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBAnimationView.h"
#import "POP.h"
#import "StrokeCircleLayerConfigure.h"

@interface SBAnimationView ()

@property(nonatomic) CAShapeLayer *circleLayer;

@end

@implementation SBAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addCircleLayer];
    }
    return self;
}

#pragma mark - Property Setters
- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

#pragma mark - Instance Methods
- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated {
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
}

#pragma mark - Private Instance methods
- (void)addCircleLayer {
    
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.strokeEnd = 0;//初始化的时候设置为0,只呈现底色
    
    StrokeCircleLayerConfigure *config = [[StrokeCircleLayerConfigure alloc] init];
    config.circleCenter                = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    config.radius                      = CGRectGetWidth(self.bounds)/2-4;
    config.lineWidth                   = 4.f;
    
    config.strokeColor                 = [UIColor whiteColor];
    config.startAngle                  = 1.5*M_PI;  //12点钟位置开始
    config.endAngle                    = 1.5*M_PI+2*M_PI;
    config.clockWise                   = YES;       //顺时针方向绘制
    
    [config configCAShapeLayer:self.circleLayer];
    [self.layer addSublayer:self.circleLayer];
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd {
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

#pragma mark - Setter
//- (void)setProgress:(CGFloat)progress {
//    _progress = progress;
//    if (progress) {
//        [self animateViewWithProgress:progress];
//    }
//}

//- (void)animateViewWithProgress:(CGFloat)progress {
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:0 animations:^{
//        [self layoutIfNeeded];
//        self.animationView.backgroundColor = RGB(46, 204, 113);
//    } completion:NULL];
//}

#pragma mark - Getter
@end
