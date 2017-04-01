//
//  SBHomeModel.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/29.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeModel.h"

@implementation SBHomeModel

- (void)initData {
    switch (self.cellType) {
        case SBHomeCellType_Exercise:
        {
            // test
            self.mainText = @"725 Cals";
            self.subText  = @"3 Workouts";
            self.calsNum  = 725;
            self.exeProgress = 0.7;
        }
            break;
        case SBHomeCellType_HeartRate:
        {
            self.mainText = @"85/min";
            self.subText  = @"Lowest 74  Highest 126";
            self.heartRate = 85;
        }
            break;
        case SBHomeCellType_SleepTime:
        {
            self.mainText = @"7h 56min";
            self.subText  = @"2 Awake 9 Aypnia";
            self.sleepTime = 476;
        }
            break;
        case SBHomeCellType_BodyWeight:
        {
            self.mainText = @"90 kg";
            self.subText  = @"fat 40%";
            self.weightNum = 90;
        }
            break;
        default:
            break;
    }
}

@end
