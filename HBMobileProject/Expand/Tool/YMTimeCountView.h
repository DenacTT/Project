//
//  YMTimeCountView.h
//  scale
//
//  Created by HarbingWang on 16/12/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimeStopBlock)();

@interface YMTimeCountView : UIView

// 外界传进来的时间戳(活动开始时间)
@property (nonatomic, assign) NSTimeInterval rushStartTime;
// 活动逾期时间
@property (nonatomic, assign) NSTimeInterval rushEndTime;

// 倒计时结束时的回调
@property (nonatomic, copy) TimeStopBlock timeStopBlock;

// 开启定时器
- (void)runTimerWithRushStartTime:(NSTimeInterval)rushStartTime;

// 创建单例对象
+ (instancetype)shareCountDown;

@end
