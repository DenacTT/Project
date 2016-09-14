//
//  UploadMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UploadMovieViewController.h"

#define UploadMovieCellID @"UploadMovieCell"

@interface UploadMovieViewController ()<UITableViewDelegate, UITableViewDataSource, UploadMovieDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UploadMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上传";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
