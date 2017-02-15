//
//  SortStringViewController.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "SortStringViewController.h"
#import "MBSort.h"
#import "BaseTableViewDataSource.h"
#import "UITableViewCell+ConfigureUI.h"

static NSString * const kSortCellIdentifier = @"sortStringCellIdentifier";

@interface SortStringViewController ()

@property (nonatomic, copy) NSArray *nameArray;

@property (nonatomic, copy) NSArray *sortValueArray;

@property (nonatomic, copy) NSArray *sortKeyArray;

@property (nonatomic, strong) BaseTableViewDataSource *tableViewDataSource;

@end

@implementation SortStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    [self setupNav];
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = @[@"鲁迅", @"###", @"***", @"😀", @"赵四", @"刘能", @"尼古拉斯 四爷", @"Adrian", @"😭", @"干死这群小比崽子", @"😀😀😀😀", @"🐝🐝🐝🐝", @"我的名字就是空", @" 我的名字就是空", @"Yep", @"苗二蛋", @"邓恒宇", @"老Gay", @"哪吒", @"王麻子", @"JJJJ", @"毕福剑", @"小泽玛利亚", @"苍老师", @"范 迪塞尔", @"赵子龙", @"胡汉三"];
    }
    return _nameArray;
}

- (void)configTableView {
    self.sortKeyArray = [MBSort MB_sortOriginalStrings:self.nameArray sortType:MBSortTypeKeyValue];
    self.sortValueArray = [MBSort MB_sortOriginalStrings:self.nameArray sortType:MBSortTypeOriginalValue];
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSortCellIdentifier];

}

- (BaseTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        
        _tableViewDataSource = [BaseTableViewDataSource dataSourceWithItems:self.nameArray cellReuserID:kSortCellIdentifier configureCellBlock:^(id cell, id item) {
            [cell configureForString:item];
        }] ;
        
    }
    return _tableViewDataSource;
}

- (void)setupNav {
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"原始数据", @"默认排序", @"带key"]];
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(changeSortType:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = seg;
}

- (void)changeSortType:(UISegmentedControl *)seg {
    NSArray *dataArr;
    if (seg.selectedSegmentIndex == 0) {
        dataArr = [self.nameArray copy];
    } else if (seg.selectedSegmentIndex == 1) {
        dataArr = [self.sortValueArray copy];
    } else {
        dataArr = [self.sortKeyArray copy];
    }
    
    _tableViewDataSource = [BaseTableViewDataSource dataSourceWithItems:dataArr cellReuserID:kSortCellIdentifier configureCellBlock:^(id cell, id item) {
        [cell configureForString:item];
    }];
    self.tableView.dataSource = _tableViewDataSource;
    [self.tableView reloadData];
}
@end
