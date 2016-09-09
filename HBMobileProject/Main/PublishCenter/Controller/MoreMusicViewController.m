//
//  MoreMusicViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/8.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MoreMusicViewController.h"

@interface MoreMusicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MoreMusicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"选择音乐";
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self setupRightBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenWidth-64) style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
}

- (void)setupRightBtn
{
    self.rightBtn.frame = CGRectMake(ScreenWidth-55, self.titleLabel.center.y-24/2, 45, 24);
    self.rightBtn.layer.cornerRadius = 2.f;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.backgroundColor = [UIColor orangeColor];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
}

#pragma mark - 重写父类方法
- (void)clickBackBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickRightBtn
{
    // 更多音乐有了更新,比如新下载了音乐
    QupaiSDK *qupai = [[QupaiSDK alloc] init];
    [qupai updateMoreMusic];
    [self dismissViewControllerAnimated:YES completion:nil];
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
