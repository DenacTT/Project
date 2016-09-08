//
//  UIView+Gesture.h
//  scale
//
//  Created by HarbingWang on 16/1/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapClick)();

@interface UIView (Gesture)

-(void)addTapGesture:(TapClick)click;

@end
