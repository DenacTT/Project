//
//  HomeItem.h
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/30.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeItem : NSObject

@property (nonatomic, strong) NSString *className;
@property (nonatomic, strong) id object;

+ (instancetype)itemWithClassName:(NSString *)className object:(id)object;

@property (nonatomic) NSInteger *index;
@property (nonatomic, strong, readonly) NSMutableAttributedString *nameString;

- (void)createAttributedString;

@end
