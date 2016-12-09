//
//  HomeStoreHeadView.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/6.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface HomeStoreHeadView : UICollectionReusableView

@property (nonatomic, strong) GoodsModel *model;

- (void)initData;

@end
