//
//  AlarmClockManager.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AlarmClockManager.h"

@implementation AlarmClockManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static AlarmClockManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[AlarmClockManager alloc] init];
    });
    return manager;
}

@end
