//
//  AnimationViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/24.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "AnimationViewController.h"
#import "UIBezierPathDemo.h"

@interface AnimationViewController ()

@end

static NSString * const AnimaitonViewCell = @"AnimaitonViewCell";

@interface AnimationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUseBackBtn = YES;
    self.titleLabel.text = @"动画学习Demo";
    [self.view addSubview:self.tableView];
    
    [self initData];
}

- (void)initData {
    
    [self addClassName:@"UIBezierPathDemo" withTitle:@"UIBezierPath"];
    [self addClassName:@"CAShapeLayerDemo" withTitle:@"CAShapeLayer"];
    [self addClassName:@"CAAnimationDemo" withTitle:@"CAAnimation"];
    
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnimaitonViewCell forIndexPath:indexPath];
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
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AnimaitonViewCell];
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
