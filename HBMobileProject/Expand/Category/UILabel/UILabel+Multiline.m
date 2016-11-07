//
//  UILabel+Multiline.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/7.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UILabel+Multiline.h"
#import <objc/runtime.h>

@implementation UILabel (Multiline)

- (void)setSingleLine:(BOOL)isSingleLine
{
    objc_setAssociatedObject(self, @selector(isSingleLine), [NSNumber numberWithBool:isSingleLine], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSingleLine
{
    return [objc_getAssociatedObject(self, @selector(isSingleLine)) boolValue];
}

- (void)setLabelTextSize:(CGSize)labelTextSize
{
    objc_setAssociatedObject(self, @selector(labelTextSize), [NSValue valueWithCGSize:labelTextSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)labelTextSize
{
    return [objc_getAssociatedObject(self, @selector(labelTextSize)) CGSizeValue];
}

/*******************************************
 
 objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 
 * 关联对象 objc_setAssociatedObject
 * 用这个方法将一个对象与另一个对象进行关联.
 * 需要四个参数,分别是: 源对象 关键字 需要关联的对象 一个关联策略
 
 * 关键字是一个 void类型的指针 每一个关联的关键字必须是唯一的 通常采用静态变量来作为关键字
 * 关联策略表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的。
 * 详见 http://www.cnblogs.com/polobymulberry/p/5000431.html
********************************************/


#pragma mark - 设置文本多行可控间距显示
- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainerSize
{
    // 限制行数
    self.numberOfLines = lines;
    if (!text || text.length == 0) {
        return CGSizeZero;
    }
    
    self.labelTextSize =
    
}

#pragma mark - 计算文本占用的size
+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont *)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainerSize
{
    
}

#pragma mark - 私有方法
// 判断是否为单行
- (BOOL)isSingleLineTextHeight:(CGFloat)height font:(UIFont *)font
{
    BOOL isSingle = NO;
    CGFloat oneRowHeight = [@"单行文本" sizeWithAttributes:@{NSFontAttributeName : font}].height;
    
    // fabs() 求浮点型数据的绝对值
    if (fabs(height - oneRowHeight) < -0.001f) {
        isSingle = YES;
    }
    return isSingle;
}

// 计算文本占用的 Size
- (CGSize)calculateSizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont *)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainerSize
{
    if (!text || text.length == 0) {
        return CGSizeZero;
    }
    
    NSString *firstWord = [text substringToIndex:1];
    
    CGFloat oneRowHeight = [firstWord sizeWithAttributes:@{NSFontAttributeName : font}].height;
    CGSize textSize = [text boundingRectWithSize:constrainerSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    
    CGFloat rows = textSize.height / oneRowHeight;
    CGFloat realHeight = oneRowHeight;
    
    // lines = 0 不限制行数
    if (lines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows >= lines) {
            rows = lines;
        }
        realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
    }
    return CGSizeMake(textSize.width, realHeight);
}

- (void)adjustLabelContent
{
    if (self.isSingleLine) {
        // 固定原始 label 的大小,避免文本太多,单行显示时超过 labelSize
        [self sizeThatFits:self.labelTextSize];
    }else{
        // 调整 label 的宽和高,使它根据字符串的大小做合适的改变,避免多行显示时文本不从顶部往下排版.
        [self sizeToFit];
    }
}

@end
