//
//  BBSCellOperateView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBSCellOperateViewDelegate <NSObject>

- (void)clickZan;

@end

@interface BBSCellOperateView : UIView

@property (nonatomic,strong) UIButton *zanBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *shareBtn;

@property (nonatomic, weak) id<BBSCellOperateViewDelegate>delegate;

@end
