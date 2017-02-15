# MBSort
Sort by first letter

`提供字符串通过首字母进行排序, 或者对模型对象的指定属性首字母排序`

1. **通过字符串首字母进行排序**  
	`+ (NSArray *)MB_sortOriginalStrings:(NSArray<NSString *> *)originalStrings sortType:(MBSortType)sortType;`  
	

2. **通过模型对象的指定属性进行排序**  
	`+ (NSArray *)MB_sortOriginalObjects:(NSArray *)originalObjects keyProperty:(NSString *)key sortType:(MBSortType)sortType;`  
	
其中, 使用到的枚举对象`MBSortType`, 包含三个选项: 
  
```
	1.默认排序结果不带对应的首字母
    	MBSortTypeNormal = 0,
    2.排序结果不带对应的首字母 [original...]
   	    MBSortTypeOriginalValue,
    3.排序结果带对应的首字母 [{key : original...}...]
    	MBSortTypeKeyValue  
```	

获取带首字母的返回值时, 通过key获取对应的值, `MBSortKey`描述排序所使用的对应数据的首字母, `MBSortValue`描述排序所使用的对应数据.
