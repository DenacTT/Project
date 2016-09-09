//
//  MoreMusicViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/8.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MoreMusicViewController.h"
#import <QPSDK/QPSDK.h>

@interface MoreMusicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MoreMusicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"更多音乐";
}

- (void)viewWillDisappear:(BOOL)animated
{
     // 更多音乐有了更新,比如新下载了音乐
    QupaiSDK *qupai = [[QupaiSDK alloc] init];
    [qupai updateMoreMusic];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end