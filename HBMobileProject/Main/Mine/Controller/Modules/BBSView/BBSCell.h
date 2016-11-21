//
//  BBSCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/9.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSCellTopView.h"
#import "BBSCellOperateView.h"

@interface BBSCell : UITableViewCell

@property (nonatomic, strong) BBSCellTopView *headView;

@property (nonatomic,strong) BBSCellOperateView *operateView;

@end
