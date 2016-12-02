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
#import "DMHeartFlyView.h"

static NSString * const BBSCellID = @"BBSCell";

@interface BBSListViewController ()<UITableViewDelegate, UITableViewDataSource, BBSCellTopViewDelegate, BBSCellOperateViewDelegate>

@property (nonatomic, strong) BBSCell *cell;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indictorView;

@end

@implementation BBSListViewController
{
    CGFloat _heartSize;
    NSTimer *_burstTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isUseBackBtn = YES;
    self.titleLabel.text = @"热门";
    _heartSize = 36;
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
    return 619;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:BBSCellID forIndexPath:indexPath];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.operateView.delegate = self;
    return _cell;
}

- (void)clickZan {
    [self.tableView reloadData];
//    [self showTheLove];
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
}

-(void)showTheLove{
    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, _heartSize, _heartSize)];
    [_cell addSubview:heart];
//    CGPoint fountainSource = _cell.operateView.zanBtn.center;
//    CGPointMake(_cell.operateView.zanBtn.center.x, _cell.operateView.zanBtn.center.y);
    heart.center = _cell.operateView.zanBtn.center;
    [heart animateInView:self.view];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)style:UITableViewStylePlain];
        [_tableView registerClass:[BBSCell class] forCellReuseIdentifier:BBSCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget: self refreshingAction: @selector(loadMoreData)];
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

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

@end
