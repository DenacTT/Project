//
//  BBSCellTopView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSCellTopView.h"

@implementation BBSCellTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.headImageBtn];
        [self addSubview:self.nameLabel];
        [self addSubview:self.userRankView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.followBtn];
        [self addSubview:self.moreActionBtn];
    }
    return self;
}

#pragma mark - getter
- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        
    }
    return _headImageBtn;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        
    }
    return _nameLabel;
}

- (UIView *)userRankView
{
    if (!_userRankView) {
        
    }
    return _userRankView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
    }
    return _timeLabel;
}

- (UIButton *)followBtn
{
    if (!_followBtn) {
        
    }
    return _followBtn;
}

- (UIButton *)moreActionBtn
{
    if (!_moreActionBtn) {
        
    }
    return _moreActionBtn;
}

@end
