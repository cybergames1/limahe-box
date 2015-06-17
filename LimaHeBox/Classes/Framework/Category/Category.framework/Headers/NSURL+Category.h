//
//  NSURL+Category.h
//  Demo
//
//  Created by Sean on 14-10-11.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (NSURLWithFormat)
/**
 @brief 按照特定的格式初始化并且返回一个 URL
 
 @param format 格式化字符串，不能为 nil.
 @note  如果 format 为 nil，会抛出 NSInvalidArgumentException 异常
 */
+ (NSURL*) URLWithFormat:(NSString *)format, ... ;

/**
 @brief 初始化并返回一个文件 URL
 
 @param format 格式化字符串，不能为 nil.
 @note 如果 format 为 nil，会抛出 NSInvalidArgumentException 异常
 */
+ (NSURL*) fileURLWithPathFormat:(NSString *)format, ...;

@end

@interface NSURL (NSURLUTF8Encode)
/**
 获取utf8处理后的url
 */
+ (NSURL*) UTF8EncodingURLWithFormat:(NSString *)format, ... ;

@end







