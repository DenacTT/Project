//
//  CircleProgressView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CircleProgressView.h"
#import "POP.h"
#import "StrokeCircleLayerConfigure.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface CircleProgressView ()

@property (nonatomic, strong) CAShapeLayer *bgCircleLayer;
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) UIImageView  *bgImageView;

@end

@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addCircleLayer];
    }
    return self;
}

#pragma mark - Class methods
+ (instancetype)circleProgressViewWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor clockWise:(BOOL)clockWise startAngle:(CGFloat)startAngle {
    
    CircleProgressView *circleProgressView = [[CircleProgressView alloc] initWithFrame:frame];
    circleProgressView.lineWidth  = lineWidth;
    circleProgressView.lineColor  = lineColor;
    circleProgressView.clockWise  = clockWise;
    circleProgressView.startAngle = startAngle;
    
    [circleProgressView makeConfigEffective];
    return circleProgressView;
}

#pragma mark - Instance Methods
- (void)makeConfigEffective {
    
    StrokeCircleLayerConfigure *config = [[StrokeCircleLayerConfigure alloc] init];
    config.circleCenter                = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    config.lineWidth                   = self.lineWidth  == 0 ? 4.f : self.lineWidth;
    config.radius                      = CGRectGetWidth(self.bounds)/2-config.lineWidth;
    
    config.strokeColor                 = self.lineColor  == nil ? [UIColor whiteColor] : self.lineColor;
    config.startAngle                  = self.startAngle == 0 ? 1.5*M_PI : self.startAngle;//1.5*M_PI,默认12点钟位置开始
    config.endAngle                    = self.endAngle   == 0 ? 1.5*M_PI+2*M_PI : self.endAngle;
    config.clockWise                   = self.clockWise  == YES ? YES : NO;//顺时针方向绘制
    [config configCAShapeLayer:self.circleLayer];
    
    if (self.isNeedBackground) {
        StrokeCircleLayerConfigure *bgConfig = [[StrokeCircleLayerConfigure alloc] init];
        bgConfig.circleCenter                = config.circleCenter;
        bgConfig.lineWidth                   = self.bgLineWidth == 0 ? 2.f : self.bgLineWidth;
        bgConfig.strokeColor                 = self.bgLineColor == nil ? RGBA(255, 255, 255, 0.2) : self.bgLineColor;
        bgConfig.radius                      = config.radius+config.lineWidth/2-bgConfig.lineWidth/2;//背景内圆半径
        bgConfig.startAngle                  = config.startAngle;//1.5*M_PI,默认12点钟位置开始
        bgConfig.endAngle                    = config.endAngle;
        bgConfig.clockWise                   = config.clockWise;
        [bgConfig configCAShapeLayer:self.bgCircleLayer];
    }
    
    if (self.isNeedBgImg) {
        if (self.bgImgName == nil) {
            return;
        }
        self.bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.bgImgName]];
    }
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated {
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
}

#pragma mark - Private Instance methods
- (void)addCircleLayer {
    
    // 进度layer层
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    self.circleLayer.strokeEnd = 0;//初始化的时候设置为0,只呈现底色
    [self.layer addSublayer:self.circleLayer];
    
    // 背景layer层
    self.bgCircleLayer = [CAShapeLayer layer];
    self.bgCircleLayer.frame = self.bounds;
    [self.layer addSublayer:self.bgCircleLayer];
    
    self.bgImageView = [[UIImageView alloc] init];
    self.bgImageView.frame = self.bounds;
    [self addSubview:self.bgImageView];
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd {
    
    // facebook pop 动画
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springSpeed = 2;
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

@end
