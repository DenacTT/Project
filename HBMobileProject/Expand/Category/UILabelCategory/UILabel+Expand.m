//
//  UILabel+Expand.m
//  scale
//
//  Created by HarbingWang on 16/10/17.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "UILabel+Expand.h"

@implementation UILabel (Expand)
- (void)setLineSpace:(NSInteger)lineSpace
{
    if (self.text.length > 0) {
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString: self.text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = lineSpace/2;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        [attributedString addAttribute: NSParagraphStyleAttributeName value: paragraphStyle range:NSMakeRange(0, [self.text length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}
@end
