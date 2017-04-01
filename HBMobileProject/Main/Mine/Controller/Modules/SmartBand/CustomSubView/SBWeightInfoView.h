//
//  SBWeightInfoView.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/31.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBHomeModel.h"

@interface SBWeightInfoView : UIView

@property (nonatomic, strong) SBHomeModel *model;

- (void)setValue:(SBHomeModel *)model;

@end
