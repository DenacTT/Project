//
//  BaseTableViewCell.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/29.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTableViewCell;
@protocol BaseTableViewCellDelegate <NSObject>

@optional
/// delegate method
- (void)tableViewCell:(BaseTableViewCell *)cell event:(id)event;

@end

@interface BaseTableViewCell : UITableViewCell

#pragma mark - Properties
// delegate
@property (nonatomic, weak) id<BaseTableViewCellDelegate>delegate;
// dataSource
@property (nonatomic, weak) id data;
// indexPath
@property (nonatomic, weak) NSIndexPath *indexPath;
// tableView
@property (nonatomic, weak) UITableView *tableView;

#pragma mark - Methods

// custom method, override by subclass.
/// setup cell
- (void)setupCell;
/// setup subview
- (void)setupSubView;
/// load content
- (void)loadContent;

@end
