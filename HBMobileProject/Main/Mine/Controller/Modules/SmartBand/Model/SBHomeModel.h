//
//  SBHomeModel.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/29.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SBHomeCellType_Exercise,    //锻炼
    SBHomeCellType_HeartRate,   //心率
    SBHomeCellType_SleepTime,   //睡眠
    SBHomeCellType_BodyWeight,  //体重
} SBHomeCellType;

@interface SBHomeModel : NSObject

@property (nonatomic, assign) SBHomeCellType cellType;

@property (nonatomic, strong) NSString *mainText;

@property (nonatomic, strong) NSString *subText;

@property (nonatomic, assign) NSInteger calsNum;

@property (nonatomic, assign) NSInteger heartRate;

@property (nonatomic, assign) NSInteger sleepTime;

@property (nonatomic, assign) NSInteger weightNum;

@property (nonatomic, assign) CGFloat mileNum;

@property (nonatomic, assign) NSInteger timeNum;

@property (nonatomic, assign) NSInteger stepNum;

- (void)initData;

@end
