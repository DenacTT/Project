//
//  YMActionSheet.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/1/19.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMActionSheet;

typedef void(^ActionSheetDidSelectBlock)(YMActionSheet *actionSheet, NSInteger index);


@interface YMActionSheet : UIView

// Creat YMActionSheet with a Block;
- (instancetype)actionSheetViewWithTitle:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                        destructiveTitle:(NSString *)destructiveTitle
                             otherTitles:(NSArray  *)otherTitles
                             otherImages:(NSArray  *)otherImages
                             selectBlock:(ActionSheetDidSelectBlock)selectBlock;

- (void)show;

@end

