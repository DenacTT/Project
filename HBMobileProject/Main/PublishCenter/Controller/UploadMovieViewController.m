//
//  UploadMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.§§§§
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UploadMovieViewController.h"

#define UploadMovieCellID @"UploadMovieCell"

@interface UploadMovieViewController ()<UITableViewDelegate, UITableViewDataSource, UploadMovieDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *taskArray;

@end

@implementation UploadMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上传";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self setupData];
}

#pragma mark - setupData
- (void)setupData
{
    NSArray *tasks = [[QPUploadTaskManager shared] getAllUploadTasks];
    for (QPUploadTask *task in tasks) {
        task.videoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Test"];
        [self.taskArray addObject:task];
    }
    NSLog(@"%zi", [self.taskArray count]);
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UploadMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadMovieCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UploadMovieCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:UploadMovieCellID];
    }
    cell.delegate = self;
    cell.uploadTask = self.taskArray[indexPath.row];
    return cell;
}

#pragma mark - UploadMovieDelegate
- (void)downloadMovie:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"%zi", indexPath.row);
}

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        [_tableView registerClass:[UploadMovieCell class] forCellReuseIdentifier:UploadMovieCellID];
    }
    return _tableView;
}

- (NSMutableArray *)taskArray
{
    if (!_taskArray) {
        _taskArray = [NSMutableArray array];
    }
    return _taskArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
