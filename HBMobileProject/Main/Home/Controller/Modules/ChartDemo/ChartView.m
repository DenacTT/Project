//
//  ChartView.m
//  HBMobileProject
//
//  Created by HarbingWang on 17/3/24.
//  Copyright © 2017年 HarbingWang. All rights reserved.
//

#import "ChartView.h"
#import "JHChartHeader.h"

@interface ChartView ()

@end

@implementation ChartView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isUseBackBtn  = YES;
    self.isUseRightBtn = YES;
    
    self.rightBtn.frame = CGRectMake(ScreenWidth-80, self.titleLabel.center.y-24/2, 80, 24);
    [self.rightBtn setTitle:@"随机" forState:UIControlStateNormal];
    
    switch (_index) {
        case 0:
            // 折线图
            [self showLineChartView];
            break;
            
        default:
            break;
    }
}

#pragma mark - 折线图
- (void)showLineChartView {
    
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10, self.navView.bottom, ScreenWidth, 300) andLineChartType:JHChartLineEveryValueForEveryX];
    
    lineChart.xLineDataArr = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12];
    lineChart.valueArr = @[@[@"100",@"120",@"10",@60,@40,@90,@60,@70,@"50",@"102",@"10",@60]];
    lineChart.xAndYLineColor = [UIColor orangeColor];
    
    
    [self.view addSubview:lineChart];
    [lineChart showAnimation];
}

- (void)clickRightBtn {
    
}


@end
