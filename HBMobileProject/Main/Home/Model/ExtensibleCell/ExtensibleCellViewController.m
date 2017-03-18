//
//  ExtensibleCellViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/19.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "ExtensibleCellViewController.h"

@interface ExtensibleCellViewController ()

@end

@implementation ExtensibleCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"可扩展的TableView";
    self.isUseBackBtn = YES;
    self.isUseRightBtn = YES;
    
}

@end
