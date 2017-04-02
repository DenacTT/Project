//
//  LXCircleAnimationView.m
//  Health Management
//
//  Created by Tour on 16/8/9.
//  Copyright © 2016年 Kingdee. All rights reserved.
//

#import "LXCircleAnimationView.h"
#import "UIColor+Extensions.h"
#import "UIView+Extensions.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static const CGFloat kMarkerRadius = 5.f; // 光标直径
static const CGFloat kAnimationTime = 1.f;

@interface LXCircleAnimationView ()

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UIImageView *markerImageView; // 光标
@property (nonatomic, strong) UIImageView *bgImageView; // 背景图片
@property (nonatomic, strong) UILabel *commentLabel; // 中间文字label

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@end

@implementation LXCircleAnimationView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        self.circelRadius = self.frame.size.width - 10.f;
        self.lineWidth = 2.f;

        self.stareAngle = -90.f;
        self.endAngle = 270.f;

        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(6, 6, self.circelRadius, self.circelRadius * 2 / 3);
        [self addSubview:self.bgImageView];

        self.commentLabel.frame = CGRectMake(self.bgImageView.left + self.circelRadius / 4, self.circelRadius / 4, self.circelRadius / 2, self.circelRadius / 2);

        [self initSubView];
    }
    return self;
}

- (void)initSubView {

    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                        radius:(self.circelRadius - self.lineWidth) / 2
                                                    startAngle:degreesToRadians(self.stareAngle)
                                                      endAngle:degreesToRadians(self.endAngle)
                                                     clockwise:YES];
    // 底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = [[UIColor  colorWithWhite:1 alpha:.5] CGColor];
    self.bottomLayer.opacity = 0.5;
    self.bottomLayer.lineCap = kCALineCapRound;
    self.bottomLayer.lineWidth = self.lineWidth;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];

    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomLayer setMask:self.progressLayer];

    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[[UIColor whiteColor] CGColor],
                                   [(id)[UIColor whiteColor] CGColor],
                                   (id)[[UIColor whiteColor] CGColor],
                                   (id)[[UIColor whiteColor] CGColor],
                                   nil]];
    [self.gradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.gradientLayer setMask:self.progressLayer];

    [self.layer addSublayer:self.gradientLayer];

    //
    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                               endAngle:degreesToRadians(self.stareAngle + 360 * 0)];
}

#pragma mark - Animation

- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle { // 光标动画

    // 设置动画属性
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationTime;
    pathAnimation.repeatCount = 1;

    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, (self.circelRadius - kMarkerRadius / 2) / 2, startAngle, endAngle, 0);
    pathAnimation.path = path;
    CGPathRelease(path);

    self.markerImageView.frame = CGRectMake(-100, self.height, kMarkerRadius, kMarkerRadius);
    
    self.markerImageView.layer.cornerRadius = self.markerImageView.frame.size.height / 2;
    
    [self addSubview:self.markerImageView];

    [self.markerImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
}

- (void)circleAnimation { // 弧形动画

    // 复原
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];

    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:kAnimationTime];
    self.progressLayer.strokeEnd = _percent / 100.0;
    [CATransaction commit];
}

#pragma mark - Setters / Getters

- (void)setPercent:(CGFloat)percent {

    [self setPercent:percent animated:YES];
}

- (void)setPercent:(CGFloat)percent animated:(BOOL)animated {

    _percent = percent;
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];

    [self createAnimationWithStartAngle:degreesToRadians(self.stareAngle)
                               endAngle:degreesToRadians(self.stareAngle + 360 * percent / 100)];
}

- (void)setBgImage:(UIImage *)bgImage {

    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}

- (void)setText:(NSString *)text {

    _text = text;
    self.commentLabel.text = text;
}

- (UIImageView *)markerImageView {
    //圆点颜色
    if (nil == _markerImageView) {
        _markerImageView = [[UIImageView alloc] init];
        _markerImageView.backgroundColor = [UIColor whiteColor];
        _markerImageView.alpha = 0.7f;
        _markerImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _markerImageView.layer.shadowOffset = CGSizeMake(0, 0);
        _markerImageView.layer.shadowRadius = 2.5f;
        _markerImageView.layer.shadowOpacity = 1;
    }
    return _markerImageView;
}

- (UIImageView *)bgImageView {

    if (nil == _bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

- (UILabel *)commentLabel {

    if (nil == _commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:20.f];
        _commentLabel.textColor = [UIColor colorWithHex:0x20B2AA];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

@end
