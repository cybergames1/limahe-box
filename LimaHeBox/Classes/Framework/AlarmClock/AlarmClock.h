//
//  AlarmClock.h
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmClock : NSObject

@property (nonatomic) BOOL shake;

/* 设置闹钟时间 h:m */
- (void)setHour:(NSInteger)hour min:(NSInteger)min;
/* 获取字符串形式的时间,格式为h:m */
- (NSString *)timeString;

/* 设置重复日期
 * 星期一 -> 1
 * ...
 * 星期日 -> 7
 */
- (void)setDaysList:(NSArray *)daysList;
/* 获取字符串形式的重复日期 */
- (NSString *)daysString;

@end
