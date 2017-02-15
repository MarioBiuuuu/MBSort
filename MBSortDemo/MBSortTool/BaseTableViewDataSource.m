//
//  BaseTableViewDataSource.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "BaseTableViewDataSource.h"

@interface BaseTableViewDataSource ()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) BaseTableViewCellConfigureBlock configureCellBlock;

@end

@implementation BaseTableViewDataSource
+ (instancetype)dataSourceWithItems:(NSArray *)items cellReuserID:(NSString *)reuseID configureCellBlock:(BaseTableViewCellConfigureBlock)configureCellBlock {
    return [[self alloc] initWithItems:items cellReuserID:reuseID configureCellBlock:configureCellBlock];
}

- (instancetype)initWithItems:(NSArray *)items cellReuserID:(NSString *)reuseID configureCellBlock:(BaseTableViewCellConfigureBlock)configureCellBlock {
    if (self = [super init]) {
        self.items = items;
        self.cellIdentifier = reuseID;
        self.configureCellBlock = configureCellBlock;
    }
    return self;
}

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.items.firstObject isKindOfClass:[NSString class]]) {
        return self.items[(NSUInteger)indexPath.row];
    } else if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        NSArray *values = self.items[indexPath.section];
        return values[indexPath.row];
    } else {
        NSArray *values = [self.items[indexPath.section] objectForKey:@"SortValue"];
        return values[indexPath.row];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.items.firstObject isKindOfClass:[NSString class]]) {
        return 1;
    } else {
        return self.items.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.items.firstObject isKindOfClass:[NSString class]]) {
        return self.items.count;
    } else if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        NSArray *values = self.items[section];
        return values.count;
    } else {
        NSArray *values = [self.items[section] objectForKey:@"SortValue"];
        return values.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, [self itemAtIndexPath:indexPath]);
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.items.firstObject isKindOfClass:[NSString class]]) {
        return nil;
    } else if ([self.items.firstObject isKindOfClass:[NSArray class]]) {
        return [NSString stringWithFormat:@"%@", @(section)];
    } else {
        NSString *key = [self.items[section] objectForKey:@"SortKey"];
        return key;
    }
}

@end
