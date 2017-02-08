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
#define kSeparateLineHeight   7.0

#define kTitleFontSize        SCREEN_ADJUST(15)
//#define kActionItemFontSize   SCREEN_ADJUST(17)
#define kActionItemFontSize [UIFont systemFontOfSize:SCREEN_ADJUST(17)]

#define kActionSheetColor            [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]
#define kTitleColor                  [UIColor colorWithRed:111.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
#define kActionItemHighlightedColor  [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define kDestructiveItemNormalColor  [UIColor colorWithRed:255.0f/255.0f green:10.00f/255.0f blue:10.00f/255.0f alpha:1.0f]

@interface YMActionSheet ()

@property (nonatomic, weak) id<YMActionSheetDelegate>delegate;

@property (nonatomic, copy) SelectBlock selectBlock;

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIView *actionSheet;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancleTitle;
@property (nonatomic, copy) NSString *destructiveTitle;
@property (nonatomic, copy) NSArray  *otherTitles;
@property (nonatomic, copy) NSArray  *otherImages;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat actionSheetHeight;

@property (nonatomic, strong) NSMutableArray *otherActionItems;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@end

@implementation YMActionSheet

#pragma mark - Block
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
        
        _title              = title;
        _cancleTitle        = cancelTitle;
        _destructiveTitle   = destructiveTitle;
        _otherTitles = otherTitles;
        _otherImages = otherImages;
        _selectBlock = selectBlock;
        
        [self setupCoverView];
        [self setupActionSheet];
    }
    return self;
}

#pragma mark - Delegate
+ (instancetype)actionSheetViewWithTitle:(NSString *)title
                             cancelTitle:(NSString *)cancelTitle
                        destructiveTitle:(NSString *)destructiveTitle
                             otherTitles:(NSArray  *)otherTitles
                             otherImages:(NSArray  *)otherImages
                                delegate:(id<YMActionSheetDelegate>)delegate
{
    return [[self alloc] initWithTitle:title
                           cancelTitle:cancelTitle
                      destructiveTitle:destructiveTitle
                           otherTitles:otherTitles
                           otherImages:otherImages
                              delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                  otherImages:(NSArray  *)otherImages
                     delegate:(id<YMActionSheetDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancleTitle      = cancelTitle;
        _destructiveTitle = destructiveTitle;
        _otherTitles      = otherTitles;
        _otherImages      = otherImages;
        _delegate         = delegate;
        [self setupCoverView];
        [self setupActionSheet];
    }
    return self;
}

#pragma mark - Setup UI
- (void)setupCoverView {
    
    [self addSubview:({
        UIView *coverView = [[UIView alloc] init];
        coverView.frame = self.bounds;
        coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _coverView = coverView;
    })];
    _coverView.alpha = 0;
}

- (void)setupActionSheet {
    [self addSubview:({
        UIView *actionSheet = [[UIView alloc] init];
        actionSheet.backgroundColor = kActionSheetColor;
        self.actionSheet = actionSheet;
    })];
    
    [self setupTitleLabel];
    [self setupOtherActionItem];
    [self setupDestructiveItem];
    [self setupCancelActionItem];
    
    _actionSheet.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _offsetY);
    _actionSheetHeight = _offsetY;
}

// 顶部标题
- (void)setupTitleLabel {
    
    _offsetY = 0.0;
    if (_title && _title.length > 0) {
        [_actionSheet addSubview:({
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kActionItemHeight)];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textColor = kTitleColor;
            titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
            titleLabel.text = self.title;
            titleLabel;
        })];
        _offsetY += kActionItemHeight + kLineHeight;
    }
}

