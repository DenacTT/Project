//
//  Member.h
//  HBMobileProject
//
//  Created by HarbingWang on 2017/4/13.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MainUser,
    SubUser,
    MoreUser,
} UserType;

@interface Member : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, assign) UserType userType;

@end
