//
//  MBSort.m
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/13.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import "MBSort.h"
#import "ChineseToPinyin.h"
#import <objc/runtime.h>


@interface NSObject (MBSortKeyProperty)

/**
 *  排序使用的key, 对模型对象进行不破坏扩展
 */
@property (nonatomic, copy) NSString *MB_key;

@end

@implementation NSObject (MBSortKeyProperty)

- (void)setMB_key:(NSString *)MB_key {
    
    objc_setAssociatedObject(self, @selector(MB_key), MB_key, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)MB_key {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end

/** 返回结果中, 字典key属性, 描述排序所使用的对应数据的首字母 */
NSString *const MBSortKey = @"SortKey";

/** 返回结果中, 字典value属性, 描述排序所使用的对应数据 */
NSString *const MBSortValue = @"SortValue";

@implementation MBSort

#pragma mark - 对字符串数组进行排序
+ (NSArray *)MB_sortOriginalStrings:(NSArray<NSString *> *)originalStrings sortType:(MBSortType)sortType {
    
    NSDictionary *sortedDict = [self MB_sortByFirstLetterWithOriginalData:originalStrings keyProperty:nil];

    return [self packageDataWithSourceDataDict:sortedDict sortType:sortType];

}

#pragma mark - 对模型数组进行排序
+ (NSArray *)MB_sortOriginalObjects:(NSArray *)originalObjects keyProperty:(NSString *)key sortType:(MBSortType)sortType {
    
    NSDictionary *sortedDict = [self MB_sortByFirstLetterWithOriginalData:originalObjects keyProperty:key];
    
    return [self packageDataWithSourceDataDict:sortedDict sortType:sortType];
}

#pragma mark - Common Function
/** 核心排序 */
+ (NSDictionary *)MB_sortByFirstLetterWithOriginalData:(NSArray *)originalDatas keyProperty:(NSString *)keyProperty {
    NSMutableDictionary *resultDictM = [NSMutableDictionary dictionary];
    NSMutableDictionary *sourceDictM = [NSMutableDictionary dictionary];
    NSMutableArray *resultValuesArrM = [NSMutableArray array];
    
    for (NSString *obj in originalDatas) {
        NSString *firstLetter;
        
        if ([self validateDataObject:obj key:keyProperty]) {
            obj.MB_key = [obj valueForKey:keyProperty];

            firstLetter = [NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:obj.MB_key]];
            
        } else {
            firstLetter = [NSString stringWithFormat:@"%c", [ChineseToPinyin sortSectionTitle:obj]];
        }
        
        if (![sourceDictM.allKeys containsObject:firstLetter]) {
            sourceDictM[firstLetter] = [NSMutableArray array];
        }
        NSMutableArray *arrM = sourceDictM[firstLetter];
        [arrM addObject:obj];
    
    }
    
    NSArray *sortedKeysArray = [[sourceDictM allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    resultDictM[@"sortedKeys"] = sortedKeysArray;
    
    for (NSString *key in sortedKeysArray) {
        
        NSArray *array = [((NSArray*)[sourceDictM objectForKey:key]) sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if ([self validateDataObject:originalDatas.firstObject key:keyProperty]) {
                return [[obj2 MB_key] localizedCompare:[obj1 MB_key]];
            }
            return [obj2 localizedCompare:obj1];
        }];
        
        [resultValuesArrM addObject:array];
    }
    resultDictM[@"sortedValues"] = resultValuesArrM;


    return resultDictM;
    
}

/** 验证对象是否是数据模型, 是否包含指定的属性 */
+ (BOOL)validateDataObject:(NSObject *)obj key:(NSString *)key {
    return key && key.length > 0;
}

/** 根据sortType拼装返回数据 */
+ (NSArray *)packageDataWithSourceDataDict:(NSDictionary *)sourceDict sortType:(MBSortType)sortType {
    if (sortType == MBSortTypeKeyValue) {
        NSMutableArray *resultArrM = [NSMutableArray array];
        
        for (int i = 0; i < [sourceDict[@"sortedKeys"] count]; i ++) {
            NSString *key = sourceDict[@"sortedKeys"][i];
            NSString *value = sourceDict[@"sortedValues"][i];
            NSDictionary *dict = @{MBSortKey : key, MBSortValue : value};
            [resultArrM addObject:dict];
        }
        
        return resultArrM;
    } else {
        return sourceDict[@"sortedValues"];
    }
}
@end
