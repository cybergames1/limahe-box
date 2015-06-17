//
//  NSNumber+Category.h
//  Demo
//
//  Created by SEAN on 14-7-1.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark NSNumber (RandomNumber) 随机数
@interface NSNumber (RandomNumber)
/**
 产生指定位数的随机整数
 */
+ (NSNumber*) randomNumber:(NSInteger)length;

/**
 产生指定大小范围from~to的随机整数
 @param fromValue 随机数的下线（包括）
 @param toValue 随机数的上线（包括）
 */
+ (NSNumber*) randomNumberFrom:(NSInteger)fromValue to:(NSInteger) toValue;

/**
 产生随机浮点数，精度2位
 */
+ (NSNumber*) randomFloatNumber;

/**
 产生指定精度的随机浮点数
 @param precision 指定的浮点数的精确度
 */
+ (NSNumber*) randomFloatNumberWithPrecision:(NSInteger)precision;

@end
