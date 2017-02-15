//
//  UITableViewCell+ConfigureUI.h
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Student;

@interface UITableViewCell (ConfigureUI)

- (void)configureForString:(NSString *)str;

- (void)configureForObj:(Student *)std;

@end

