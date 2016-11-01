//
//  TextBarCollectionCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "TextBarCollectionCell.h"

#define ImageCount 4

const CGFloat collectionCellHeight = 95;
const CGFloat collectionCellWidth = 150;
const CGFloat kMargin = 10;

@interface TextBarCollectionCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *headTitle;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIScrollView *collectionView;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TextBarCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        [self addSubview:self.headTitle];
        [self addSubview:self.rightButton];
        
        [self addSubview:self.collectionView];
        [self addSubview:self.bottomLine];
        
        [_collectionView addSubview:_moreButton];
    }
    return self;
}

#pragma mark - buttonClick

- (void)selectButtonAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(selectButtonIndex:didSelected:)]) {
        [self.delegate selectButtonIndex:button.tag didSelected:self];
    }
}

- (void)rightButtonAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(rightButtonClick:)]) {
        [self.delegate rightButtonClick:self];
    }
}

#pragma mark - getter

- (UIScrollView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 55, ScreenWidth-15*2, collectionCellHeight)];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.contentSize = CGSizeMake(ImageCount*(collectionCellWidth+kMargin) + 85, collectionCellHeight);
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        
        for (int i = 0; i < ImageCount; i++) {
            
            UIButton *button = [[UIButton alloc] init];
            button.frame = CGRectMake((collectionCellWidth + kMargin) * i + kMargin, 0, collectionCellWidth, collectionCellHeight);
            button.tag = i;
            button.backgroundColor = [UIColor orangeColor];
            
            [button setImage:Image(@"defaultImage") forState:(UIControlStateNormal)];
            [button setContentMode:(UIViewContentModeScaleAspectFill)];
            
            [button addTarget:self action:@selector(selectButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [_collectionView addSubview:button];
            
            if (i==ImageCount-1)
            {
                _moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
                _moreButton.frame = CGRectMake(button.right+10, 0, 75, 95);
                _moreButton.backgroundColor = RGB(243, 243, 247);
                
                [_moreButton setTitle:@"更多" forState:(UIControlStateNormal)];
                [_moreButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [_moreButton setTitleColor:RGB(102, 102, 102) forState:(UIControlStateNormal)];
                
                [_moreButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
                [_collectionView addSubview:_moreButton];
            }
            
        }
        
    }
    return _collectionView;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightButton.frame = CGRectMake(ScreenWidth-95, (55-16)/2, 80, 16);
        [_rightButton setTitle:@"全部合集" forState:(UIControlStateNormal)];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_rightButton setTitleColor:RGB(136, 136, 136) forState:(UIControlStateNormal)];
        [_rightButton setImage:Image(@"ArrowIcon") forState:(UIControlStateNormal)];
        
        [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 75, 0, 0)];// 上,左,下,右
        [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return _rightButton;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _collectionView.bottom+30, ScreenWidth, 8)];
        _bottomLine.backgroundColor = RGB(243, 243, 247);
    }
    return _bottomLine;
}

- (UILabel *)headTitle
{
    if (!_headTitle) {
        _headTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, (55-18)/2, ScreenWidth/2, 18)];
        _headTitle.text = @"精选合集";
        _headTitle.font = Font(18.f);
        _headTitle.textColor = RGB(102, 102, 102);
        _headTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _headTitle;
}

@end
