//
//  YMTextBarGroupCell.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/2.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMTextBarGroupCell.h"
#import "YMTextBarHorizontalCell.h"
#import "YMTextBarGroupTableView.h"

const CGFloat cellHeight = 95;
const CGFloat cellWidth  = 150;

static NSString * const YMTextBarHorizontalCellID = @"YMTextBarHorizontalCellID";

@interface YMTextBarGroupCell ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel   *headTitle;
@property (nonatomic, strong) UIButton  *rightButton;
@property (nonatomic, strong) UIButton  *moreButton;
@property (nonatomic, strong) UIView    *bottomLine;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YMTextBarGroupTableView *groupView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation YMTextBarGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.headTitle];
        [self addSubview:self.rightButton];
        /*[self addSubview:self.tableView];*/
        [self addSubview:self.groupView];
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi", indexPath.section);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMTextBarHorizontalCell *cell = [tableView dequeueReusableCellWithIdentifier:YMTextBarHorizontalCellID];
    if (cell== nil) {
        cell = [[YMTextBarHorizontalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:YMTextBarHorizontalCellID];
    }
    return cell;
}

#pragma mark - ButtonClick
- (void)rightButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(moreGroupButtonClick:)]) {
        [self.delegate moreGroupButtonClick:self];
    }
}

#pragma mark - getter

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

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _rightButton.frame = CGRectMake(ScreenWidth-95, (55-16)/2, 80, 16);
        
        [_rightButton setTitle:@"全部合集" forState:(UIControlStateNormal)];
        [_rightButton.titleLabel setFont:Font(14.f)];
        [_rightButton setTitleColor:RGB(136, 136, 136) forState:(UIControlStateNormal)];
        
        [_rightButton setImage:Image(@"ArrowIcon") forState:(UIControlStateNormal)];
        
        [_rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 75, 0, 0)];
        [_rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightButton;
}

- (UITableView *)tableView
{
    if (!_tableView) {
    
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, cellHeight, ScreenWidth-15*2) style:(UITableViewStylePlain)];
        _tableView.center = CGPointMake(ScreenWidth/2, 55+cellHeight/2);
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        _tableView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        [_tableView registerClass:[YMTextBarHorizontalCell class] forCellReuseIdentifier:YMTextBarHorizontalCellID];
    }
    return _tableView;
}

- (YMTextBarGroupTableView *)groupView
{
    if (!_groupView) {
        _groupView = [[YMTextBarGroupTableView alloc] initWithFrame:CGRectMake(15, 55, ScreenWidth-15*2, cellHeight)];
        _groupView.backgroundColor = [UIColor orangeColor];
    }
    return _groupView;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _groupView.bottom+30, ScreenWidth, 8)];
        _bottomLine.backgroundColor = RGB(243, 243, 247);
    }
    return _bottomLine;
}

@end
