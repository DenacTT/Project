//
//  ChartViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/24.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "ChartViewController.h"
#import "ChartView.h"

static NSString * const ChartViewCell = @"ChartViewCell";

@interface ChartViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseBackBtn  = YES;
    self.dataArr = @[@"折线图", @"柱状图", @"饼状图"];
    
    // 添加子视图
    [self setupSubView];
}

- (void)setupSubView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-self.navView.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ChartViewCell];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChartViewCell];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChartView *chartView = [[ChartView alloc] init];
    chartView.index = indexPath.row;
    chartView.title = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:chartView animated:YES];
}

@end
