//
//  SBHomeViewCell.m
//  scale
//
//  Created by HarbingWang on 17/3/28.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "SBHomeViewCell.h"
#import "NSAttributedString+YYText.h"

#define UnitCals    @"Cals"
#define UnitMinute  @"min"
#define UnitHour    @"h"
#define UnitWeight  @"kg"
#define UnitKm      @"km"

@implementation SBHomeViewCell

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(244, 244, 244);
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.mainText];
        [self.contentView addSubview:self.subText];
    }
    return self;
}

#pragma mark - Setter
- (void)setValue:(SBHomeModel *)model {
    
//    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"SBHomeCellType_%zi@2x", model.cellType+1]];
    self.subText.text  = [NSString stringWithFormat:@"%@", model.subText];//append
    switch (model.cellType) {
        case SBHomeCellType_Exercise:
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi ", model.calsNum] unitStr:UnitCals];
            break;
        case SBHomeCellType_HeartRate:
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi/", model.heartRate] unitStr:UnitMinute];
            break;
        case SBHomeCellType_SleepTime:
        {
            self.mainText.attributedText = [self attributedSleepTime:model.sleepTime];
        }
            break;
        case SBHomeCellType_BodyWeight:
            self.mainText.attributedText = [self attributedNumStr:[NSString stringWithFormat:@"%zi ", model.weightNum] unitStr:UnitWeight];
            break;
        default:
            break;
    }
}

#pragma mark - 富文本
- (NSMutableAttributedString *)attributedNumStr:(NSString *)numStr unitStr:(NSString *)unitStr {
    
    NSString *originString = [numStr stringByAppendingString:unitStr];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:originString];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(0, numStr.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(numStr.length, unitStr.length)];
    return string;
}

- (NSMutableAttributedString *)attributedSleepTime:(NSInteger)sleepTime {
    
    NSString *hour = [NSString stringWithFormat:@"%zi", sleepTime / 60];
    NSString *mint = [NSString stringWithFormat:@"%zi", sleepTime % 60];
    NSString *hourUnit = UnitHour;
    NSString *mintUnit = UnitMinute;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@ %@%@", hour,hourUnit,mint,mintUnit]];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(0, hour.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(hour.length, hourUnit.length)];
    [string addAttribute:NSFontAttributeName value:Font(16) range:NSMakeRange(hour.length+hourUnit.length+1, mint.length)];
    [string addAttribute:NSFontAttributeName value:Font(14) range:NSMakeRange(hour.length+hourUnit.length+mint.length+1, hourUnit.length+2)];
    
    return string;
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.bounds)-90/2, 27, 90, 90)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = RGB(64, 159, 232);
    }
    return _imageView;
}

- (UILabel *)mainText {
    if (!_mainText) {
        _mainText = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom+5, CGRectGetWidth(self.bounds), 17)];
        [_mainText setLabelText:@""
                           font:Font(16)
                      textColor:RGB(0, 0, 0)
                  textAlignment:NSTextAlignmentCenter];
    }
    return _mainText;
}

- (UILabel *)subText {
    if (!_subText) {
        _subText = [[UILabel alloc] initWithFrame:CGRectMake(0, _mainText.bottom+4, CGRectGetWidth(self.bounds), 14)];
        [_subText setLabelText:@""
                          font:Font(12)
                     textColor:RGB(136, 136, 136)
                 textAlignment:NSTextAlignmentCenter];
    }
    return _subText;
}

@end
