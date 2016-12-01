//
//  ZanAnimationView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/29.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ZanAnimationView.h"
#import "UIImage+Categories.h"

#define kBounds [UIScreen mainScreen].bounds.size
#define kHeartCount 4
#define kZanWH 25.f
#define kXOffSet 20.f
#define kYOffSet 60.f
#define kAllYOffSet 60.f
#define kButtonH 25.f
#define kThumbImgWH kButtonH/2
#define kNumLabelH kButtonH/2
#define kNumFont [UIFont systemFontOfSize:13.f]

@interface ZanAnimationView ()
@end

@implementation ZanAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:@"bbs_zanClicked"];
        UIImage *newImage = [self.image imageWithColor:RGB(255, 81, 81)];
        self.image = newImage;
    }
    return self;
}

- (void)createSmallZanWithCenter:(CGPoint)center {
    
    ZanAnimationView *zanImgView = [[ZanAnimationView alloc] init];
    zanImgView.center = center;
    zanImgView.alpha = 0.9f;
    zanImgView.bounds = CGRectMake(0.f, 0.f, 0.f, 0.f);
    
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    [bezPath moveToPoint:center];
    
    // 向上移动
    NSInteger i = arc4random_uniform(2);
    NSInteger direction = 1 - (2*i);
    
    // 运动路径
    CGPoint cPoint1 = CGPointMake([self getRandomNumber:10 to:center.x - kXOffSet*direction], -kYOffSet);
    CGPoint cPoint2 = CGPointMake([self getRandomNumber:5 to:center.x + kXOffSet*direction], -kYOffSet);
    CGPoint endPoint = CGPointMake(center.x-15, center.y-ScreenWidth-30);
    [bezPath addCurveToPoint:endPoint controlPoint1:cPoint1 controlPoint2:cPoint2];
    
    // 关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezPath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 2.f;
    animation.removedOnCompletion = YES;
    [zanImgView.layer addAnimation:animation forKey:nil];
    
    // 先向上移动一小段距离
    CGFloat transY = [self getRandomNumber:10.f to:50.f];
    [UIView animateWithDuration:0.1f animations:^{
        zanImgView.transform = CGAffineTransformMakeTranslation(0.f, -transY);
    }];
    
    // 弹簧效果弹出
    CGFloat w = [self getRandomNumber:10 to:30];
    [UIView animateWithDuration:0.2f delay:0.1f usingSpringWithDamping:0.5f initialSpringVelocity:50.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        zanImgView.bounds = CGRectMake(0, 0, w, w);
    } completion:NULL];
    
    // 渐隐消失
    [UIView animateKeyframesWithDuration:2.f delay:0.f options:0.f animations:^{
        [self addSubview:zanImgView];
        [UIView addKeyframeWithRelativeStartTime:3/4.f relativeDuration:1/8.f animations:^{
            zanImgView.alpha = 0.5f;
        }];
    } completion:^(BOOL finished) {
        [zanImgView removeFromSuperview];
    }];
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end

