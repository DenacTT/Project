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
    
    self.title = @"配置参数";
    
    UIButton *dismissBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissBtn.frame = CGRectMake(0, ScreenHeight-80, ScreenWidth, 40);
    [dismissBtn setTitle:@"录制" forState:(UIControlStateNormal)];
    [dismissBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [dismissBtn addTarget:self action:@selector(makeVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:dismissBtn];
}

- (void)makeVideoBtnClicked
{
    MakeMovieViewController *vc = [[MakeMovieViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
