//
//  BBSCellTopView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBSCellTopViewDelegate <NSObject>

- (void)headButtonClick:(UITableViewCell *)cell;

@end

@interface BBSCellTopView : UIView

@property (nonatomic, strong) UIButton  *headImageBtn;      // 头像
@property (nonatomic, strong) UILabel   *nameLabel;         // 昵称
@property (nonatomic, strong) UILabel   *timeLabel;         // 时间
@property (nonatomic, strong) UIView    *userRankView;      // 用户身份标识

@property (nonatomic, strong) UIButton  *followBtn;         // 私密,关注按钮
@property (nonatomic, strong) UIButton  *moreActionBtn;     // 更多操作:举报.
@property (nonatomic, strong) UIView    *bottomLine;        // 底部线条

@property (nonatomic, weak) id <BBSCellTopViewDelegate>delegate;

@end
