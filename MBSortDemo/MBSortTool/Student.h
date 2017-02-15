//
//  Student.h
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/13.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSUInteger score;

- (void)loadData;

- (instancetype)initWithName:(NSString *)name score:(NSUInteger)score;
+ (instancetype)studentWithName:(NSString *)name score:(NSUInteger)score;

@end
