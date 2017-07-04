//
//  PingInvertTransition.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/7/3.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

/// PingTransition的逆向动画
@interface PingInvertTransition : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end
