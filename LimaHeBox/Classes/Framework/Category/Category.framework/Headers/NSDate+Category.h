//
//  NSDate+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark NSDate (Utilities) 日期快速生成与判断
@interface NSDate (NSDateUtilities)
/**
 获取距当前时刻secends秒的新Date
 @param secends 需要间隔的时差，当secends为正数时，为当前之后的某个时间，
                当secends为负值时，为之前的某个时间
 @return 返回新的NSDate
 */
+ (NSDate *) dateWithSecendsFromNow:(NSInteger) secends;
/**
 获取距某个特定时刻secends秒的新Date
 @param secends 需要间隔的时差，当secends为正数时，为该时刻之后的某个时间，
                当secends为负值时，为之前的某个时间
 @param date 指定的某个时间，不能为nil
 @return 返回新的NSDate
 */
+ (NSDate *) dateWithSecends: (NSInteger) secends
                    fromDate: (NSDate*) date;

@end

#pragma mark 时间属性
@interface NSDate (NSDateProperty)

@property (nonatomic, readonly) NSInteger year;   //年份
@property (nonatomic, readonly) NSInteger month;  //月份
@property (nonatomic, readonly) NSInteger day;    //日期
@property (nonatomic, readonly) NSInteger hour;   //小时
@property (nonatomic, readonly) NSInteger minute; //分钟
@property (nonatomic, readonly) NSInteger second; //秒
@property (nonatomic, readonly) NSInteger weekday;//星期几
@property (nonatomic, readonly) NSInteger weekdayOrdinal; //这个月的第几周
@property (nonatomic, readonly) NSInteger weekOfMonth;    //这个月的第几周
@property (nonatomic, readonly) NSInteger weekOfYear;     //今年的第几周
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;//
@property (nonatomic, readonly) NSInteger quarter;  //季度

/** 判断是否为今天 */
- (BOOL) isToday;
/** 判断是否为本周 */
- (BOOL) isThisWeek;
/** 判断是否为本月 */
- (BOOL) isThisMonth;
/** 判断是否为本年 */
- (BOOL) isThisYear;

@end

#pragma mark NSDate (FormatDate) 时间格式化
@interface NSDate (NSDateFormatDate)
/**
 format时间
 @param date 时间，不能为nil
 @param style 时间格式，如果为nil，默认显示20140912_184001格式的时间
 
 @details 年：【yy】 以带前导零的两位数字格式显示年份。 
             【yyyy】 以四位数字格式显示年份。
 @details 月：【MM】 将月份显示为带前导零的数字（例如 01、12）。 
             【MMMM】 将月份显示为完整月份名（例如 十一月）
 @details 日：【dd】 将日显示为带前导零的数字（例如 01）。 
             【dddd】 将日显示为全名（例如 星期四）。
 @details 时：【hh】 使用 12 小时制将小时显示为带前导零的数字（例如 01:15:15 PM）。 
             【HH】 使用 24 小时制将小时显示为带前导零的数字（例如 01:15:15）。
 @details 分：【m】 将分钟显示为不带前导零的数字（例如 12:1:15）。 
             【mm】 将分钟显示为带前导零的数字（例如 12:01:15）。
 @details 秒：【s】 将秒显示为不带前导零的数字（例如 12:15:5）。 
             【ss】 将秒显示为带前导零的数字（例如 12:15:05）。
 */
+ (NSString*) formateDate:(NSDate*)date withStyle:(NSString*)style;

/** 
 返回NSDate的number格式
 @note 该值是NSDate距timeIntervalSince1970的时间间隔的NSNumber格式
 **/
- (NSNumber*) numberValue;

/**
 按照指定的格式化规定获取时间
 @param dateString 时间字符串
 @param style 格式化style，不能为nil
 */
+ (NSDate*) dateWithFormatedString:(NSString*) dateString formatStyle:(NSString*)style;

@end

#pragma mark NSDate (NSDateRandomDate) 随机时间
@interface NSDate (NSDateRandomDate)

/** 返回距当前时间5年以内间隔的时间 */
+ (NSDate*) randomDate;


/** 返回当前时间之前5年以内的任意时间 */
+ (NSDate*) randomDateBefore;

@end


@interface NSDate (NSDateCompare)
/**
 判断2个时间是否为同一自然天（2014-01-01 00：10 和 2014-01-01 23：55 是同一自然天）
 */
- (BOOL) isSameDayWithDate:(NSDate*) otherData;

/**
 判断2个时间是否为同一自然周（2014-11-02 01：15 和 2014-11-08 23：55 是同一自然周）
 */
- (BOOL) isSameWeekWithDate:(NSDate*) otherData;

/**
 判断2个时间是否为同一自然月（2014-07-01 00：15 和 2014-07-31 23：55 是同一自然月）
 */
- (BOOL) isSameMonthWithDate:(NSDate*) otherData;

/**
 判断2个时间是否为同一自然年（2014-01-01 01：15 和 2014-12-31 23：55 是同一自然年）
 */
- (BOOL) isSameYearWithDate:(NSDate*) otherData;

@end





