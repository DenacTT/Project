//
//  SBHomeView.h
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LocationStatus) {
    LocationStatus_TopDown   = 1,    //上半段下移
    LocationStatus_BtmDown   = 2,    //下半段下移
    LocationStatus_BtmUp     = 3,    //下半段上移
    LocationStatus_TopUp     = 4,    //上半段上移
};

@interface SBHomeView : UIViewController

@end
