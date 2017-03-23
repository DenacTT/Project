//
//  YMDataAdapter.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/5.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMDataAdapter.h"
#import "TextBarGroupModel.h"

@implementation YMDataAdapter

- (id)getLocalMsgListData {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MsgList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        TextBarGroupModel *model = [TextBarGroupModel mj_objectWithKeyValues:dic];
        [dataArr addObject:model];
    }
    
    return dataArr;
}

+ (void)requestCommentsDataSuccess:(RequestSuccess)success fail:(RequestFail)fail {
    
    NSString *commentsPlist = [[NSBundle mainBundle] pathForResource:@"UserCommentsMsg" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:commentsPlist];
    
    success(arr);
}

- (NSArray *)getTestData {
    
    int x = arc4random() % 100;
    int y = (arc4random() % 501) + 500;
    
    NSArray *arr = @[@{
                         @"createTime": @(1486210243730),
                         @"desc": @(x),
                         @"expireTime": @(1487419843700),
                         @"id": @(213),
                         @"imgUrl": @"https://images-sq.iyunmai.com/sq/20170204/20170204195604945.jpg",
                         @"key": @"mq_system_announcement_213",
                         @"paste":@{@"id": @(1003082),
                                    @"messageType": @(24),
                                    @"smallImgUrl": @"https://images-sq.iyunmai.com/sq/20170204/20170204195604945.jpg",
                                    @"title": @(x) },
                         @"systemAnnouncementMessageType": @(2),
                         @"title": @(x),
                         @"type": @(0),
                         @"usersInfo": @{
                                 @"avatarUrl": @"http://images.iyunmai.com/avatar/102901371/1029013711480672491680.jpg?",
                                 @"id": @(102901371),
                                 @"realName": @"好轻精选"
                                 },
                         @"versionCode": @(0)
                         },
                     @{
                         @"createTime": @(1485058650403),
                         @"desc": @(y),
                         @"expireTime": @(1486268250389),
                         @"id": @(212),
                         @"imgUrl": @"https://images-sq.iyunmai.com/sq/20170120/20170120213342077.png",
                         @"key": @"mq_system_announcement_212",
                         @"paste": @{
                                 @"id": @(987851),
                                 @"messageType": @(24),
                                 @"smallImgUrl": @"https://images-sq.iyunmai.com/sq/20170120/20170120213342077.png",
                                 @"title": @(y)
                                 },
                         @"systemAnnouncementMessageType":@(2),
                         @"title": @(y),
                         @"type": @(0),
                         @"usersInfo": @{
                                 @"avatarUrl": @"http://images.iyunmai.com/avatar/102901371/1029013711480672491680.jpg?",
                                 @"id": @(102901371),
                                 @"realName": @"精选"
                                 },
                         @"versionCode": @(0)
                         },
                     @{
                         @"createTime": @(1486210243730),
                         @"desc": @(x),
                         @"expireTime": @(1487419843700),
                         @"id": @(213),
                         @"imgUrl": @"https://images-sq.iyunmai.com/sq/20170204/20170204195604945.jpg",
                         @"key": @"mq_system_announcement_213",
                         @"paste":@{@"id": @(1003082),
                                    @"messageType": @(24),
                                    @"smallImgUrl":
                                        @"https://images-sq.iyunmai.com/sq/20170204/20170204195604945.jpg",
                                    @"title": @(x) },
                         @"systemAnnouncementMessageType": @(2),
                         @"title": @(x),
                         @"type": @(0),
                         @"usersInfo": @{
                                 @"avatarUrl": @"http://images.iyunmai.com/avatar/102901371/1029013711480672491680.jpg?",
                                 @"id": @(102901371),
                                 @"realName": @"好轻"
                                 },
                         @"versionCode": @(0)
                         },
                     @{
                         @"createTime": @(1485058650403),
                         @"desc": @(y),
                         @"expireTime": @(1486268250389),
                         @"id": @(214),
                         @"imgUrl": @"https://images-sq.iyunmai.com/sq/20170120/20170120213342077.png",
                         @"key": @"mq_system_announcement_212",
                         @"paste": @{
                                 @"id": @(987851),
                                 @"messageType": @(24),
                                 @"smallImgUrl": @"https://images-sq.iyunmai.com/sq/20170120/20170120213342077.png",
                                 @"title": @(y)
                                 },
                         @"systemAnnouncementMessageType":@(2),
                         @"title": @(y),
                         @"type": @(0),
                         @"usersInfo": @{
                                 @"avatarUrl": @"http://images.iyunmai.com/avatar/102901371/1029013711480672491680.jpg?",
                                 @"id": @(102901371),
                                 @"realName": @"好精"
                                 },
                         @"versionCode": @(0)
                         }
                     
                     ];
    return arr;
}

@end
