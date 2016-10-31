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

@interface MultiViewController ()

@property (nonatomic, strong) UITableView *multiTableView;

@end

static NSString * const TextBarCollectionCellID = @"TextBarCollectionCellID";
static NSString * const NormalTableViewCellID = @"NormalTableViewCellID";

@implementation MultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.multiTableView];
    
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
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:TextBarCollectionCellID forIndexPath:indexPath];
        TextBarCollectionCell *collectionCell = (TextBarCollectionCell *)cell;
        
        
    }else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:NormalTableViewCellID forIndexPath:indexPath];
        NormalTableViewCell *normalCell = (NormalTableViewCell *)cell;
        
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 180.f;
    }else{
        return 160.f;
    }
}

#pragma mark - getter
- (UITableView *)multiTableView
{
    if (!_multiTableView) {
        _multiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
        _multiTableView.delegate = self;
        _multiTableView.dataSource = self;
        
        [_multiTableView registerClass:[TextBarCollectionCell class] forCellReuseIdentifier:TextBarCollectionCellID];
        [_multiTableView registerClass:[NormalTableViewCell class] forCellReuseIdentifier:NormalTableViewCellID];
    }
    return _multiTableView;
}

@end
