//
//  MultiViewController.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/10/31.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//

#import "MultiViewController.h"
#import "TextBarCollectionCell.h"
#import "NormalTableViewCell.h"

@interface MultiViewController ()<TextBarCollectionCellDelegate>

@property (nonatomic, strong) UITableView *multiTableView;

@end

static NSString * const TextBarCollectionCellID = @"TextBarCollectionCellID";
static NSString * const NormalTableViewCellID = @"NormalTableViewCellID";

@implementation MultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.multiTableView];
    
    [_multiTableView registerClass:[TextBarCollectionCell class] forCellReuseIdentifier:TextBarCollectionCellID];
    [_multiTableView registerClass:[NormalTableViewCell class] forCellReuseIdentifier:NormalTableViewCellID];
}

#pragma mark - Tableview DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 1;
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {
        TextBarCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:TextBarCollectionCellID];
        if (cell == nil) {
            cell = [[TextBarCollectionCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TextBarCollectionCellID];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
    
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalTableViewCellID];
        if (cell == nil) {
            cell = [[NormalTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NormalTableViewCellID];
        }
        
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 188.f;
    }else{
        return 160.f;
    }
}

#pragma mark - TextBarCollectionCellDelegate
- (void)rightButtonClick:(UITableViewCell *)cell
{
    NSLog(@"rightButton");
}

- (void)selectButtonIndex:(NSInteger)index didSelected:(UITableViewCell *)cell
{
    NSLog(@"selectButtonIndex %zi", index);
}

#pragma mark - getter
- (UITableView *)multiTableView
{
    if (!_multiTableView) {
        _multiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStylePlain)];
        _multiTableView.delegate = self;
        _multiTableView.dataSource = self;
        _multiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _multiTableView;
}

@end
