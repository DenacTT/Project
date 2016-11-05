//
//  TextBarGroupModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PasteTagModel.h"
#import "UserInfoModel.h"
#import "UserTagModel.h"

typedef NS_ENUM(NSInteger,YMSysReadType) {
    YMSysReadTypeUnRead = 0,    //未读
    YMSysReadTypeReaded = 1,    //已读
};

@interface TextBarGroupModel : NSObject

@property (nonatomic, assign) NSTimeInterval createTime;

@property (nonatomic, assign) NSTimeInterval expireTime;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) PasteTagModel *pasteTag;

@property (nonatomic, assign) NSString *systemAnnouncementMessageType;

@property (nonatomic, assign) NSString *systemNotificationMessageType;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) UserInfoModel *usersInfo;

@property (nonatomic, strong) UserTagModel *userTag;

@property (nonatomic) YMSysReadType readType;

@end
