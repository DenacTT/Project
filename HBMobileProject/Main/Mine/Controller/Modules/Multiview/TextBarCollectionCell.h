//
//  TextBarCollectionCell.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextBarCollectionCellDelegate <NSObject>

- (void)rightButtonClick:(UITableViewCell *)cell;
- (void)selectButtonIndex:(NSInteger )index didSelected:(UITableViewCell *)cell;

@end

@interface TextBarCollectionCell : UITableViewCell

@property (nonatomic, assign) id<TextBarCollectionCellDelegate>delegate;

@end
