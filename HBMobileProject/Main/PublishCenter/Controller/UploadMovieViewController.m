//
//  UploadMovieViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UploadMovieViewController.h"
#import "YMChangeAccountSuccessView.h"

@interface UploadMovieViewController ()

@end

@implementation UploadMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"上传";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [[[CustomTipsView alloc] init] showWithText:@"成功?"];
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
