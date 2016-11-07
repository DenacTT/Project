//
//  NormalTableViewCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextBarGroupModel.h"

@protocol NormalTableViewCellDelegate <NSObject>

- (void)readDetail:(UITableViewCell *)cell;

@end

@interface NormalTableViewCell : UITableViewCell

@property (nonatomic, strong) TextBarGroupModel *groupModel;
@property (nonatomic, assign) id<NormalTableViewCellDelegate>delegate;

+ (CGFloat)cellHeightWithModel:(TextBarGroupModel *)model;

@end
