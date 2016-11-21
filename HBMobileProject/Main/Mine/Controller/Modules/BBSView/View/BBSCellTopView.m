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
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - ButtonClick
- (void)headClick
{
    NSLog(@"点击头像");
    if ([self.delegate respondsToSelector:@selector(headButtonClick:)]) {
        
    }
}

- (void)moreAction
{
    NSLog(@"更多操作");
}

- (void)followBtnClick
{
    NSLog(@"关注");
}

#pragma mark - getter
- (UIButton *)headImageBtn
{
    if (!_headImageBtn) {
        _headImageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _headImageBtn.frame = CGRectMake(15, self.center.y-34/2, 34, 34);
        
        _headImageBtn.layer.cornerRadius = _headImageBtn.size.width/2;
        _headImageBtn.layer.masksToBounds = YES;
        _headImageBtn.layer.borderColor = RGB(221, 221, 221).CGColor;
        _headImageBtn.layer.borderWidth = 1.f;
        
        [_headImageBtn setImage:Image(@"headImageDefault") forState:(UIControlStateNormal)];
        [_headImageBtn addTarget:self action:@selector(headClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headImageBtn;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headImageBtn.right+7, 12, 60, 14)];
        _nameLabel.text = @"云小麦";
        _nameLabel.font = Font(14.f);
        _nameLabel.textColor = RGB(0, 0, 0);
//        _nameLabel.textColor = RGB(255, 83, 62);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    
        _nameLabel.width = [self textWidth:_nameLabel.text];
    }
    return _nameLabel;
}

- (UIView *)userRankView
{
    if (!_userRankView) {
        _userRankView = [[UIView alloc] initWithFrame:CGRectMake(_nameLabel.right+5, _nameLabel.top, 16*5+5*5, 16)];
//        _userRankView.backgroundColor = [UIColor orangeColor];
    }
    return _userRankView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+6, 100, 10)];
        _timeLabel.text = @"2016年12月21日";
        _timeLabel.font = Font(10.f);
        _timeLabel.textColor = RGB(136, 136, 136);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UIButton *)followBtn
{
    if (!_followBtn) {
        _followBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _followBtn.frame = CGRectMake(ScreenWidth-25-20-60, (54.5-25)/2, 60, 25);
        
        _followBtn.layer.cornerRadius = 3.f;
        _followBtn.layer.masksToBounds = YES;
        _followBtn.layer.borderWidth = 1.f;
        _followBtn.layer.borderColor = RGB(37, 201, 152).CGColor;
        
        [_followBtn setImage:Image(@"bbs_followIcon") forState:(UIControlStateNormal)];
        [_followBtn setTintColor:RGB(37, 201, 152)];
        [_followBtn setTitle:@"关注" forState:(UIControlStateNormal)];
        [_followBtn.titleLabel setTintColor:RGB(37, 201, 152)];
        [_followBtn.titleLabel setFont:Font(12.f)];
        
        [_followBtn addTarget:self action:@selector(followBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _followBtn;
}

- (UIButton *)moreActionBtn
{
    if (!_moreActionBtn) {
        _moreActionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _moreActionBtn.frame = CGRectMake(ScreenWidth-35, (54.5-25)/2, 25, 25);
        [_moreActionBtn setImage:Image(@"bbs_moreAction") forState:(UIControlStateNormal)];
        [_moreActionBtn addTarget:self action:@selector(moreAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreActionBtn;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 54, ScreenWidth, 0.5)];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _bottomLine;
}

- (CGFloat)textWidth:(NSString*)string
{
    CGSize contantSize = CGSizeMake(ScreenWidth-160, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
    CGRect rect = [string boundingRectWithSize:contantSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat width = rect.size.width;
    return width;
}

@end
