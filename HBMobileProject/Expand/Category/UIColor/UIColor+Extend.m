

#import "UIColor+Extend.h"

@implementation UIColor(Extend)
+ (id)r:(int)r g:(int)g b:(int)b
{
    return [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f];
}

+ (id)rgba: (int32_t)c
{
    return [UIColor colorWithRed:((c>>24)&0XFF)/255.f
                           green:((c>>16)&0XFF)/255.f
                            blue:((c>>8)&0XFF)/255.f
                           alpha:(c&0XFF)/255.f];
}

+ (id)colorEase: (CGFloat)f begin: (uint32_t)begin end: (uint32_t)end
{
    if (f < 0.00001)
    {
        f = 0;
    }
    else if (f > 0.99999)
    {
        f = 1;
    }
    uint32_t color = 0;
    uint8_t b = 0;
    uint8_t e = 0;
    uint8_t c = 0;
    for (int i = 0; i < 4; ++i)
    {
        b = (begin & 0XFF);
        e = (end & 0XFF);
        c = begin + (uint8_t)(((int)e-(int)b)*f);
        color |= (c << i*8);
        begin >>= 8;
        end >>= 8;
    }
    
    return [UIColor rgba: color];
}

+ (id)commonViewCellBg
{
    return [UIColor rgba: 0xedededFF];
}

+ (id)commonViewCellShadow
{
    return [UIColor rgba: 0x0000019];
}

+ (id)commonViewCellBtn
{
    return [UIColor rgba: 0x25c997FF];
}

+ (id)commonViewCellPressBtn
{
    return [UIColor rgba: 0x21b588FF];
}

+ (id)commonViewPressBg
{
    return [UIColor rgba: 0xf0f0f0FF];
}

+ (id)commonViewLine
{
    return [UIColor rgba: 0xDCDCDCFF];
}

+ (id)commonTitleColor
{
    return [UIColor rgba: 0x323232FF];
}

+ (id)commonTabBarBgColor
{
    return [UIColor rgba: 0xf4f4f4FF];
}

+ (id)subTitleColor
{
    return [UIColor rgba: 0x666666FF];
}

+ (id)socailCommTitleColor
{
    return RGB(18, 196, 190);
}

+ (id)socailRegCommentTitleDescColor
{
    return [UIColor rgba: 0x888888FF];
}

+ (id)socailRegCommentNickNameColor
{
    return [UIColor rgba: 0x576B95FF];
}

+ (id)socailRegCommentContentColor
{
    return [UIColor rgba: 0x323232FF];
}

+ (id)socailCommSendBgColor
{
    return [UIColor rgba: 0xf6f6f7FF];
}

+ (id)socailCommSendBtnBgColor
{
    return [UIColor rgba: 0x2DC799FF];
}

+ (id)socailCommSendBtnPressBgColor
{
    return [UIColor rgba: 0x2DC7997F];
}

+ (id)socialCommentEdtFrameColor
{
    return [UIColor rgba: 0xCCCCCCFF];
}

+ (id)loadMoreTextColor
{
    return [UIColor rgba: 0x888888FF];
}

+ (id)homeViewHeaderBgColor
{
    return [UIColor rgba: 0x2FC08fFF];
}

+ (id)homeViewTabBarBtnTextNormalColor
{
    return [UIColor rgba: 0x808692FF];
}

+ (id)homeViewTabBarBtnTextPressedColor
{
    return [UIColor rgba: 0x20d4d2FF];
}

+ (id)homeCellViewTitleTextColor
{
    return [UIColor rgba: 0x333333FF];
}

+ (id)bukaOriangeText
{
    return [UIColor rgba:0XF69626FF];
}

+ (id)homeHeadViewBgColor
{
    return [UIColor rgba: 0x2FC08FFF];
}

+ (id)homeHeadViewHealthBtnTitleColor
{
    return [UIColor rgba: 0x00c5b9FF];
}

//regist注册
+ (id)verificationBtnTitleColor
{
    return [UIColor rgba:0x25c997FF];
}

+ (id)verificationBtnDisableTitleColor
{
    return [UIColor rgba:0xc3c3c3FF];
}

+ (id)passwordTipsTextColor
{
    return [UIColor rgba:0xc92525FF];
}

+ (id)registLineBgColor
{
    return [UIColor rgba:0x000000FF];
}
+(id)registViewBgColor
{
    return [UIColor rgba:0x117ed2FF];
}
+(id)unifiedBtnTitleColor
{
    return [UIColor rgba:0xffffffFF];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end

