//
//  BBSCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCell.h"
#import "YYKit.h"

@interface BBSCell ()

@property (nonatomic,strong) UIView *bbsContentView;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) YYLabel *zanLabel;

@property (nonatomic,strong) YYLabel *contentLabel;

@property (nonatomic,strong) UILabel *commentCountLabel;

@property (nonatomic,strong) YYLabel *commentALabel;

@property (nonatomic,strong) YYLabel *commentBLabel;

@property (nonatomic,strong) UIImageView *heartImage;

@end

@implementation BBSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headView];
        [self addSubview:self.bbsContentView];
        [self.bbsContentView addSubview:self.heartImage];
        [self addSubview:self.operateView];
        [self addSubview:self.zanLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.commentCountLabel];
        [self addSubview:self.commentALabel];
        [self addSubview:self.commentBLabel];
        [self addSubview:self.bottomView];
    }
    return self;
}

#pragma mark - methods
#pragma mark - 双击显示动画
- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"-----doubleTap-----");
    [self showBigHeartAnimation];
}
- (void)showBigHeartAnimation {
    
    _heartImage.alpha = 0;
    [UIView animateWithDuration:0 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.heartImage.alpha = 0;
        self.heartImage.transform = CGAffineTransformMakeScale(0.0, 0.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            self.heartImage.alpha = 1;
            self.heartImage.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
                self.heartImage.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
                    self.heartImage.transform = CGAffineTransformMakeScale(0.84, 0.84);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 delay:0.4 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
                        self.heartImage.alpha = 0;
                        self.heartImage.transform = CGAffineTransformMakeScale(0.3, 0.3);
                    } completion:^(BOOL finished) {
                        [self showSmallHeartAnimation];
                    }];
                }];
            }];
        }];
    }];
}

- (void)showSmallHeartAnimation {
    self.heartImage.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.heartImage.alpha = 1;
        self.heartImage.frame = CGRectMake(-self.heartImage.center.x + 10, -self.heartImage.center.y + 50, 60, 60);
        self.heartImage.transform = CGAffineTransformMakeRotation(5);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - getter
- (BBSCellTopView *)headView
{
    if (!_headView) {
        _headView = [[BBSCellTopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 54.5)];
    }
    return _headView;
}

-(UIView *)bbsContentView{
    if (!_bbsContentView) {
        _bbsContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headView.bottom, ScreenWidth, ScreenWidth)];
//        _bbsContentView.backgroundColor = [UIColor yellowColor];
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [_bbsContentView addGestureRecognizer:doubleTapGestureRecognizer];
    }
    return _bbsContentView;
}

-(BBSCellOperateView *)operateView{
    if (!_operateView) {
        _operateView = [[BBSCellOperateView alloc] initWithFrame:CGRectMake(0, self.bbsContentView.bottom, ScreenWidth, 45)];
    }
    return _operateView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commentBLabel.bottom+18, ScreenWidth, 4)];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    }
    return _bottomView;
}

-(YYLabel *)zanLabel{
    if (!_zanLabel) {
        _zanLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.operateView.bottom+12, ScreenWidth-15*2, 15)];
        _zanLabel.backgroundColor = [UIColor grayColor];
    }
    return _zanLabel;
}

-(YYLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.zanLabel.bottom+12, ScreenWidth-15*2, 14)];
        _contentLabel.backgroundColor = [UIColor blueColor];
    }
    return _contentLabel;
}

-(UILabel *)commentCountLabel{
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.contentLabel.bottom+16, ScreenWidth-15*2, 14)];
        _commentCountLabel.textColor = RGB(172, 172, 172);
        _commentCountLabel.font = Font(14);
        _commentCountLabel.backgroundColor = [UIColor purpleColor];
    }
    return _commentCountLabel;
}

-(YYLabel *)commentALabel{
    if (!_commentALabel) {
        _commentALabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.commentCountLabel.bottom+7, ScreenWidth-15*2, 14)];
        _commentALabel.backgroundColor = [UIColor yellowColor];
    }
    return _commentALabel;
}

-(YYLabel *)commentBLabel{
    if (!_commentBLabel) {
        _commentBLabel = [[YYLabel alloc] initWithFrame:CGRectMake(15, self.commentALabel.bottom+7, ScreenWidth-15*2, 14)];
        _commentBLabel.backgroundColor = [UIColor orangeColor];
    }
    return _commentBLabel;
}

- (UIImageView *)heartImage {
    if (!_heartImage) {
        _heartImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-120)/2, (ScreenWidth-120)/2, 120, 120)];
        _heartImage.image = Image(@"BBS_DoubleClick_Heart");
        _heartImage.alpha = 0;
    }
    return _heartImage;
}

@end
