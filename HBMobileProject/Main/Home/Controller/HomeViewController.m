//
//  HomeViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/3.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "HomeViewController.h"

static NSString * const HomeViewCell = @"HomeViewCell";

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"首页";
//    self.isUseBackBtn = YES;
//    self.isUseRightBtn = YES;
    [self.view addSubview:self.tableView];
    
    [self initData];
}

- (void)initData {
    
    //[self addClassName:@"AnimationViewController" withTitle:@"AnimationDemo"];
    [self addClassName:@"ChartViewController" withTitle:@"ChartView"];
    [self addClassName:@"DataFilterViewController" withTitle:@"DataFilter"];
    [self addClassName:@"FMDBViewController" withTitle:@"FMDBStudyDemo"];
    [self addClassName:@"KVCCollectionOperators" withTitle:@"KVCCollectionOperators"];
    [self addClassName:@"YMActionSheetViewController" withTitle:@"CustomActionSheet"];
    [self addClassName:@"ScrollViewAnimation" withTitle:@"ScrollViewAnimation"];
}

- (void)addClassName:(NSString *)className withTitle:(NSString *)title {
    
    [self.dataArr addObject:className];
    [self.titleArr addObject:title];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeViewCell forIndexPath:indexPath];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *className = self.dataArr[indexPath.row];
    Class class = NSClassFromString(className);
    
    if (class) {
        UIViewController *viewController = [class new];
        viewController.title = _titleArr[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, ScreenWidth, ScreenHeight-self.navView.height) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HomeViewCell];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

@end
