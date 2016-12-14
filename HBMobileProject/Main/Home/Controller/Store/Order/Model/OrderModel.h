//
//  OrderModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/12/13.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"

@interface OrderModel : NSObject

@property (nonatomic, assign) NSInteger orderNo;

@property (nonatomic, assign) NSInteger totalPrice;

@property (nonatomic, assign) NSInteger dispatchCost;

@property (nonatomic, assign) OrderStatus status;

@property (nonatomic, strong) GoodsInfoModel *listOfGoodsInfo;

@end

/*
"data": [
         {
             "orderNo": 20161031112255332000,
             "totalPrice": 500,
             "dispatchCost":"20",
             "status": 1,	#1.未支付 2:待收货 3:待完成 4已取消
             "listOfGoodsInfo": [
                                 {
                                     "name": "第一期+瑜伽垫",
                                     "num":2,
                                     "price": 500,
                                     "imgUrl": "http://images.sq.iyunmai.com/base/pro/20160907/one.png",
                                 },
                                 {
                                     "name": "第一期+瑜伽垫",
                                     "num":2,
                                     "price": 500,
                                     "imgUrl": "http://images.sq.iyunmai.com/base/pro/20160907/one.png",
                                 },
                                 ]
          }
         ]
*/
