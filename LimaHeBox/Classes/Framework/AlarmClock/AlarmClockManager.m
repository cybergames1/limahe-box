//
//  AlarmClockManager.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AlarmClockManager.h"
#import <UIKit/UIKit.h>

@implementation AlarmClockManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static AlarmClockManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[AlarmClockManager alloc] init];
    });
    return manager;
}

+ (NSDate *)updateDate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger h = [defaults integerForKey:kAlarmClock_Hour];
    NSInteger m = [defaults integerForKey:kAlarmClock_Minute];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy"];
    NSString *year = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"MM"];
    NSString *month = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"dd"];
    NSString *day = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    NSCalendar *chinese = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:[year integerValue]];
    [comps setMonth:[month integerValue]];
    [comps setDay:[day integerValue]];
    [comps setHour:h];
    [comps setMinute:m];
    
    date = [chinese dateFromComponents:comps];
    [comps release];
    [chinese release];
    
    return date;
}

+ (void)createLocalNotificationWithAlarmClock:(AlarmClock *)alarmClock {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification != nil) {
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.fireDate = [self updateDate];
        notification.soundName= UILocalNotificationDefaultSoundName;//声音
        notification.repeatInterval = NSCalendarUnitDay; //重复的方式。
        notification.alertTitle = @"闹钟";
        notification.alertBody = @"闹钟响了!";
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    [notification release];
}

+ (void)removeLocalNotification {
    NSArray *localArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    UILocalNotification *localNotification;
    
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:@"对应的key值"]) {
                    if (localNotification){
                        [localNotification release];
                        localNotification = nil;
                    }
                    localNotification = [noti retain];
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNotification) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
        }

        if (localNotification) {
            //不推送 取消推送
            [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
            [localNotification release];
            return;
        }
    }
}

@end
