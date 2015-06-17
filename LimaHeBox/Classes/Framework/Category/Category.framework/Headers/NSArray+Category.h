//
//  NSArray+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark NSArray (EmptyArray)
@interface NSArray (EmptyArray)
/**
 @brief 判断是否为空的数组
 @details 返回YES，如果arrayObject为非NSArray类型的实例或者nil
 */
+ (BOOL) isEmptyArray:(id) arrayObject;

@end

@interface NSArray (NSArraySafeGetObject)
/**
 @brief 安全获取 array 中得元素
 @details 返回 index 位置的 object，如果index 非法返回nil
 */
- (id) safeObjectAtIndex:(NSInteger) index;

@end

#pragma mark NSArray (ArrayAdditions)
@interface NSArray (ArrayAdditions)
/**
 获取指定object之前的object
 @param object 指定位置的object，如果传nil，获取最后一个.
 */
- (id)objectBefore:(id)object;

/**
 获取指定object之后的object
 @param object 指定位置的object，如果传nil，获取第一个.
 */
- (id)objectAfter:(id)object;

@end


@interface NSMutableArray (NSMutableArrayAdditions)
/**
 删除数组的第一个元素，如果数组为空数组，什么也不做
 */
- (void)removeFirstObject;

/**
 翻转数组，例如原数组：@[ @1, @2, @3 ]，翻转后为：@[ @3, @2, @1 ]
 */
- (void)reverseArray;

@end

@interface NSArray (NSArrayDeleteDuplicateObject)
/**
 删除重复的内容
 */
- (NSArray*) arrayByDeleteDuplicateObjects;

@end



