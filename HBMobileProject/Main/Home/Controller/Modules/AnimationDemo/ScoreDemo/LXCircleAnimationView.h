//
//  LXCircleAnimationView.h
//  Health Management
//
//  Created by Tour on 16/8/9.
//  Copyright © 2016年 Kingdee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCircleAnimationView : UIView

//实现部分如下
/*
 
 self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(40.f, 70.f, SCREEN_WIDTH - 80.f, SCREEN_WIDTH - 80.f)];
 self.circleProgressView.bgImage = [UIImage imageNamed:@""];
 //调用此方法
 self.circleProgressView.percent = 0.f;
 [self.view addSubview:self.circleProgressView];

 */

@property (nonatomic, assign) CGFloat percent; // 百分比 0 - 100
@property (nonatomic, strong) UIImage *bgImage; // 背景图片
@property (nonatomic, strong) NSString *text; // 文字

@end
