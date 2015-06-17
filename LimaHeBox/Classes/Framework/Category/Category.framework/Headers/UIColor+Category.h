//
//  UIColor+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark UIColor (HexColor) 16进制颜色
@interface UIColor (HexColor)

/**
 @details 初始化16进制结构的Color
 @param hex 16进制的颜色值
 @param alpha 颜色alpha值，介于[0.0~1.0]之间
 @return 返回UIColor
 */
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;
/**
 @details 初始化16进制字符串类型的Color
 @param hexString 字符串格式的16进制的颜色值
 @return 返回UIColor
 */
+ (UIColor *)colorWithHexString:(id)hexString;

/**
 获取16进制颜色值
 */
- (UInt32)hexValue;

@end

@interface UIColor (UIColorRandom)
/**
 随机颜色，alpha=1.0
 */
+ (UIColor*) randomColor;

/**
 随机颜色
 @param alpha 透明度，取值范围0.0~1.0
 */
+ (UIColor*) randomColorWithAlpha:(CGFloat) alpha;

@end

@interface UIColor (UIColorComponents)

/** 颜色的red值,取值范围0.0~1.0 */
@property (nonatomic, readonly) CGFloat red;

/** 颜色的green值,取值范围0.0~1.0  */
@property (nonatomic, readonly) CGFloat green;

/** 颜色的blue值,取值范围0.0~1.0  */
@property (nonatomic, readonly) CGFloat blue;

/** 颜色的alpha值,取值范围0.0~1.0  */
@property (nonatomic, readonly) CGFloat alpha;

@end

