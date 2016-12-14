//
//  GoodsInfoModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/14.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfoModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, strong) NSString *imgUrl;

@end
