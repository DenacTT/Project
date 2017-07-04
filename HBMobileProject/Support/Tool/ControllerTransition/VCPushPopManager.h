//
//  VCPushPopManager.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/4.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VCPushPopManager : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end
