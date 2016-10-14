//
//  MineViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MineViewController.h"

static NSString * const TableViewCellID = @"TableViewCellID";

@interface MineViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *classNameArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"功能";
    [self.view addSubview:self.tableView];
    
    [self initData];
}

- (void)initData
{
    self.titleArr = @[].mutableCopy;
    self.classNameArr = @[].mutableCopy;
    
    [self addCell:@"GPUImage Test" className:@"GUPImageTestController"];
    [self addCell:@"GPUImage Video" className:@"GUPImageVideoController"];
    [self addCell:@"GPUImage Beauty" className:@"GPUImageBeautifyController"];
    [self addCell:@"RecordVideo Exapmle" className:@"MakeVideoTestController"];
    [self addCell:@"GPUImage VideoRecord" className:@"GPUVideoTestController"];
//    [self addCell:@"Click Cell Expend" className:@"ExtensibleCellViewController"];
//    [self addCell:@"Left Right TableView" className:@"LinkageTableViewController"];
}

- (void)addCell:(NSString *)cellTitle className:(NSString *)className
{
    [self.titleArr addObject:cellTitle];
    [self.classNameArr addObject:className];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = self.classNameArr[indexPath.row];
    Class class = NSClassFromString(className);
    
    if (class) {
        UIViewController *vc = [class new];
        vc.title = _titleArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellID forIndexPath:indexPath];
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellID];
    }
    return _tableView;
}

// iOS 10
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
