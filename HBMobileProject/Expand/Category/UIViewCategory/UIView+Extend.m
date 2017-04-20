
#import "UIView+Extend.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView(Extend)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.bounds.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.bounds.size.height;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - self.frame.size.width;
    self.frame = rect;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - self.frame.size.height;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)centerToParentX: (UIView*)view
{
    CGRect rect = self.frame;
    CGFloat yy = view.bounds.size.width;
    rect.origin.x = (yy - rect.size.width) / 2.f;
    self.frame = rect;
}

- (void)centerToParentY: (UIView*)view
{
    CGRect rect = self.frame;
    rect.origin.y = (view.bounds.size.height - rect.size.height) / 2.f;
    self.frame = rect;
}

- (void)centerToParentY:(UIView *)view withOffset:(CGFloat)offset
{
    CGRect rect = self.frame;
    rect.origin.y = (view.bounds.size.height - rect.size.height) / 2 + offset;
    self.frame = rect;
}

- (void)centerToParent:(UIView *)view
{
    CGRect rect = self.frame;
    rect.origin.x = (view.bounds.size.width - rect.size.width) / 2.f;
    rect.origin.y = (view.bounds.size.height - rect.size.height) / 2.f;
    self.frame = rect;
}

- (void)centerAlign: (UIView*)view
{
    CGRect rect = self.frame;
    rect.origin.x = view.frame.origin.x + (view.bounds.size.width-rect.size.width) / 2.f;
    rect.origin.y = view.frame.origin.y + (view.bounds.size.height-rect.size.height) / 2.f;
    self.frame = rect;
}

- (void)centerAlignX: (UIView*)view
{
    CGRect rect = self.frame;
    rect.origin.x = view.frame.origin.x + (view.bounds.size.width-rect.size.width) / 2.f;
    self.frame = rect;
}

- (void)centerAlignY:(UIView *)view
{
    CGRect rect = self.frame;
    rect.origin.y = view.frame.origin.y + (view.bounds.size.height-rect.size.height) / 2.f;
    self.frame = rect;
}
- (BOOL)nearTo: (CGPoint)point lag: (CGFloat)lag
{
    CGRect frame = self.frame;
    frame.origin.x -= lag;
    frame.origin.y -= lag;
    frame.size.width += lag * 2;
    frame.size.height += lag * 2;
    return CGRectContainsPoint(frame, point);
}

- (UIImage*)toUIImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return retImage;
}

@end



