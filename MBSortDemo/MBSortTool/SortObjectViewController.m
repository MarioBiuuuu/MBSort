//
//  SortObjectViewController.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "SortObjectViewController.h"
#import "MBSort.h"
#import "Student.h"
#import "BaseTableViewDataSource.h"
#import "UITableViewCell+ConfigureUI.h"

static NSString * const kSortCellIdentifier = @"sortObjCellIdentifier";

@interface SortObjectViewController ()

@property (nonatomic, strong) BaseTableViewDataSource *tableViewDataSource;

@property (nonatomic, strong) NSMutableArray *stds;

@end

@implementation SortObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
}

- (void)setupTableView {
    
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSortCellIdentifier];
    
}

- (BaseTableViewDataSource *)tableViewDataSource {
    if (!_tableViewDataSource) {
        
        _tableViewDataSource = [BaseTableViewDataSource dataSourceWithItems:[MBSort MB_sortOriginalObjects:self.stds keyProperty:@"name" sortType:MBSortTypeKeyValue] cellReuserID:kSortCellIdentifier configureCellBlock:^(id cell, id item) {
            [cell configureForObj:item];
        }] ;
        
    }
    return _tableViewDataSource;
}

- (NSMutableArray *)stds {
    if (!_stds) {
        _stds = [NSMutableArray array];
        NSArray *nameArray = @[@"鲁迅", @"###", @"***", @"😀", @"赵四", @"刘能", @"尼古拉斯 四爷", @"Adrian", @"😭", @"干死这群小比崽子", @"😀😀😀😀", @"🐝🐝🐝🐝", @"我的名字就是空", @" 我的名字就是空", @"Yep", @"苗二蛋", @"邓恒宇", @"老Gay", @"哪吒", @"王麻子", @"JJJJ", @"毕福剑", @"小泽玛利亚", @"苍老师", @"范 迪塞尔", @"赵子龙", @"胡汉三"];
    
        for (NSString *name in nameArray) {
            Student *std = [[Student alloc] initWithName:name score:arc4random()%120];
            [_stds addObject:std];
        }
    }
    return _stds;
}

@end
