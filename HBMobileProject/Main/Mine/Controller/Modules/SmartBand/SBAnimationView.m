//
//  SBAnimationView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBAnimationView.h"

@interface SBAnimationView ()

@property (nonatomic, strong) UIView *animationView;

@end

@implementation SBAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
    [self addSubview:self.animationView];
}

// 创建圆形Layer
- (void)createCircularLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.lineWidth = 2.f;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = RGBA(255, 255, 255, 0.2).CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:layer.frame];
    layer.path = path.CGPath;
    
    [self.layer addSublayer:layer];
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animation:(BOOL)animation {
    if (animation) {
        
    }
}

#pragma mark - Setter
//- (void)setProgress:(CGFloat)progress {
//    _progress = progress;
//    if (progress) {
//        [self animateViewWithProgress:progress];
//    }
//}
//
//- (void)animateViewWithProgress:(CGFloat)progress {
//    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:0 animations:^{
//        [self layoutIfNeeded];
//        self.animationView.backgroundColor = RGB(46, 204, 113);
//    } completion:NULL];
//}

#pragma mark - Getter
- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:self.bounds];
        _animationView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _animationView.backgroundColor = [UIColor clearColor];
    }
    return _animationView;
}

@end
