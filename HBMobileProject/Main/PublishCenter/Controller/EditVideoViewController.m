//
//  EditVideoViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/19.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "EditVideoViewController.h"

@interface EditVideoViewController ()

@end

@implementation EditVideoViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    [self.rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    [self setupSubView];
}

#pragma mark - private methods
- (void)setupSubView
{
    
}

- (void)clickRightBtn
{
    
}

- (void)clickBackBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
