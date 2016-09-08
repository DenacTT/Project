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
#import <QPSDK/QPSDK.h>

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
    [makeVideoBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [makeVideoBtn addTarget:self action:@selector(makeVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:makeVideoBtn];
    
    UIButton *uploadVideoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    uploadVideoBtn.frame = CGRectMake(20, 20, 100, 40);
    uploadVideoBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 80);
    [uploadVideoBtn setTitle:@"上传" forState:(UIControlStateNormal)];
    [uploadVideoBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [uploadVideoBtn addTarget:self action:@selector(uploadVideoBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:uploadVideoBtn];
    
    UIButton *dismissBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    dismissBtn.frame = CGRectMake(20, 20, ScreenWidth, 40);
    dismissBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 180);
    [dismissBtn setTitle:@"退出" forState:(UIControlStateNormal)];
    [dismissBtn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    [dismissBtn addTarget:self action:@selector(dismissBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:dismissBtn];
}

//录制
- (void)makeVideoBtnClicked
{
    [self checkAuth];
    
    ConfigMovieViewController *configMovieViewController = [[ConfigMovieViewController alloc] initWithNibName:@"ConfigMovieViewController" bundle:nil];
    [self.navigationController pushViewController:configMovieViewController animated:YES];
}

//上传
- (void)uploadVideoBtnClicked
{
    [self checkAuth];
    
    UploadMovieViewController *uploadViewController = [[UploadMovieViewController alloc] init];
    [self.navigationController pushViewController:uploadViewController animated:YES];
}

//退出页面
- (void)dismissBtnClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)checkAuth
{
    [[QPAuth shared] registerAppWithKey:kQPAppKey secret:kQPAppSecret space:kQPSpace success:^(NSString *accessToken) {
       
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:UserDefaultAccessToken];
        NSLog(@"验证成功");
        
    } failure:^(NSError *error) {
        
        NSLog(@"验证失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
