//
//  TimePickerView.m
//  LimaHeBox
//
//  Created by jianting on 15/6/29.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TimePickerView.h"
#import <Category/Category.h>

#define Picker_Rate 216.0/320.0

@interface TimePickerView () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView * _bgView;
    
    UIToolbar * _toolbar;
    
    NSMutableArray * _hoursArray;
    NSMutableArray * _minArray;
    NSArray * _ampmArray;
    
    NSInteger _returnHour;
    NSInteger _returnMinute;
}

@end

@implementation TimePickerView

- (void)dealloc {
    [_hoursArray release];_hoursArray = nil;
    [_minArray release];_minArray = nil;
    [_ampmArray release];_ampmArray = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _hoursArray = [[NSMutableArray alloc] initWithCapacity:12];
        _minArray = [[NSMutableArray alloc] initWithCapacity:60];
        
        for (int i = 0; i < 12; i++) {
            [_hoursArray addObject:[NSString stringWithFormat:@"%02d",i]];
        }
        
        for (int i = 0; i < 60; i++) {
            [_minArray addObject:[NSString stringWithFormat:@"%02d",i]];
        }
        
        _ampmArray = [[NSArray alloc] initWithObjects:@"上午",@"下午", nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0;
        
        _pickerView = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        _toolbar = [[[UIToolbar alloc] initWithFrame:CGRectZero] autorelease];
        
        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelAction)] autorelease];
        UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(doneAction)] autorelease];
        UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
        [_toolbar setItems:@[cancelButton,flexibleSpace,doneButton] animated:YES];
        
        [self addSubview:_bgView];
        [self addSubview:_pickerView];
        [self addSubview:_toolbar];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    self.frame = view.bounds;
    [view addSubview:self];
    
    _bgView.frame = self.bounds;
    _toolbar.frame = CGRectMake(0, self.height, self.width, 44);
    _pickerView.frame = CGRectMake(0, _toolbar.bottom, self.width, self.width*Picker_Rate);
    [self setPickerView];
    [self showAniamtion];
}

- (void)setPickerView {
    [self setCurrentTime];
}

- (void)setCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"hh"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"mm"];
    NSString *currentMinuteString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    _returnMinute = [currentMinuteString integerValue];
    
    [formatter setDateFormat:@"a"];
    NSString *currentAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    _returnHour = ([_ampmArray indexOfObject:currentAMPMString] == 0) ? [currentHourString integerValue] : [currentHourString integerValue]+12;
    
    [formatter release];
    
    [_pickerView selectRow:[_ampmArray indexOfObject:currentAMPMString] inComponent:0 animated:YES];
    [_pickerView selectRow:[_hoursArray indexOfObject:currentHourString] inComponent:1 animated:YES];
    [_pickerView selectRow:[_minArray indexOfObject:currentMinuteString] inComponent:2 animated:YES];
}

- (void)setHour:(NSInteger)hour minute:(NSInteger)minute {
    if (hour < 0 || minute < 0) {
        [self setCurrentTime];
        return;
    }
    
    NSString *ampmString = (minute >= 12) ? @"下午" : @"上午";
    NSString *hourString = [NSString stringWithFormat:@"%02d",(int)hour%12];
    NSString *minuteString = [NSString stringWithFormat:@"%02d",(int)minute];
    _returnHour = hour;
    _returnMinute = minute;
    
    [_pickerView selectRow:[_ampmArray indexOfObject:ampmString] inComponent:0 animated:YES];
    [_pickerView selectRow:[_hoursArray indexOfObject:hourString] inComponent:1 animated:YES];
    [_pickerView selectRow:[_minArray indexOfObject:minuteString] inComponent:2 animated:YES];
}

- (void)showAniamtion {
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0.6;
        _toolbar.top -= _pickerView.height;
        _pickerView.top -= _pickerView.height;
    }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0.0;
        _toolbar.top += _pickerView.height;
        _pickerView.top += _pickerView.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark ButtonAction

- (void)cancelAction {
    [self hideAnimation];
}

- (void)doneAction {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:hour:minute:)]) {
        [_delegate pickerView:self hour:_returnHour minute:_returnMinute];
    }
    [self hideAnimation];
}

#pragma mark -
#pragma mark UIPickerView DataSource & Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_ampmArray count];
    }
    else if (component == 1) {
        return [_hoursArray count];
    }
    else {
        return [_minArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return _ampmArray[row];
    }
    else if (component == 1) {
        return _hoursArray[row];
    }
    else {
        return _minArray[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger base = 0;
    
    if (component == 0) {
        base = (row == 0) ? 0 : 12;
    }
    else if (component == 1) {
        _returnHour = [_hoursArray[row] integerValue] + base;
    }
    else {
        _returnMinute = [_minArray[row] integerValue];
    }
}

@end


@interface CityPickerView ()
{
    NSArray * _provinceList;
    NSArray * _cityList;
}

@end

@implementation CityPickerView

- (void)dealloc {
    [_provinceList release];_provinceList = nil;
    [_cityList release];_cityList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _provinceList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"]];
        _cityList = [[NSArray alloc] initWithArray:[_provinceList[0] objectForKey:@"cityList"]];
    }
    return self;
}

- (void)setPickerView {
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [_pickerView selectRow:0 inComponent:1 animated:YES];
}

#pragma mark -
#pragma mark UIPickerView DataSource & Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_provinceList count];
    }else {
        return [_cityList count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [_provinceList[row] objectForKey:@"provinceName"];
    }else {
        return [_cityList[row] objectForKey:@"cityName"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [_cityList release];
        _cityList = [[NSArray alloc] initWithArray:[_provinceList[row] objectForKey:@"cityList"]];
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

- (void)doneAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:cityId:)]) {
        [self.delegate pickerView:self cityId:[_cityList[[_pickerView selectedRowInComponent:1]] objectForKey:@"cityId"]];
    }
    [self hideAnimation];
}

@end
