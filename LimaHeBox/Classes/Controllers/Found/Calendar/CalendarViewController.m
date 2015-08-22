//
//  CalendarViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CalendarViewController.h"
#import "VRGCalendarView.h"

@interface CalendarViewController () <VRGCalendarViewDelegate>

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"日历"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate = self;
    [self.view addSubview:calendar];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}

@end
