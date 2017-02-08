//
//  YMActionSheetViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/1/20.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMActionSheetViewController.h"
#import "YMActionSheet.h"

@interface YMActionSheetViewController ()

@end

@implementation YMActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)normalActionSheet:(UIButton *)sender {
    
    YMActionSheet *actionSheet = [YMActionSheet actionSheetViewWithTitle:@"温馨提示"
                                                             cancelTitle:@"取消"
                                                        destructiveTitle:@"确定"
                                                             otherTitles:@[@"第一项", @"第二项"]
                                                             otherImages:@[[UIImage imageNamed:@"UMS_wechat_session_icon"], [UIImage imageNamed:@"UMS_wechat_timeline_icon"]]
                                                             selectBlock:^(YMActionSheet *actionSheet, NSInteger index) {
                                                                 NSLog(@"%zi", index);
                                                             }];
    actionSheet.otherActionItemAlignment = YMOtherActionItemAlignmentCenter;
    [actionSheet show];
}

@end
