
#import <UIKit/UIKit.h>

@interface UIView(Extend)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)centerToParent:(UIView *)view;
- (void)centerToParentX: (UIView*)view;
- (void)centerToParentY: (UIView*)view;
- (void)centerToParentY: (UIView *)view withOffset: (CGFloat)offset;
- (void)centerAlign: (UIView*)view;
- (void)centerAlignX: (UIView*)view;
- (void)centerAlignY:(UIView *)view;
- (BOOL)nearTo: (CGPoint)point lag: (CGFloat)lag;
- (UIImage*)toUIImage;

@end
