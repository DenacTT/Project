//
//  ComModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/22.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComModel : NSObject

@property (nonatomic, assign) NSInteger Id;//本地数据库Id
// 自己的 ID
@property (nonatomic, assign) NSInteger myUserId;
// 评论人的 ID
@property (nonatomic, assign) NSInteger userId;
// 昵称
@property (nonatomic, strong) NSString *realName;
// 头像地址
@property (nonatomic, strong) NSString *avatarUrl;
// 评论内容
@property (nonatomic, strong) NSString *content;
// 评论创建时间
@property (nonatomic, assign) NSTimeInterval createTime;
// 评论图片地址
@property (nonatomic, strong) NSString *smallImgUrl;
// 消息类型
@property (nonatomic, assign) NSInteger messageType;
// 已读/未读
@property (nonatomic, assign) NSInteger readType;

+ (ComModel *)initWithDic:(NSDictionary *)dic;

- (NSArray *)toParamArray;

@end
