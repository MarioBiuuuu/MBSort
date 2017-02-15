//
//  ViewController.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/13.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "ViewController.h"

#import "SortStringViewController.h"
#import "SortObjectViewController.h"

#import "BaseTableViewDataSource.h"
#import "UITableViewCell+ConfigureUI.h"

static NSString * const kSortCellIdentifier = @"sortCellIdentifier";

@interface ViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BaseTableViewDataSource *tableViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排序";
    
    [self setupTableView];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSortCellIdentifier];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    }
    return _tableView;
}

- (BaseTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        
        _tableViewDataSource = [BaseTableViewDataSource dataSourceWithItems:@[@"对字符串数据进行排序", @"根据属性对模型对象数据进行排序"] cellReuserID:kSortCellIdentifier configureCellBlock:^(id cell, id item) {
            [cell configureForString:item];
        }] ;
        
    }
    return _tableViewDataSource;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[SortStringViewController alloc] init] animated:YES];
    } else {
        [self.navigationController pushViewController:[[SortObjectViewController alloc] init] animated:YES];
    }
}

@end
