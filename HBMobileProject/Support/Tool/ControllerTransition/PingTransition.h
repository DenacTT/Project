//
//  PingTransition.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 飞出的转场动画
/// UIViewControllerAnimatedTransitioning 其实是转场动画的实施者，动画的时间,具体形式都是通过这个协议设置的
@interface PingTransition : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;

@end
