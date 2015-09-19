//
//  TimePickerView.h
//  LimaHeBox
//
//  Created by jianting on 15/6/29.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityPickerView;
@protocol CityPickerViewDelegate <NSObject>

@optional
- (void)pickerView:(CityPickerView *)pickerView cityId:(NSString *)cityId;

@end


@class TimePickerView;
@protocol TimePickerViewDelegate <CityPickerViewDelegate>

@optional
- (void)pickerView:(TimePickerView *)pickerView hour:(NSInteger)hour minute:(NSInteger)minute;

@end

@interface TimePickerView : UIView
{
    UIPickerView * _pickerView;
}

@property (nonatomic, assign) id<TimePickerViewDelegate> delegate;

- (void)showInView:(UIView *)view;

/* 修改时间时，先导入之前的时间 */
- (void)setHour:(NSInteger)hour minute:(NSInteger)minute;

@end


@interface CityPickerView : TimePickerView

@end