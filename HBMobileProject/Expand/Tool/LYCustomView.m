//
//  LYCustomView.m
//  scale
//
//  Created by 李钰 on 16/7/21.
//  Copyright © 2016年 李钰. All rights reserved.
//

#import "LYCustomView.h"
#import "NSString+Extend.h"
#import "UIImageView+WebCache.h"
@implementation LYCustomView
{
    UILabel * _labelTitle;//标题label
}
#pragma mark - 带参数的控件（没有点击事件，能修改颜色、标题等等）
- (id)initStandardViewForRadius:(CGFloat)radius TitleColor:(UIColor *)color Font:(UIFont *)font
{
    if ([super init]) {
        self.layer.cornerRadius = radius;
        self.backgroundColor = RGB(75, 214, 99);
        _labelTitle = [UILabel new];
        [self addSubview: _labelTitle];
        _labelTitle.textColor = color;
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.font = font;
        self.title = @"标准";
    }
    return self;
}
#pragma mark - setter
- (void)setTitle:(NSString *)title
{
//    CGSize size = [title YMSizeWithFont: _labelTitle.font];
//    self.width = size.width + 10.f;
//    self.height = size.height + 2.f;
    _labelTitle.width = self.width;
    _labelTitle.height = self.height;
    _labelTitle.text = title;
}
#pragma mark - 展示样式（只能修改位置）
//创建一个圆 作为背景
- (id)initRadius:(CGFloat)radius Color:(UIColor *)color
{
    if ([super init]) {
        self.width = radius;
        self.height = radius;
        self.backgroundColor = color;
        self.layer.cornerRadius = radius/2;
    }
    return self;
}
//图片居中 圆作背景 （radius > image.size.height）enabled是否响应事件
- (id)initRadius:(CGFloat )radius Color:(UIColor *)color Image:(UIImage *)image
{
    if ([super init]) {
        self.width = radius;
        self.height = radius;
        self.backgroundColor = color;
        self.layer.cornerRadius = radius/2;
        
        UIImageView * imageView = [[UIImageView alloc]initWithImage: image];
        [self addSubview: imageView];
        imageView.width = image.size.width;
        imageView.height = image.size.height;
        imageView.left = (self.width - imageView.width)/2;
        imageView.top = (self.height - imageView.height)/2;
        imageView.layer.cornerRadius = imageView.width/2;
    }
    return self;
}
//加载头像radius为头像宽度 url为头像url title为nil没有title 否则显示title
- (id)initWithRadius:(CGFloat)radius AndUrl:(NSString *)url AndTitle:(NSString *)title
{
    if ([super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.width = radius + 2.f;

        UIView * radiusBg = [[UIView alloc]initWithFrame: CGRectMake(0, 0, self.width, self.width)];
        [self addSubview: radiusBg];
        radiusBg.backgroundColor = RGB(167, 229, 222);
        radiusBg.layer.cornerRadius = self.width/2.f;
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(1.f, 1.f, radius, radius)];
        imageView.userInteractionEnabled = YES;
        [radiusBg addSubview: imageView];
        imageView.layer.cornerRadius = imageView.width/2.f;
        [imageView sd_setImageWithURL: [NSURL URLWithString: url] placeholderImage: [UIImage imageNamed: @"YMLoadDefaultMax"] options: SDWebImageRetryFailed|SDWebImageContinueInBackground|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                imageView.image = image;
            }else{
                imageView.image = [UIImage imageNamed: @"YMLoadDefaultMax"];
            }
        }];
        if (nil == title) {
            self.height = radius + 2.f;
        }else{
            UILabel * labelName = [[UILabel alloc]initWithFrame: CGRectMake(0, imageView.bottom + 5.f, self.width, 14.f)];
            [self addSubview: labelName];
            labelName.text = title;
            labelName.font = [UIFont systemFontOfSize: 12.f];
            labelName.textAlignment = NSTextAlignmentCenter;
            labelName.textColor = [UIColor blackColor];
            self.height = labelName.bottom;
        }
    }
    return self;
}
//分割线
- (id)initLineViewWithWidth:(CGFloat)width
{
    if ([super init]) {
        self.width = width;
        self.height = 0.5f;
        self.backgroundColor = RGBA(0, 0, 0, 0.1);
    }
    return self;
}
- (id)initLineViewWithHeight:(CGFloat)height
{
    if ([super init]) {
        self.height = height;
        self.width = 0.5f;
        self.backgroundColor = RGBA(0, 0, 0, 0.1);
    }
    return self;
}
#pragma mark -动画
//爱心运动 color圆球的背景颜色 offset为正颜色递增 为负递减 为0则不变
- (id)initLoveReplicatorWithColor:(UIColor *)color Offset:(CGFloat)offset
{
    if ([super init]) {
        self.width = 250;
        self.height = 200;
        CGFloat topPointX = self.width * 0.5;
        CGFloat topPointY = 100;
        CGFloat bottomPointY = self.height;
        CGFloat rigthControlPointX = self.width;
        CGFloat rigthControlPointY = 50;//改变爱心的形状
        CGFloat leftControlPointX = 0;
        
        //具体的layer
        CAShapeLayer *loveShapeLayer = [CAShapeLayer layer];
        loveShapeLayer.bounds = CGRectMake(0, 0, 10, 10);
        loveShapeLayer.position = CGPointMake(topPointX, topPointY);
        loveShapeLayer.cornerRadius = 5;
        loveShapeLayer.masksToBounds = YES;
        loveShapeLayer.backgroundColor = color.CGColor;
        
        //爱心路径
        UIBezierPath *circlePath = [UIBezierPath bezierPath];
        [circlePath moveToPoint:CGPointMake(topPointX, topPointY)];
        [circlePath addQuadCurveToPoint:CGPointMake(topPointX, bottomPointY) controlPoint:CGPointMake(rigthControlPointX, rigthControlPointY)];
        [circlePath addQuadCurveToPoint:CGPointMake(topPointX, topPointY) controlPoint:CGPointMake(leftControlPointX, rigthControlPointY)];
        [circlePath closePath];
        
        // 动作效果
        CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        loveAnimation.path = circlePath.CGPath;
        loveAnimation.duration = 8;
        loveAnimation.repeatCount = MAXFLOAT;
        [loveShapeLayer addAnimation:loveAnimation forKey:nil];
        
        CAReplicatorLayer *loveReplicatorLayer = [CAReplicatorLayer layer];
        loveReplicatorLayer.instanceCount = 40; // 40个layer
        loveReplicatorLayer.instanceDelay = 0.2; // 每隔0.2出现一个layer
        loveReplicatorLayer.instanceColor = color.CGColor;
        loveReplicatorLayer.instanceGreenOffset = offset;       // 颜色值递减。
        loveReplicatorLayer.instanceRedOffset = offset;         // 颜色值递减。
        loveReplicatorLayer.instanceBlueOffset = offset;        // 颜色值递减。
        [loveReplicatorLayer addSublayer:loveShapeLayer];
        [self.layer addSublayer:loveReplicatorLayer];
    }
    return self;
}
//波动的音乐 √count为数量 color为单个背景颜色
- (id)initMusicReplicatorWithCount:(NSInteger)count musicBackgroundColor:(UIColor *)color
{
    if ([super init]) {
        self.width = 200;
        self.height = 200;
        CAReplicatorLayer *musicReplicatorLayer = [CAReplicatorLayer layer];
        musicReplicatorLayer.frame = self.frame;
//        musicReplicatorLayer.position = CGPointMake(self.center.x, self.center.y - 70);
        musicReplicatorLayer.instanceCount = count;
        musicReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0); //每个layer的间距。
        musicReplicatorLayer.instanceDelay = 0.2;
//        musicReplicatorLayer.backgroundColor = [UIColor greenColor].CGColor;
        musicReplicatorLayer.masksToBounds = YES;
        [self.layer addSublayer: musicReplicatorLayer];
        
        CGFloat musicLayerY = musicReplicatorLayer.bounds.size.height - 50;
        CALayer *musicLayer = [CALayer layer];
        musicLayer.frame = CGRectMake(20, musicReplicatorLayer.bounds.size.height - 50, 10, 50);
        musicLayer.anchorPoint = CGPointMake(0, 0);
        musicLayer.backgroundColor = color.CGColor;
        [musicReplicatorLayer addSublayer:musicLayer];
        
        CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        musicAnimation.duration = 0.35;
        musicAnimation.fromValue = @(musicLayerY);
        musicAnimation.toValue = @(musicLayerY + 30);
        musicAnimation.autoreverses = YES;
        musicAnimation.repeatCount = MAXFLOAT;
        [musicLayer addAnimation:musicAnimation forKey:nil];
    }
    return self;
}
//等待动画
- (id)initActivityAnimationWithBackgroundColor:(UIColor *)bgColor BorderColor:(UIColor *)borderColor
{
    if ([super init]) {
        self.width = 200;
        self.height = 200;
        CALayer *indicatorLayer = [CALayer layer];
        indicatorLayer.bounds = CGRectMake(0, 0, 10, 10);
        indicatorLayer.position = CGPointMake(100, 40);
        indicatorLayer.backgroundColor = bgColor.CGColor;
        indicatorLayer.borderWidth = 1;
        indicatorLayer.transform = CATransform3DMakeScale(0, 0, 0);
        indicatorLayer.borderColor = borderColor.CGColor;
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.0;
        scaleAnimation.toValue = @0.1;
        scaleAnimation.duration = 1.5;
        scaleAnimation.repeatCount = MAXFLOAT;
        [indicatorLayer addAnimation:scaleAnimation forKey:nil];
        
        CAReplicatorLayer *indicatorReplicatorLayer = [CAReplicatorLayer layer];
//        indicatorReplicatorLayer.bounds = CGRectMake(0, 0, 200, 200);
//        indicatorReplicatorLayer.position = CGPointMake(self.center.x, self.center.y + 100);
        indicatorReplicatorLayer.frame = CGRectMake(0, 30, self.width, self.width);
        //    indicatorReplicatorLayer.backgroundColor = [UIColor yellowColor].CGColor;
        indicatorReplicatorLayer.instanceCount = 15;
        CGFloat angle = (2 * M_PI) / 15;
        indicatorReplicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0);
        indicatorReplicatorLayer.instanceDelay = 1.5 / 15;
        [indicatorReplicatorLayer addSublayer:indicatorLayer];
        [self.layer addSublayer:indicatorReplicatorLayer];
    }
    return self;
}
//路径动画
- (id)initFollowAnimation
{
    if ([super init]) {
        self.width = ScreenWidth;
        self.height = ScreenHeight;
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.bounds = self.bounds;
        replicatorLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75].CGColor;
        replicatorLayer.position = self.center;
        [self.layer addSublayer:replicatorLayer];
        
        CALayer *subLayer = [CALayer new];
        subLayer.bounds = CGRectMake(0, 0, 10, 10);
        subLayer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        subLayer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
        subLayer.borderWidth = 1.0;
        subLayer.cornerRadius = 5.0;
        subLayer.shouldRasterize = YES;
        subLayer.rasterizationScale = [UIScreen mainScreen].scale;
        [replicatorLayer addSublayer:subLayer];
        
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnimation.path = [self path];
        moveAnimation.repeatCount = MAXFLOAT;
        moveAnimation.duration = 4.0;
        [subLayer addAnimation:moveAnimation forKey:nil];
        
        replicatorLayer.instanceDelay = 0.1;
        replicatorLayer.instanceCount = 20;
        replicatorLayer.instanceColor = [UIColor greenColor].CGColor;
        replicatorLayer.instanceGreenOffset = -0.03;

    }
    return self;
}
- (CGPathRef)path
{
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint:(CGPointMake(31.5, 78.5))];
    [bezierPath addLineToPoint:(CGPointMake(31.5, 23.5))];
    [bezierPath addCurveToPoint:CGPointMake(58.5, 38.5) controlPoint1:CGPointMake(31.5, 23.5) controlPoint2:CGPointMake(62.46, 18.69)];
    [bezierPath addCurveToPoint:CGPointMake(53.5, 45.5) controlPoint1:CGPointMake(57.5, 43.5) controlPoint2:CGPointMake(53.5, 45.5)];
    [bezierPath addLineToPoint:(CGPointMake(43.5, 48.5))];
    [bezierPath addLineToPoint:(CGPointMake(53.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake(62.5, 51.5))];
    [bezierPath addLineToPoint:(CGPointMake(70.5, 66.5))];
    [bezierPath addLineToPoint:(CGPointMake( 86.5, 23.5))];
    [bezierPath addLineToPoint:(CGPointMake(86.5, 78.5))];
    //    [bezierPath addLineToPoint:(CGPointMake(31.5, 78.5))];
    //    [bezierPath addLineToPoint:(CGPointMake(31.5, 71.5))];
    [bezierPath closePath];
    
    CGAffineTransform T = CGAffineTransformMakeScale(4.0, 4.0);
    return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &T);
}
//单个圆动画
- (id)initRadiusAnimationWithColor:(UIColor *)color
{
    if ([super init]) {
        self.width = 200;
        self.height = 200;
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
//        replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
//        replicatorLayer.position = CGPointMake(100, 170);
        replicatorLayer.frame = self.bounds;
        [self.layer addSublayer:replicatorLayer];
//        replicatorLayer.backgroundColor = [UIColor yellowColor].CGColor;
        CAShapeLayer *subLayer = [CAShapeLayer layer];
        subLayer.bounds = CGRectMake(0, 0, 40, 40);
        
        subLayer.cornerRadius = 20;
        subLayer.position = CGPointMake(self.width/2, self.height/2);
        subLayer.backgroundColor = color.CGColor;
        [replicatorLayer addSublayer:subLayer];
        
        CAAnimationGroup *groupAnimtion = [CAAnimationGroup animation];
        groupAnimtion.animations = @[[self scaleAnimation], [self alphaAnimation]];
        groupAnimtion.repeatCount = MAXFLOAT;
        groupAnimtion.duration = 4.0;
        [subLayer addAnimation:groupAnimtion forKey:nil];
        
        replicatorLayer.instanceCount = 10;
        replicatorLayer.instanceDelay = 4.0 / 10;

    }
    return self;
}
//多个圆动画 color圆的颜色 count圆的数量（连成一排）
- (id)initRadiusMoreAnimationWithColor:(UIColor *)color Count:(NSInteger)count
{
    if ([super init]) {
        self.width = 200;
        self.height = 200;
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame = self.bounds;
        [self.layer addSublayer:replicatorLayer];
        
        CAShapeLayer *subLayer = [CAShapeLayer layer];
//        subLayer.bounds = CGRectMake(0, 0, 40, 40);
        subLayer.cornerRadius = 20;
//        subLayer.position = CGPointMake(self.width/2, self.height/2);
        subLayer.frame = CGRectMake(0, (self.height-40)/2, 40, 40);
        subLayer.backgroundColor = color.CGColor;
        [replicatorLayer addSublayer:subLayer];
        [subLayer addAnimation:[self scaleAnimation2:0.5] forKey:nil];
        
        replicatorLayer.instanceCount = count;
        replicatorLayer.instanceDelay = 0.1;
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(50, 0, 0);
    }
    return self;
}
//三个圆旋转
- (id)initRadiusScaleAnimationWithColor:(UIColor *)color
{
    if ([super init]) {
        CGFloat radius = 100 / 4;
        CGFloat transX = 100 - radius;
        self.width = radius;
        self.height = radius;
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        replicatorLayer.frame =self.bounds;
        [self.layer addSublayer:replicatorLayer];
        
        CAShapeLayer *subLayer = [CAShapeLayer layer];
        subLayer.frame = CGRectMake(0, 0, radius, radius);
        subLayer.cornerRadius = radius * 0.5;
        subLayer.backgroundColor = color.CGColor;
        [replicatorLayer addSublayer:subLayer];
        [subLayer addAnimation:[self rotationAnimation:transX] forKey:nil];
        
        replicatorLayer.instanceDelay = 0.0;
        replicatorLayer.instanceCount = 3;
        CATransform3D trans3D = CATransform3DIdentity;
        trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
        trans3D = CATransform3DRotate(trans3D, 120 * M_PI / 180.0, 0, 0, 1.0);
        replicatorLayer.instanceTransform = trans3D;

    }
    return self;
}
//n个圆滚动动画
- (id)initRadiusAnyAnimationWithColor:(UIColor *)color
{
    if ([super init]) {
        self.width = 200;
        self.height = 200;
        CGFloat margin = 5;
        CGFloat column = 5;
        CGFloat width = 200;
        CGFloat radius = (width - (column - 1) * margin) / column;
        
        CAShapeLayer *subLayer = [CAShapeLayer layer];
        subLayer.frame = CGRectMake(0, 0, radius, radius);
        subLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
        subLayer.fillColor = color.CGColor;
        
        CAAnimationGroup *groupAnimtion = [CAAnimationGroup animation];
        groupAnimtion.animations = @[[self scaleAnimation2:0], [self alphaAnimation]];
        groupAnimtion.repeatCount = MAXFLOAT;
        groupAnimtion.duration = 1;
        groupAnimtion.autoreverses = YES;
        [subLayer addAnimation:groupAnimtion forKey:nil];
        
        CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
        //    replicatorLayerX.backgroundColor = [UIColor blueColor].CGColor;
//        replicatorLayerX.bounds = CGRectMake(0, 0, width, radius);
//        replicatorLayerX.position = self.center;
        replicatorLayerX.frame = self.bounds;
        replicatorLayerX.instanceCount = column;
        replicatorLayerX.instanceDelay = 1 / 5.0;
        replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius + margin, 0, 0);
        [replicatorLayerX addSublayer:subLayer];
        
        CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
        //    replicatorLayerY.frame = CGRectMake(50, 150, width, width);
        replicatorLayerY.instanceCount = column;
        replicatorLayerY.instanceDelay = 1 / 5.0;
        replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius + margin, 0);
        [replicatorLayerY addSublayer:replicatorLayerX];
        
        [self.layer addSublayer:replicatorLayerY];

    }
    return self;
}
- (CABasicAnimation *)rotationAnimation:(CGFloat)transX {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0, 0, 0, 0);
    rotationAnimation.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0, 0);
    //    toValue = CATransform3DRotate(toValue, 120.0 * M_PI / 180.0, 0, 0, 1);
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:toValue];
    
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 0.8;
    //    rotationAnimation.autoreverses = YES;
    
    return rotationAnimation;
}

- (CABasicAnimation *)scaleAnimation2:(CGFloat)duration {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = @0.2;
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    return scaleAnimation;
}

- (CABasicAnimation *)scaleAnimation {
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue = @4.0;
    return scaleAnimation;
}

- (CABasicAnimation *)alphaAnimation {
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1.0;
    alphaAnimation.toValue = @0.0;
    return alphaAnimation;
}

@end
