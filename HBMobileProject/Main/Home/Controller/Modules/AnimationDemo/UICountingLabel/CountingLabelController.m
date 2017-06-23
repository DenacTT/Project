//
//  CountingLabelController.m
//  HBMobileProject
//
//  Created by HarbingW on 2017/6/23.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "CountingLabelController.h"
#import "UICountingLabel.h"

@interface CountingLabelController ()

@property (nonatomic, strong) UICountingLabel *label;

@end

@implementation CountingLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // make one that counts up
    UICountingLabel *myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-100, 84, 200, 40)];
    myLabel.font = Font(30);
    myLabel.textColor = [UIColor orangeColor];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.method = UILabelCountingMethodLinear;
    myLabel.format = @"%d";
    [self.view addSubview:myLabel];
    [myLabel countFrom:1 to:100 withDuration:3.0];
    
    // make one that counts up from 5% to 10%, using ease in out (the default)
    UICountingLabel *countPercentageLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(myLabel.left, myLabel.bottom+50, 200, 40)];
    countPercentageLabel.font = Font(30);
    countPercentageLabel.textColor = [UIColor orangeColor];
    countPercentageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:countPercentageLabel];
    countPercentageLabel.format = @"%.1f%%";
    [countPercentageLabel countFrom:5 to:100];
    
    
    
    // count up using a string that uses a number formatter
    UICountingLabel *scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(countPercentageLabel.left, countPercentageLabel.bottom+50, 200, 40)];
    scoreLabel.font = Font(30);
    scoreLabel.textColor = [UIColor orangeColor];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:scoreLabel];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    scoreLabel.formatBlock = ^NSString *(CGFloat value)
    {
        NSString *formatted = [formatter stringFromNumber:@((int)value)];
        return [NSString stringWithFormat:@"Score: %@",formatted];
    };
    scoreLabel.method = UILabelCountingMethodEaseOut;
    [scoreLabel countFrom:0 to:10000 withDuration:2.5];
    
    // count up with attributed string
    NSInteger toValue = 100;
    
    UICountingLabel *attributedLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(scoreLabel.left, scoreLabel.bottom+50, 200, 40)];
    attributedLabel.font = Font(30);
    attributedLabel.textColor = [UIColor orangeColor];
    attributedLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:attributedLabel];
    attributedLabel.attributedFormatBlock = ^NSAttributedString *(CGFloat value)
    {
        NSDictionary *normal = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 30] };
        NSDictionary *highlight = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size:
                                                           30] };
        
        NSString *prefix = [NSString stringWithFormat:@"%d", (int)value];
        NSString *postfix = [NSString stringWithFormat:@"/%d", (int)toValue];
        
        NSMutableAttributedString *prefixAttr = [[NSMutableAttributedString alloc] initWithString: prefix
                                                                                       attributes: highlight];
        NSAttributedString *postfixAttr = [[NSAttributedString alloc] initWithString: postfix
                                                                          attributes: normal];
        [prefixAttr appendAttributedString: postfixAttr];
        
        return prefixAttr;
    };
    [attributedLabel countFrom:0 to:toValue withDuration:2.5];
    
    self.label.method = UILabelCountingMethodEaseInOut;
    self.label.format = @"%d%%";
    __weak CountingLabelController *blockSelf = self;
    self.label.completionBlock = ^{
        blockSelf.label.textColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    };
    [self.label countFrom:0 to:100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
