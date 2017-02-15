//
//  Student.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/13.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (instancetype)studentWithName:(NSString *)name score:(NSUInteger)score {
    return [[self alloc] initWithName:name score:score];
}

- (instancetype)initWithName:(NSString *)name score:(NSUInteger)score {
    if (self = [super init]) {
        self.name = name;
        self.score = score;
        return self;
    }
    return self;
}

- (void)loadData {
    
}

@end
