//
//  TimeFormatTool.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "TimeFormatTool.h"

@implementation TimeFormatTool

+ (NSString *)setTime:(NSTimeInterval)time {
    
    //时间戳单位是毫秒
    NSDate *realDate = [NSDate dateWithTimeIntervalSince1970:[@(time).description doubleValue] / 1000];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:realDate];
    
    NSString *timeString;
    if ([@(time).description doubleValue] == 0)
    {
        timeString = @"";
    }else{
        long one_minute = 60;
        long one_hour = one_minute * 60;
        long one_day = one_hour * 24;
        long two_day = one_day * 2;
        long one_month = one_day * 30;
        long one_year = one_month * 12;
        
        if (timeInterval <= one_minute){
            timeString = @"刚刚";
        }
        else if (timeInterval < one_hour)
        {
            long minites = timeInterval / one_minute;
            timeString = [NSString stringWithFormat:@"%ld分钟前", minites];
        }
        else if (timeInterval < one_day)
        {
            long hours = timeInterval / one_hour;
            timeString = [NSString stringWithFormat:@"%ld小时前", hours];
        }
        else if (timeInterval < two_day)
        {
            timeString = [NSString stringWithFormat:@"昨天"];
        }
        else if(timeInterval < one_year)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"M月d日"];
            timeString = [dateFormatter stringFromDate:realDate];
        }
        else{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            timeString = [dateFormatter stringFromDate:realDate];
        }
    }
    return timeString;
}

@end
