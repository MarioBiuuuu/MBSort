//
//  UITableViewCell+ConfigureUI.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/15.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "UITableViewCell+ConfigureUI.h"
#import "Student.h"

@implementation UITableViewCell (ConfigureUI)
- (void)configureForString:(NSString *)str {
    [self configureBaseAttribute];
    self.textLabel.text = str;
}

- (void)configureForObj:(Student *)std {
    [self configureBaseAttribute];
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ ---> 成绩: %@", std.name, @(std.score)];
    self.detailTextLabel.text = [NSString stringWithFormat:@"成绩: %@", @(std.score)];
}

- (void)configureBaseAttribute {
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:15.f];
    
    self.detailTextLabel.textColor = [UIColor lightGrayColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
