//
//  CalendarViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarView.h"

@interface CalendarViewController () <CalendarDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"日历"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    CalendarView *calendar = [[CalendarView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.width)];
    calendar.delegate    = self;
    calendar.calendarDate                = [NSDate date];
    calendar.monthAndDayTextColor        = [UIColor whiteColor];
    calendar.dayBgColorWithData          = [UIColor clearColor];
    calendar.dayBgColorWithoutData       = [UIColor clearColor];
    calendar.dayBgColorSelected          = [UIColor clearColor];
    calendar.dayTxtColorWithoutData      = [UIColor whiteColor];
    calendar.dayTxtColorWithData         = [UIColor whiteColor];
    calendar.dayTxtColorSelected         = [UIColor whiteColor];
    calendar.borderColor                 = [UIColor clearColor];
    calendar.borderWidth                 = 1;
    calendar.allowsChangeMonthByDayTap   = YES;
    calendar.allowsChangeMonthByButtons  = YES;
    calendar.keepSelDayWhenMonthChange   = YES;
//    calendar.nextMonthAnimation          = UIViewAnimationOptionTransitionFlipFromRight;
//    calendar.prevMonthAnimation          = UIViewAnimationOptionTransitionFlipFromLeft;
    calendar.center = CGPointMake(self.view.center.x, calendar.center.y);
    [self.view addSubview:calendar];
}

#pragma mark - CalendarDelegate protocol conformance

-(void)dayChangedToDate:(NSDate *)selectedDate
{
    NSLog(@"dayChangedToDate %@(GMT)",selectedDate);
}

@end
