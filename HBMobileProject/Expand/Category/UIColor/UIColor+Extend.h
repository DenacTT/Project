

#import <UIKit/UIKit.h>

@interface UIColor(Extend)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (id)r: (int)r g:(int)g b:(int)b;
+ (id)rgba: (int32_t)c;
+ (id)colorEase: (CGFloat)f begin: (uint32_t)begin end: (uint32_t)end;

+ (id)commonViewCellBg;
+ (id)commonViewCellShadow;
+ (id)commonViewCellBtn;
+ (id)commonTitleColor;
+ (id)subTitleColor;
+ (id)commonViewCellPressBtn;
+ (id)commonViewPressBg;
+ (id)commonViewLine;
+ (id)commonTabBarBgColor;
+ (id)socailCommTitleColor;
+ (id)socailRegCommentTitleDescColor;
+ (id)socailRegCommentNickNameColor;
+ (id)socailRegCommentContentColor;
+ (id)socailCommSendBgColor;
+ (id)socailCommSendBtnBgColor;
+ (id)socailCommSendBtnPressBgColor;
+ (id)socialCommentEdtFrameColor;
+ (id)loadMoreTextColor;
+ (id)homeViewHeaderBgColor;
+ (id)homeViewTabBarBtnTextNormalColor;
+ (id)homeViewTabBarBtnTextPressedColor;
+ (id)homeCellViewTitleTextColor;
+ (id)homeHeadViewBgColor;
+ (id)homeHeadViewHealthBtnTitleColor;
+ (id)bukaOriangeText;

//regist注册
+ (id)verificationBtnTitleColor;
+ (id)verificationBtnDisableTitleColor;
+ (id)passwordTipsTextColor;
+ (id)registLineBgColor;
+ (id)registViewBgColor;
+ (id)unifiedBtnTitleColor;

//生成一个随机色
+ (UIColor *)randomColor;
@end
