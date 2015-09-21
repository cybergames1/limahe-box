//
//  PFPickerSheet.m
//  PaPaQi
//
//  Created by jianting on 13-12-4.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PFPickerSheet.h"
#import "CommonTools.h"
@interface PFPickerSheet () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIDatePicker * _datePicker;
    UIPickerView * _pickerView;
}
- (void) setOption:(PFPickerOption) option;
@end

static PFPickerSheet* defaultPickerSheet = nil;
static PFPickerBlock defaultPickerBlock = nil;
static PFPickerOption defaultPickerOption = PFPickerOptionGender;
static id pickerValue = nil;  //返回数据

static NSArray* genderList = nil;
static NSDictionary* provinceList = nil;
static NSDictionary* cityList = nil;
static NSDictionary* cityListForProvince = nil;

NSString *const cityKey = @"cityKey";
NSString *const provinceKey = @"provinceKey";

@implementation PFPickerSheet
+ (void)load
{
    genderList = [[NSArray alloc] initWithObjects:@"先生",@"女士", nil];
}
- (void)dealloc
{
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3];
        
        UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
        toolBar.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:toolBar];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-60, 0, 50, 44)];
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor colorWithRed:(41.0/255.0) green:(41.0/255.0) blue:(41.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [toolBar addSubview:rightButton];
        [rightButton release];
        [toolBar release];
    }
    return self;
}

#pragma mark - show
+ (void) showPickerSheet:(PFPickerOption) option
             previewData:(id) data
             finishBlock:(PFPickerBlock) block
{
    if (nil == defaultPickerSheet) {
        defaultPickerSheet = [[PFPickerSheet alloc] init];
    }
    [pickerValue release];
    pickerValue = [data retain];
    [defaultPickerSheet setOption:option];
    if (block) {
        [defaultPickerBlock release];
        defaultPickerBlock = [block copy];
    }
    [defaultPickerSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

#pragma mark - SET
- (void) setOption:(PFPickerOption) option
{
    defaultPickerOption = option;
    if (PFPickerOptionGender == defaultPickerOption) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, 216)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_pickerView];
        if (pickerValue && [pickerValue isKindOfClass:[NSString class]]) {
            if ([@"先生" isEqualToString:pickerValue]) {
                [_pickerView selectRow:0 inComponent:0 animated:NO];
            }
            else{
                [_pickerView selectRow:1 inComponent:0 animated:NO];
            }
        }
        [_pickerView release];
    }
    else if (PFPickerOptionBirthday == defaultPickerOption){
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, 216)];
        [_datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
        [_datePicker setMaximumDate:[NSDate date]];
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_datePicker];
        [_datePicker release];
        
        if (pickerValue && [pickerValue isKindOfClass:[NSDate class]]) {
            [_datePicker setDate:(NSDate*)pickerValue animated:YES];
        }else {
//            NSDate *date = [CommonTools formateStringValue:@"1990-01-01" withStyle:@"YYYY-MM-dd"];
//            [_datePicker setDate:date animated:YES];
        }
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        if (nil == provinceList || nil == cityList) {
            NSDictionary* provinceCityList = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinceCity" ofType:@"plist"]];
            provinceList = [[NSDictionary alloc] initWithDictionary:[provinceCityList valueForKey:@"province"]];
            cityList = [[NSDictionary alloc] initWithDictionary:[provinceCityList valueForKey:@"city"]];
            [provinceCityList release];
        }
        NSDictionary *dic = (NSDictionary *)pickerValue;
        //假设进来先选中第一个市，则先获取该市所对应的所有区
        NSArray* allKeys = [provinceList allKeys];
        NSString *key = [dic objectForKey:@"provinceCode"] ? [dic objectForKey:@"provinceCode"] : allKeys[0];
        [cityListForProvince release];
        cityListForProvince = [[NSDictionary alloc] initWithDictionary:[cityList valueForKey:key]];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, 216)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_pickerView];
        [_pickerView release];
        
        NSInteger provinceRow = [dic objectForKey:@"provinceCode"] ? [allKeys indexOfObject:[dic objectForKey:@"provinceCode"]] : 0;
        NSInteger cityRow = [dic objectForKey:@"cityCode"] ? [[cityListForProvince allKeys] indexOfObject:[dic objectForKey:@"cityCode"]] : 0;
        //默认展示第一个市的第一个区
        [_pickerView selectRow:provinceRow inComponent:0 animated:YES];
        [_pickerView selectRow:cityRow inComponent:1 animated:YES];
    }
}

#pragma mark - UIPickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (PFPickerOptionGender == defaultPickerOption){
        return 1;
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (PFPickerOptionGender == defaultPickerOption){
        return [genderList count];
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        if (0 == component) {
            return [[provinceList allKeys] count];
        }
        else if (1 == component){
            return [[cityListForProvince allKeys] count];
        }
    }
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (PFPickerOptionGender == defaultPickerOption){
        return [genderList objectAtIndex:row];
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        if (0 == component) {
            NSArray* allKeys = [provinceList allKeys];
            return [provinceList valueForKey:allKeys[row]];
        }
        else if (1 == component){
            NSArray *cityKeys = [cityListForProvince allKeys];
            return [cityListForProvince valueForKey:cityKeys[row]];
        }
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (PFPickerOptionGender == defaultPickerOption){
        [pickerValue release];
        pickerValue = [[genderList objectAtIndex:row] retain];
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        if (0 == component) {
            NSArray* allKeys = [provinceList allKeys];
            [cityListForProvince release];
            cityListForProvince = [[NSDictionary alloc] initWithDictionary:[cityList valueForKey:allKeys[row]]];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
        }
    }
}

#pragma mark Button Action
- (void)done
{
    if (PFPickerOptionBirthday == defaultPickerOption) {
        [pickerValue release];
        pickerValue = [[_datePicker date] retain];
    }
    else if (PFPickerOptionAddress == defaultPickerOption){
        [pickerValue release];
        NSMutableDictionary* mtDic = [NSMutableDictionary dictionaryWithCapacity:1];
        NSArray* allKeys = [provinceList allKeys];
        NSString* provinceCode = [allKeys objectAtIndex:[_pickerView selectedRowInComponent:0]];
        [mtDic setValue:provinceCode forKey:@"provinceCode"];
        [mtDic setValue:[provinceList valueForKey:provinceCode] forKey:@"province"];
        
        allKeys = [cityListForProvince allKeys];
        NSString* cityCode = [allKeys objectAtIndex:[_pickerView selectedRowInComponent:1]];
        [mtDic setValue:cityCode forKey:@"cityCode"];
        [mtDic setValue:[cityListForProvince valueForKey:cityCode] forKey:@"city"];
        pickerValue = [NSString stringWithFormat:@"%@ %@",[provinceList objectForKey:provinceCode],[cityListForProvince valueForKey:cityCode]];
    }
    
    if (defaultPickerBlock) {
        defaultPickerBlock(defaultPickerOption,pickerValue);
        [defaultPickerBlock release],defaultPickerBlock = nil;
        [pickerValue release],pickerValue = nil;
    }
    
    [self dismissWithClickedButtonIndex:0 animated:YES finishBlock:^{
        [defaultPickerSheet removeFromSuperview];
        [defaultPickerSheet release];
        defaultPickerSheet = nil;
    }];    
}

@end
