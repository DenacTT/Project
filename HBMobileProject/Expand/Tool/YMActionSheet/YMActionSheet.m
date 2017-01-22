//
//  YMActionSheet.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/1/19.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "YMActionSheet.h"

#define SCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)  SCREEN_WIDTH * (Value) / 375.0

#define kActionItemHeight     SCREEN_ADJUST(50)
#define kLineHeight           0.5
#define kDividerHeight        7.5

#define kTitleFontSize        SCREEN_ADJUST(15)
#define kActionItemFontSize   SCREEN_ADJUST(17)

#define kActionSheetColor            [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]
#define kTitleColor                  [UIColor colorWithRed:111.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
#define kActionItemHighlightedColor  [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define kDestructiveItemNormalColor  [UIColor colorWithRed:255.0f/255.0f green:10.00f/255.0f blue:10.00f/255.0f alpha:1.0f]
#define kDividerColor                [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f]

@interface YMActionSheet ()

@property (nonatomic, copy) SelectBlock selectBlock;

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIView *actionSheet;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancleTitle;
@property (nonatomic, copy) NSString *destructiveTitle;
@property (nonatomic, copy) NSArray  *otherTitles;
@property (nonatomic, copy) NSArray  *otherImages;

@property (nonatomic, assign) CGFloat *offsetY;
@property (nonatomic, assign) CGFloat actionSheetHeight;

@property (nonatomic, strong) NSMutableArray *otherActionItems;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@end


@implementation YMActionSheet

+ (instancetype)actionSheetViewWithTitle:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                        destructiveTitle:(NSString *)destructiveTitle
                             otherTitles:(NSArray *)otherTitles
                             otherImages:(NSArray *)otherImages
                             selectBlock:(SelectBlock)selectBlock
{
    return [[self alloc] initWithTitle:(NSString *)title
                           cancelTitle:(NSString *)cancelTitle
                      destructiveTitle:(NSString *)destructiveTitle
                           otherTitles:(NSArray *)otherTitles
                           otherImages:(NSArray *)otherImages
                           selectBlock:(SelectBlock)selectBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray *)otherTitles
                  otherImages:(NSArray *)otherImages
                  selectBlock:(SelectBlock)selectBlock
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        
        
    }
    return self;
}

#pragma mark - show
- (void)show
{
    
}

#pragma mark - PreviteMethod
- (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - getter
- (NSMutableArray *)otherActionItems {
    if (!_otherActionItems) {
        _otherActionItems = [NSMutableArray array];
    }
    return _otherActionItems;
}

- (UIImage *)normalImage {
    if (!_normalImage) {
        _normalImage = [self createImageWithColor:[UIColor whiteColor]];
    }
    return _normalImage;
}

- (UIImage *)highlightedImage {
    if (!_highlightedImage) {
        _highlightedImage = [self createImageWithColor:kActionItemHighlightedColor];
    }
    return _highlightedImage;
}


@end
