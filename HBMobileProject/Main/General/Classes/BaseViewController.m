//
//  BaseViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
}

#pragma mark - CustomMethod
- (void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightBtn
{
}

#pragma mark - setter
- (void)setIsUseBackBtn:(BOOL)isUseBackBtn
{
    _isUseBackBtn = isUseBackBtn;
    if (isUseBackBtn) {
        [self backBtn];
    }else{
        self.backBtn.hidden = YES;
    }
}

- (void)setIsUseRightBtn:(BOOL)isUseRightBtn
{
    _isUseRightBtn = isUseRightBtn;
    if (isUseRightBtn) {
        [self rightBtn];
    }else{
        self.rightBtn.hidden = YES;
    }
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 44)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [self.navView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _backBtn.frame = CGRectMake(0, 20, 44, 44);
        _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 0);
        [_backBtn setImage:Image(@"icon_back") forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.navView addSubview:_backBtn];
    }
    return _backBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightBtn.frame = CGRectMake(ScreenWidth-44, 20, 44, 44);
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.navView addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
        _bottomLine.backgroundColor = RGB(221, 221, 221);
    }
    return _bottomLine;
}

- (UIView *)navView
{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navView.backgroundColor = [UIColor whiteColor];
        [self.navView addSubview:self.bottomLine];
    }
    return _navView;
}

@end
