//
//  HomePopViewController.h
//  HBMobileProject
//
//  Created by whb on 2017/4/5.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePopViewController : UIViewController

@property (nonatomic, strong) UIImage *bgImage; //背景图

@property (nonatomic, copy) void (^dismissBlock)(NSIndexPath *);

@end
