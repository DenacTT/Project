//
//  SBHomeHeadView.h
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBHomeModel.h"

typedef enum : NSUInteger {
    SBHeadTypeCals = 0, //卡路里
    SBHeadTypeStep, //步数
    SBHeadTypeMile, //里程
    SBHeadTypeTime, //时长
} SBHeadType;

@protocol SBHomeHeadViewDelegate <NSObject>

- (void)headViewClicked:(SBHeadType)type;

@end

@interface SBHomeHeadView : UICollectionReusableView

@property (nonatomic, weak) id<SBHomeHeadViewDelegate>delegate;

// 赋值
- (void)setValue:(SBHomeModel *)model;

// 开启两个大圆的动画
- (void)startCircleAnimation;
/// 暂停动画.保存当前位置和时间
- (void)pauseCircleAnimation;
/// 恢复动画
- (void)resumeCircleLayer;

@end
