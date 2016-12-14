//
//  StoreTopBarTool.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectItem)(NSInteger item);

@interface StoreTopBarTool : UIView

@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, copy) SelectItem selectBlock;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items selectIndex:(NSInteger)selectedIndex select:(SelectItem)selectBlock;

- (void)scrollToIndex:(NSInteger)index;

@end
