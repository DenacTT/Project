//
//  YMTextBarGroupCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/2.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YMTextBarGroupCellDelegate <NSObject>

- (void)moreGroupButtonClick:(UITableViewCell *)cell;

@end

@interface YMTextBarGroupCell : UITableViewCell

@property (nonatomic, assign) id<YMTextBarGroupCellDelegate>delegate;

@end
