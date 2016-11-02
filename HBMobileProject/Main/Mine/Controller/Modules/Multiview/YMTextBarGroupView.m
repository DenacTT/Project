//
//  YMTextBarGroupView.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/11/2.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "YMTextBarGroupView.h"
#import "NormalTableViewCell.h"

static NSString * const NormalTableViewCellID = @"NormalTableViewCell";

@interface YMTextBarGroupView ()

@property (nonatomic, strong) UITableView *groupTableView;

@end

@implementation YMTextBarGroupView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.groupTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
    [self.view addSubview:self.groupTableView];
    
    [_groupTableView registerClass:[NormalTableViewCell class] forCellReuseIdentifier:NormalTableViewCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalTableViewCellID];
    if (cell==nil) {
        cell = [[NormalTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NormalTableViewCellID];
    }
    
    return cell;
}


@end
