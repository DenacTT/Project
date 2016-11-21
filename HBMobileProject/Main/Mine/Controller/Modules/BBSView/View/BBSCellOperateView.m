//
//  BBSCellOperateView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCellOperateView.h"
#define kBounds [UIScreen mainScreen].bounds.size

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
    NSLog(@"赞赞赞");
//    [self praise];
    if ([self.delegate respondsToSelector:@selector(clickZan)]) {
        [self.delegate clickZan];
    };
}

- (void)onCommentBtnClick:(UIButton *)sender
{
    NSLog(@"评论");
}

- (void)onShareBtnClick:(UIButton *)sender
{
    NSLog(@"分享");
}


#pragma mark - 点赞动画

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
    NSLog(@"%.2f - %.2f -- %d",startX,scale,imageName);
    
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
        [_zanBtn setImage:Image(@"bbs_zanClicked") forState:(UIControlStateHighlighted)];
        
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
