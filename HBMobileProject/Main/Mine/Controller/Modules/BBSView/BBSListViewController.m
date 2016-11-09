//
//  BBSListViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "BBSListViewController.h"
#import "BBSCell.h"
#import "MJRefresh.h"

static NSString * const BBSCellID = @"BBSCell";

@interface BBSListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIActivityIndicatorView *indictorView;

@end

@implementation BBSListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isUseBackBtn = YES;
    self.titleLabel.text = @"热门";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.indictorView];
}

-(void)loadMoreData{
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBSCell *cell = [tableView dequeueReusableCellWithIdentifier:BBSCellID forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)style:UITableViewStyleGrouped];
        [_tableView registerClass:[BBSCell class] forCellReuseIdentifier:BBSCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget: self refreshingAction: @selector(loadMoreData)];
        _tableView.hidden = YES;
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indictorView {
    if (!_indictorView) {
        _indictorView = [[UIActivityIndicatorView alloc] init];
        _indictorView.frame = CGRectMake(ScreenWidth/2-20/2, ScreenHeight/2-20/2, 20, 20);
        _indictorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [_indictorView hidesWhenStopped];
    }
    return _indictorView;
}

@end
