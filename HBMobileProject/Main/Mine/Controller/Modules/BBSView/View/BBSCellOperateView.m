//
//  BBSCellOperateView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCellOperateView.h"
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

@interface ZanImageView ()
@end

@implementation ZanImageView

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
@end

@interface BBSCellOperateView ()

@property (nonatomic,strong) UIView *lineA;
@property (nonatomic,strong) UIView *lineB;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation BBSCellOperateView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.lineA];
        [self addSubview:self.lineB];
        [self addSubview:self.zanBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - ButtonClick
- (void)onZanBtnClick:(UIButton *)sender
{
//    NSLog(@"赞赞赞");
    // 动画1
//    [self praise];
    
    // 动画2
    sender.selected = !sender.selected;
    if (sender.selected) {
        if ([self.delegate respondsToSelector:@selector(clickZan)]) {
            [self showWithAnimation];
            [self.delegate clickZan];
        };
    }
    
}

- (void)onCommentBtnClick:(UIButton *)sender
{
    NSLog(@"评论");
}

- (void)onShareBtnClick:(UIButton *)sender
{
    NSLog(@"分享");
}

#pragma mark - 点赞动画效果 1
- (void)showWithAnimation {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.zanBtn.imageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.zanBtn.imageView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            for (int i = 0; i < kHeartCount; i++) {
                CGFloat x = [self getRandomNumber:self.zanBtn.center.x-15 to:self.zanBtn.center.x];
                CGFloat y = [self getRandomNumber:self.zanBtn.top to:self.zanBtn.center.y*4];
                CGPoint center = CGPointMake(x, y);
                [self createSmallZanWithCenter:center];
            }
        }];
    }];
    
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
//    scaleAnimation.autoreverses = YES;
//    scaleAnimation.repeatCount = 1;
//    scaleAnimation.duration = 0.25;
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
//    [self.zanBtn.imageView.layer addAnimation:scaleAnimation forKey:@"scale"];
//    
//    for (int i = 0; i < kHeartCount; i++) {
//        CGFloat x = [self getRandomNumber:self.zanBtn.center.x-15 to:self.zanBtn.center.x];
//        CGFloat y = [self getRandomNumber:self.zanBtn.top to:self.zanBtn.center.y*4];
//        CGPoint center = CGPointMake(x, y);
//        [self createSmallZanWithCenter:center];
//    }
}

- (void)createSmallZanWithCenter:(CGPoint)center {
    
    UIImageView *zanImgView = [[ZanImageView alloc] init];
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

#pragma mark - 点赞动画 1
- (void)praise{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(self.zanBtn.left+60, self.zanBtn.top, 35, 35);
    imageView.image = [UIImage imageNamed:@"heart"];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.clipsToBounds = YES;
    [self.window addSubview:imageView];
    
    CGFloat startX = round(random() % 200);
    CGFloat scale = round(random() % 2) + 1.0;
    CGFloat speed = 1 / round(random() % 900) + 0.6;
    int imageName = round(random() % 12);
    
    [UIView beginAnimations:nil context:(__bridge void *_Nullable)(imageView)];
    [UIView setAnimationDuration:7 * speed];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/heart%d.png",imageName]];
    imageView.frame = CGRectMake(kBounds.width - startX, -100, 35 * scale, 35 * scale);
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    
    UIImageView *imageView = (__bridge UIImageView *)(context);
    [imageView removeFromSuperview];
}

#pragma mark - getter
- (UIView *)lineA
{
    if (!_lineA) {
        _lineA = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3, (45-33)/2, 0.5, 33)];
        _lineA.backgroundColor = RGB(136, 136, 136);
    }
    return _lineA;
}

- (UIView *)lineB
{
    if (!_lineB) {
        _lineB = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/3*2, (45-33)/2, 0.5, 33)];
        _lineB.backgroundColor = RGB(136, 136, 136);
    }
    return _lineB;
}

- (UIButton *)zanBtn
{
    if (!_zanBtn) {
        _zanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _zanBtn.frame = CGRectMake(0, 0, ScreenWidth/3, 45);
        
        [_zanBtn setImage:Image(@"bbs_zanNormal") forState:(UIControlStateNormal)];
        [_zanBtn setImage:Image(@"bbs_zanClicked") forState:(UIControlStateSelected)];
        
        [_zanBtn setTitle:@"100" forState:(UIControlStateNormal)];
        [_zanBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        
        [_zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
        [_zanBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 2, 0, 0))];
        
        [_zanBtn addTarget:self action:@selector(onZanBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _zanBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _commentBtn.frame = CGRectMake(ScreenWidth/3, 0, ScreenWidth/3, 45);
        
        [_commentBtn setImage:Image(@"bbs_commentIcon") forState:(UIControlStateNormal)];
        
        [_commentBtn setTitle:@"100" forState:(UIControlStateNormal)];
        [_commentBtn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        
        [_commentBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
        [_commentBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 2, 0, 0))];
        
        [_commentBtn addTarget:self action:@selector(onCommentBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _commentBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _shareBtn.frame = CGRectMake(ScreenWidth/3*2, 0, ScreenWidth/3, 45);
        [_shareBtn setImage:Image(@"bbs_shareIcon") forState:(UIControlStateNormal)];
        [_shareBtn addTarget:self action:@selector(onShareBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shareBtn;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, ScreenWidth, 0.5)];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

@end
