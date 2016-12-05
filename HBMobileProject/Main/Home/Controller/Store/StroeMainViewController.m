//
//  StroeMainViewController.m
//  scale
//
//  Created by cza on 2016/12/5.
//  Copyright © 2016年 cza. All rights reserved.
//

#import "StroeMainViewController.h"
#import "OrderStoreViewController.h"
#import "ShopCartViewController.h"
#import "HomeStoreViewController.h"

@interface StroeMainViewController ()

@end

@implementation StroeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor colorWithRed:66.0/255.0 green:206.0/255.0 blue:205.0/255.0 alpha:1.0];
    
    HomeStoreViewController *homeVc = [[HomeStoreViewController alloc]init];
    [self addChildViewController:homeVc WithTitle:@"首页" imageName:@"tab_store_home_normal" selectedImageName:@"tab_store_home_selected"];
    
    ShopCartViewController *site = [[ShopCartViewController alloc]init];
    [self addChildViewController:site WithTitle:@"购物车" imageName:@"tab_strore_car_normal" selectedImageName:@"tab_stroe_car_selected"];
    
    OrderStoreViewController *topic = [[OrderStoreViewController alloc]init];
    [self addChildViewController:topic WithTitle:@"订单" imageName:@"tab_stroe_order_normal" selectedImageName:@"tab_stroe_order_selected"];
}

-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = Image(@"");
    childController.tabBarItem.title = title;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
     nav.navigationBar.hidden = YES;
    [self addChildViewController:nav];
}

@end
