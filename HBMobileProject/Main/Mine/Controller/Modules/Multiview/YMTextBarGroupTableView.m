//
//  YMTextBarGroupTableView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/2.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMTextBarGroupTableView.h"
#import "YMTextBarHorizontalCell.h"


static NSString * const YMTextBarHorizontalCellID = @"YMTextBarHorizontalCellID";

@interface YMTextBarGroupTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YMTextBarGroupTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:self.tableView];
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

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 95, ScreenWidth-15*2) style:(UITableViewStylePlain)];
        _tableView.center = CGPointMake(ScreenWidth/2, 55+95/2);
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        _tableView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        [_tableView registerClass:[YMTextBarHorizontalCell class] forCellReuseIdentifier:YMTextBarHorizontalCellID];
    }
    return _tableView;
}


@end
