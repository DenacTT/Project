//
//  NSTimer+Block.h
//  CXCarouselView
//
//  Created by wcxdell on 16/9/5.
//  Copyright © 2016年 王长旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)
+ (NSTimer*) cx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;
@end
