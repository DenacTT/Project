//
//  GoodsModel.h
//  scale
//
//  Created by HarbingWang on 16/12/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *acturalPrice;   //实际价格
@property (nonatomic, strong) NSString *defaultPrice;   //默认价格

@property (nonatomic, assign) BOOL stockStatus;         //有无库存
@property (nonatomic, assign) NSInteger leftStock;      //库存量

@property (nonatomic, assign) NSTimeInterval rushStartTime;     //抢购开始时间
@property (nonatomic, assign) NSTimeInterval rushEndTime;       //抢购结束时间
@property (nonatomic, assign) NSTimeInterval nextRushStartTime; //下一轮抢购时间

@property (nonatomic, assign) BOOL isHot;

@end
