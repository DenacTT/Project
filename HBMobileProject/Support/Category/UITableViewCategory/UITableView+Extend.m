//
//  UITableView+Extend.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/18.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "UITableView+Extend.h"

@implementation UITableView (Extend)

- (void)reloadDataWithAnimate:(BOOL)animate
{
    [self reloadData];
    
    if (animate) {
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setDuration: 0.3];
        [[self layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    }
}

@end
