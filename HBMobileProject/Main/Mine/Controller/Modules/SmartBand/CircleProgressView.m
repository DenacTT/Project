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
#define DegreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

@interface CircleProgressView ()<POPAnimationDelegate>

// 背景层layer
@property (nonatomic, strong) CAShapeLayer *bgCircleLayer;
// 进度层layer
@property (nonatomic, strong) CAShapeLayer *circleLayer;
// 背景图片
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
        self.bgImageView.hidden = NO;
        self.bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.bgImgName]];
    }
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
    }else{
        self.circleLayer.strokeEnd = strokeEnd;
    }
}

#pragma mark - Private methods
- (void)addCircleLayer {
    
    // 背景图片
    self.bgImageView = [[UIImageView alloc] init];
    self.bgImageView.frame = self.bounds;
    self.bgImageView.contentMode = UIViewContentModeCenter;
    self.bgImageView.hidden = YES;
    [self addSubview:self.bgImageView];
    
    // 进度layer层
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    self.circleLayer.strokeEnd = 0;//初始化的时候设置为0,只呈现底色
    [self.layer addSublayer:self.circleLayer];
    
    // 背景layer层
    self.bgCircleLayer = [CAShapeLayer layer];
    self.bgCircleLayer.frame = self.bounds;
    [self.layer addSublayer:self.bgCircleLayer];
}

#pragma mark - 以 facebook pop 动画显示,带弹簧效果
- (void)animateToStrokeEnd:(CGFloat)strokeEnd {
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.delegate = self;
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springSpeed = 2;
    strokeAnimation.springBounciness = 4.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
    
//    strokeAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
//        if (finished) {
//        }
//    };
}

#pragma mark - POPAnimationDelegate
// 动画开始
- (void)pop_animationDidStart:(POPAnimation *)anim
{
    NSLog(@"pop_animationDidStart");
}

// 动画值动态改变
- (void)pop_animationDidApply:(POPAnimation *)anim
{
//    NSLog(@"pop_animationDidApply");
}

// 动画到达终点值
- (void)pop_animationDidReachToValue:(POPAnimation *)anim
{
    NSLog(@"pop_animationDidReachToValue");
}

// 动画结束
- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    NSLog(@"pop_animationDidStop");
    if (finished) {
        if (self.finishedBlock) {
            self.finishedBlock();
        }
    }
}

#pragma mark - 以关键帧动画显示,不带弹簧效果
//- (void)animationWithKeyframeAnimation {
//    
//    // 设置动画属性
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    pathAnimation.calculationMode = kCAAnimationPaced;
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = NO;
//    pathAnimation.duration = 1.f;
//    pathAnimation.repeatCount = 1;
//    
//    CGFloat startAngle = DegreesToRadians(self.startAngle);
//    CGFloat endAngle   = DegreesToRadians(self.endAngle);
//    
//    // 设置动画路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, CGRectGetWidth(self.bounds)/2, startAngle, endAngle, 0);
//    pathAnimation.path = path;
//    CGPathRelease(path);
//    
//    self.circleLayer.cornerRadius = self.circleLayer.frame.size.height / 2;
//    [self.circleLayer addAnimation:pathAnimation forKey:@"moveMarker"];
//}

@end
