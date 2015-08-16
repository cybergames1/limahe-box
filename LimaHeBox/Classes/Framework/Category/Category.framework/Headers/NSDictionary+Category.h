//
//  NSDictionary+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark NSDictionary (DictionaryEmpty)
@interface NSDictionary (DictionaryEmpty)
/** 
 @brief 判断给定的字典是否为空字典
 @details 返回YES，如果dictionaryObject为非字典类型的实例或者为nil。
 **/
+ (BOOL) isEmptyDictionary:(id) dictionaryObject;

@end

#pragma mark NSDictionary (DictionaryMerge)
@interface NSDictionary (DictionaryMerge)
/** 合并两个Dictionary **/
+ (NSDictionary *) dictionary: (NSDictionary *) dict1
                    mergeWith: (NSDictionary *) dict2;
- (NSDictionary *) dictionaryByMergingWith: (NSDictionary *) dict;

@end


#pragma mark NSDictionary (KeyValue)
@interface NSDictionary (DictionaryKeyValue)
/*!
 *  @brief 判断是否包含指定的key
 *  @param aKey 指定的key
 *  @return 包含返回YES，否则NO.
 */
- (BOOL)containsKey:(id)aKey;

/*!
 *  @brief 判断是否包含指定的value
 *  @param value 指定的value
 *  @return 包含返回YES，否则NO.
 */
- (BOOL)containsValue:(id)value;

@end

#pragma mark NSDictionary (KeyValue)
@interface NSDictionary (DictionaryFormat)
/**
 根据指定的key解析dictionary。如果字典没有该key，返回nil
 
 @return 返回该key值对应的value，nil如果没有获取到
 @note 使用该方法可以避免字典返回值类型不定造成客户端解析崩溃或者需要重新转换格式的问题
 */
- (NSString*) stringValueForKey:(NSString*)key;

/**
 根据指定的key解析dictionary。如果字典没有该key，返回nil
 
 @return 返回该key值对应的value，nil如果没有获取到
 @note 使用该方法可以避免字典返回值类型不定造成客户端解析崩溃或者需要重新转换格式的问题
 */
- (NSNumber*) numberValueForKey:(NSString*)key;

@end






