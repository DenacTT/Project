//
//  YMSuccessView.h
//  scale
//
//  Created by zxq on 16/3/23.
//  Copyright © 2016年 zxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMSuccessView : UIView

- (void)layoutViews;
- (void)animat;// 停留2s然后1s渐消

-(void) showWithText:(NSString *)str;

@end
