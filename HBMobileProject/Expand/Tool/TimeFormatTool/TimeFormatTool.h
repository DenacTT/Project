//
//  TimeFormatTool.h
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeFormatTool : NSObject

/**
 *  时间戳转换工具
 *  @param  time  从 Model 等地方获取的时间字符串
 *  @return 转化后的时间
 */
+ (NSString *)setTime:(NSTimeInterval)time;

@end