// 选项Item
- (void)setupOtherActionItem {
    if (_otherTitles && _otherTitles.count > 0) {
        for (int i = 0; i < _otherTitles.count; i++) {
            
            NSString *title = _otherTitles[i];
            if ([title  isEqualToString:@""]) {
                return;
            }
            
            [_actionSheet addSubview:({
                UIButton *otherBtn = [[UIButton alloc] init];
                otherBtn.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
                otherBtn.backgroundColor = [UIColor whiteColor];
                otherBtn.tag = i;
                
                [otherBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
                [otherBtn setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
                [otherBtn addTarget:self action:@selector(didSelectActionSheet:) forControlEvents:UIControlEventTouchUpInside];
                [otherBtn addSubview:({
                    UIView *otherItem = [[UIView alloc] init];
                    otherItem.backgroundColor = [UIColor clearColor];
                    CGSize maxTitleSize = [self maxSizeInString:_otherTitles];
                    if (_otherImages && _otherImages.count > 0) {
                        UIImageView *icon = [[UIImageView alloc] init];
                        [otherItem addSubview:({
                            icon.frame = CGRectMake(0, 0, kActionItemHeight, kActionItemHeight);
                            icon.image = _otherImages.count > i ? _otherImages[i] : nil;
                            icon.contentMode = UIViewContentModeCenter;
                            icon.tag = 2;
                            icon;
                        })];
                        
                        [otherItem addSubview:({
                            UILabel *title = [[UILabel alloc] init];
                            title.frame = CGRectMake(CGRectGetMaxX(icon.frame), 0, maxTitleSize.width, kActionItemHeight);
                            title.font = kActionItemFontSize;
                            title.tintColor = [UIColor blackColor];
                            title.text = _otherTitles[i];
                            title.tag = 1;
                            title;
                        })];
                        otherItem.frame = CGRectMake(10, 0, kActionItemHeight + maxTitleSize.width, kActionItemHeight);
                        
                    } else {
                        
                        [otherItem addSubview:({
                            UILabel *title = [[UILabel alloc] init];
                            title.frame = CGRectMake(0, 0, maxTitleSize.width, kActionItemHeight);
                            title.font = kActionItemFontSize;
                            title.tintColor = [UIColor blackColor];
                            title.text = _otherTitles[i];
                            title.textAlignment = NSTextAlignmentCenter;
                            title.tag = 1;
                            title;
                        })];
                        otherItem.frame = CGRectMake(self.frame.size.width * 0.5 - maxTitleSize.width * 0.5, 0, maxTitleSize.width, kActionItemHeight);
                    }
                    
                    [self.otherActionItems addObject:otherItem];
                    otherItem.userInteractionEnabled = NO;
                    otherItem;
                })];
                
                if (i == _otherTitles.count - 1) {
                    _offsetY += kActionItemHeight;
                }else{
                    _offsetY += kActionItemHeight + kLineHeight;
                }
                otherBtn;
            })];
        }
    }
}

// 确定按钮
- (void)setupDestructiveItem
{
    if (_destructiveTitle && _destructiveTitle.length > 0)
    {
        _offsetY += kLineHeight;
        [_actionSheet addSubview:({
            UIButton *destBtn = [[UIButton alloc] init];
            destBtn.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
            destBtn.backgroundColor = [UIColor whiteColor];
            destBtn.tag = _otherTitles.count ? _otherTitles.count : 0;
            
            [destBtn.titleLabel setFont:kActionItemFontSize];
            [destBtn setTitleColor:kDestructiveItemNormalColor forState:UIControlStateNormal];
            [destBtn setTitle:_destructiveTitle forState:UIControlStateNormal];
            [destBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
            [destBtn setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
            
            [destBtn addTarget:self action:@selector(didSelectActionSheet:) forControlEvents:UIControlEventTouchUpInside];
            destBtn;
        })];
        _offsetY += kActionItemHeight;
    }
}

// 取消按钮
- (void)setupCancelActionItem {
    if (_cancleTitle && _cancleTitle.length > 0) {
        _offsetY += kSeparateLineHeight;
        [_actionSheet addSubview:({
            UIButton *cancelBtn = [[UIButton alloc] init];
            cancelBtn.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
            cancelBtn.backgroundColor = [UIColor whiteColor];
            cancelBtn.tag = -1;
            
            [cancelBtn.titleLabel setFont:kActionItemFontSize];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cancelBtn setTitle:_cancleTitle forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
            
            [cancelBtn addTarget:self action:@selector(didSelectActionSheet:) forControlEvents:UIControlEventTouchUpInside];
            cancelBtn;
        })];
        _offsetY += kActionItemHeight;
    }
}

#pragma mark - Actions
- (void)didSelectActionSheet:(UIButton *)button {
    if (_selectBlock) {
        _selectBlock(self, button.tag);
    }
    [self dismiss];
}

#pragma mark - Animations
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.coverView.alpha = 1.0;
                         self.actionSheet.transform = CGAffineTransformMakeTranslation(0, -self.actionSheetHeight);
                     } completion:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.coverView.alpha = 0.0;
                         //还原之前的偏移量
                         self.actionSheet.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - OtherMethods
- (void)setOtherActionItemAlignment:(YMOtherActionItemAlignment)otherActionItemAlignment {
    _otherActionItemAlignment = otherActionItemAlignment;
    if (otherActionItemAlignment) {
        
        switch (otherActionItemAlignment) {
            case YMOtherActionItemAlignmentLeft:
                for (UIView *actionItem in self.otherActionItems) {
                    UILabel *title = [actionItem viewWithTag:1];
                    title.textAlignment = NSTextAlignmentLeft;
                    CGRect newFrame = actionItem.frame;
                    newFrame.origin.x = 10;
                    actionItem.frame = newFrame;
                }
                break;
            case YMOtherActionItemAlignmentCenter:
                for (UIView *actionItem in self.otherActionItems) {
                    UILabel *title = [actionItem viewWithTag:1];
                    title.textAlignment = NSTextAlignmentCenter;
                    CGRect newFrame = actionItem.frame;
                    newFrame.origin.x = self.frame.size.width * 0.5 - newFrame.size.width * 0.5;
                    actionItem.frame = newFrame;
                }
                break;
            default:
                break;
        }
        
    }
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

- (CGSize)maxSizeInString:(NSArray *)strings {
    CGSize maxSize = CGSizeZero;
    CGFloat maxWith = 0.0;
    for (NSString *string in strings) {
        CGSize size = [self sizeOfString:string withFont:kActionItemFontSize];
        if (maxWith < size.width) {
            maxWith = size.width;
            maxSize = size;
        }
    }
    return maxSize;
}

- (CGSize)sizeOfString:(NSString *)string withFont:(UIFont *)font {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
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
