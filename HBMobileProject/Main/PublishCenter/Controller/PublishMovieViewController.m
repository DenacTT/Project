//
//  PublishMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "PublishMovieViewController.h"
#import "ConfigMovieViewController.h"
#import "UploadMovieViewController.h"

@interface PublishMovieViewController ()

@end

@implementation PublishMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"视频";
    
    UIButton *makeVideoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    makeVideoBtn.frame = CGRectMake(20, 20, 100, 40);
    makeVideoBtn.center = self.view.center;
    [makeVideoBtn setTitle:@"录制" forState:(UIControlStateNormal)];
    [makeVideoBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [makeVideoBtn setBackgroundColor:RGB(0, 184, 108)];
    [makeVideoBtn addTarget:self action:@selector(makeVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:makeVideoBtn];
    
    UIButton *uploadVideoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    uploadVideoBtn.frame = CGRectMake(20, 20, 100, 40);
    uploadVideoBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
    [uploadVideoBtn setTitle:@"上传" forState:(UIControlStateNormal)];
    [uploadVideoBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [uploadVideoBtn setBackgroundColor:RGB(0, 184, 108)];
    [uploadVideoBtn addTarget:self action:@selector(uploadVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:uploadVideoBtn];
    
    UIButton *dismissBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissBtn.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 40, ScreenWidth, 40);
    [dismissBtn setTitle:@"退出" forState:(UIControlStateNormal)];
    [dismissBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
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
    ConfigMovieViewController *configVideoViewController = [[ConfigMovieViewController alloc] init];
    [self.navigationController pushViewController:configVideoViewController animated:YES];
}

- (void)uploadVideoBtnClicked
{
    UploadMovieViewController *uploadViewController = [[UploadMovieViewController alloc] init];
    [self.navigationController pushViewController:uploadViewController animated:YES];
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
