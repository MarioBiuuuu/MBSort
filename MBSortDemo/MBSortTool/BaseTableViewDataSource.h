//
//  BaseTableViewDataSource.h
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseTableViewDataSource;

typedef void(^BaseTableViewCellConfigureBlock)(id cell, id item);

@interface BaseTableViewDataSource : NSObject <UITableViewDataSource>

- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithItems:(NSArray *)items cellReuserID:(NSString *)reuseID configureCellBlock:(BaseTableViewCellConfigureBlock)configureCellBlock;

+ (instancetype)dataSourceWithItems:(NSArray *)items cellReuserID:(NSString *)reuseID configureCellBlock:(BaseTableViewCellConfigureBlock)configureCellBlock;

@end
