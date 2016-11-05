//
//  UserTagModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UserTagType) {
    UserTagType_Man=1,        //男神榜
    UserTagType_Woman=2,      //女神榜
    UserTagType_HardWork=3,   //毅力榜
    UserTagType_New=4,        //新人榜
    UserTagType_GoodMan=110,  //达人
};

@interface UserTagModel : NSObject

@property (nonatomic,copy)  NSString *name;

@property (nonatomic,assign) UserTagType type;

@property (nonatomic,copy)  NSString *url;

@property (nonatomic, assign) NSInteger typeValue;

@end
