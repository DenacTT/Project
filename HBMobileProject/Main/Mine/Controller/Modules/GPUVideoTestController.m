//
//  GPUVideoTestController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/14.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "GPUVideoTestController.h"
#import "GPUVideoViewController.h"

@interface GPUVideoTestController ()

@end

@implementation GPUVideoTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, 0, 200, 200);
    button.center = self.view.center;
    [button setTitle:@"GPU 录制" forState:(UIControlStateNormal)];
    [button setTitleColor: [UIColor orangeColor] forState: UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)button
{
    GPUVideoViewController *vc = [[GPUVideoViewController alloc] init];
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
