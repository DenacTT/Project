//
//  ConfigMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ConfigMovieViewController.h"
#import "MakeMovieViewController.h"

@interface ConfigMovieViewController ()

@end

@implementation ConfigMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *makeVideoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    makeVideoBtn.frame = CGRectMake(20, 20, 100, 40);
    makeVideoBtn.center = self.view.center;
    makeVideoBtn.titleLabel.text = @"拍视频";
    makeVideoBtn.titleLabel.textColor = [UIColor whiteColor];
    makeVideoBtn.backgroundColor = [UIColor orangeColor];
    [makeVideoBtn addTarget:self action:@selector(makeVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:makeVideoBtn];
    
    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 30, ScreenWidth, 30)];
    dismissBtn.titleLabel.text = @"退出";
    dismissBtn.titleLabel.textColor = [UIColor whiteColor];
    dismissBtn.backgroundColor = [UIColor orangeColor];
    [dismissBtn addTarget:self action:@selector(dismissBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:dismissBtn];
}

- (void)dismissBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)makeVideoBtnClicked
{
    MakeMovieViewController *vc = [[MakeMovieViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
