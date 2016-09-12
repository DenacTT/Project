//
//  UploadMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UploadMovieViewController.h"

#define UploadMovieCellID @"UploadMovieCell"

@interface UploadMovieViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UploadMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上传";
    
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi", indexPath.item);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UploadMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadMovieCellID forIndexPath:indexPath];
    if (!cell) {
        
    }
//    cell.delegate
    return cell;
}

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:(UITableViewStylePlain)];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UploadMovieCell class] forCellReuseIdentifier:UploadMovieCellID];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
