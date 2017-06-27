//
//  LYCustomView.h
//  scale
//
//  Created by 李钰 on 16/7/21.
//  Copyright © 2016年 李钰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCustomView : UIView
@property(nonatomic,copy)NSString * title;//标题
#pragma mark - 带参数的控件（没有点击事件，能修改颜色、标题等等）
// 可修改title 默认绿色背景（title为标准）
- (id)initStandardViewForRadius:(CGFloat)radius TitleColor:(UIColor *)color Font:(UIFont *)font;
#pragma mark - 展示样式（只能修改位置）
/// 创建一个圆 作为背景
- (id)initRadius:(CGFloat )radius Color:(UIColor *)color;
/// 图片居中 圆作背景 （radius > image.size.height
- (id)initRadius:(CGFloat )radius Color:(UIColor *)color Image:(UIImage *)image;
/// 加载头像radius为头像宽度 url为头像url title为nil没有title 否则显示title
- (id)initWithRadius:(CGFloat)radius AndUrl:(NSString *)url AndTitle:(NSString *)title;
/// 分割线(横)
- (id)initLineViewWithWidth:(CGFloat)width;
/// 分割线（竖）
- (id)initLineViewWithHeight:(CGFloat)height;
#pragma mark -动画
/// 爱心运动 color圆球的背景颜色 offset为正颜色递增 为负递减 为0则不变
- (id)initLoveReplicatorWithColor:(UIColor *)color Offset:(CGFloat)offset;
/// 波动的音乐 √count为数量 color为单个背景颜色
- (id)initMusicReplicatorWithCount:(NSInteger)count musicBackgroundColor:(UIColor *)color;
/// 等待动画
- (id)initActivityAnimationWithBackgroundColor:(UIColor *)bgColor BorderColor:(UIColor *)borderColor;
/// 路劲动画
- (id)initFollowAnimation;
/// 单个圆动画color圆的颜色
- (id)initRadiusAnimationWithColor:(UIColor *)color;
/// 多个圆动画 color圆的颜色 count圆的数量（连成一排）
- (id)initRadiusMoreAnimationWithColor:(UIColor *)color Count:(NSInteger)count;
/// 三个圆旋转
- (id)initRadiusScaleAnimationWithColor:(UIColor *)color;
/// n个圆滚动动画
- (id)initRadiusAnyAnimationWithColor:(UIColor *)color;
@end
