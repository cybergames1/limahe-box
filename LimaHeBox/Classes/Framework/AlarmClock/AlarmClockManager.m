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

+ (void)createLocalNotificationWithAlarmClock:(AlarmClock *)alarmClock {
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification != nil) {
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];//10秒后通知
        notification.repeatInterval = 0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber = 1; //应用的红色数字
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"name",@"key", nil];
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
