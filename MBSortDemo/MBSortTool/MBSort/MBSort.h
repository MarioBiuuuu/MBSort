//
//  MBSort.h
//  MBSortTool
//
//  Created by ZhangXiaofei on 17/2/13.
//  Copyright © 2017年 Yuri. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, MBSortType) {
    /** 默认排序结果不带对应的首字母 */
    MBSortTypeNormal = 0,
    /** 排序结果不带对应的首字母 [original...]*/
    MBSortTypeOriginalValue,
    /** 排序结果带对应的首字母 [{key : original...}...] */
    MBSortTypeKeyValue
};

@interface MBSort : NSObject

/** 返回结果中, 字典key属性, 描述排序所使用的对应数据的首字母 */
extern NSString *const MBSortKey;
/** 返回结果中, 字典value属性, 描述排序所使用的对应数据 */
extern NSString *const MBSortValue;

/**
 * 对字符串数据排序, 通过首字母进行排序
 *
 * @param originalStrings   原始数据
 * @param sortType          排序结果类型
 * @return                  排序结果
 */
+ (NSArray *)MB_sortOriginalStrings:(NSArray<NSString *> *)originalStrings sortType:(MBSortType)sortType;

/**
 * 对模型数组进行排序, 通过输入的key进行首字母排序
 *
 * @param originalObjects   原始数据
 * @param key               排序依据(模型对象的属性)
 * @param sortType          排序结果类型
 * @return                  排序结果
 */
+ (NSArray *)MB_sortOriginalObjects:(NSArray *)originalObjects keyProperty:(NSString *)key sortType:(MBSortType)sortType;

@end
