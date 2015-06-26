//
//  AlarmClock.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AlarmClock.h"
#import "CommonTools.h"

@interface AlarmClock ()
{
    NSInteger _h;
    NSInteger _m;
    
    NSArray * _daysList;
}

@end

@implementation AlarmClock

- (void)dealloc {
    [_daysList release];_daysList = nil;
    [super dealloc];
}

- (void)setHour:(NSInteger)hour min:(NSInteger)min {
    _h = hour;
    _m = min;
}

- (NSString *)timeString {
    NSString *h = [CommonTools formatNumber:_h];
    NSString *m = [CommonTools formatNumber:_m];
    return [NSString stringWithFormat:@"%@:%@",h,m];
}

- (void)setDaysList:(NSArray *)daysList {
    [_daysList release];
    _daysList = nil;
    _daysList = [[NSArray alloc] initWithArray:daysList];
    [_daysList sortedArrayUsingSelector:@selector(compare:)];
}

- (NSString *)daysString {
    if ([self daysFrom:1 to:7]) {
        return @"每天";
    }
    
    if ([self daysFrom:1 to:5]) {
        return @"工作日";
    }
    
    if ([self daysFrom:6 to:7]) {
        return @"周末";
    }
    
    NSMutableString *days = [[NSMutableString alloc] initWithCapacity:7];
    for (id day in _daysList) {
        switch ([day integerValue]) {
            case 1:
                [days appendString:@"星期一 "];
                break;
            case 2:
                [days appendString:@"星期二 "];
                break;
            case 3:
                [days appendString:@"星期三 "];
                break;
            case 4:
                [days appendString:@"星期四 "];
                break;
            case 5:
                [days appendString:@"星期五 "];
                break;
            case 6:
                [days appendString:@"星期六 "];
                break;
            case 7:
                [days appendString:@"星期日 "];
                break;
            default:
                break;
        }
    }
    
    return [days autorelease];
}

- (BOOL)daysFrom:(NSInteger)fromDay to:(NSInteger)toDay {
    if ([_daysList count] != toDay+1-fromDay) return NO;
    
    BOOL areaIsOK = YES;
    for (id day in _daysList) {
        NSInteger d = [day integerValue];
        if (d < fromDay || d > toDay) {
            areaIsOK = NO;
            break;
        }
    }
    return areaIsOK;
}

@end
