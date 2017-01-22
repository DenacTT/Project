//
//  YMActionSheet.h
//  HBMobileProject
//
//  Created by HarbingWang on 17/1/19.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMActionSheet;

typedef void(^SelectBlock)(YMActionSheet *actionSheet, NSInteger index);


@interface YMActionSheet : UIView

// Creat YMActionSheet with a Block;
// title, cancelTitle, destructiveTitle 均为可选;设置为 nil 时对应的 Item 将不显示;
// otherImages 可选, 当设置为无图片时默认 title 居中显示; 当设置为有图片时,图片名不能为空,图片/文字默认居左显示;
+ (instancetype)actionSheetViewWithTitle:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                        destructiveTitle:(NSString *)destructiveTitle
                             otherTitles:(NSArray  *)otherTitles
                             otherImages:(NSArray  *)otherImages
                             selectBlock:(SelectBlock)selectBlock;

- (void)show;

@end

