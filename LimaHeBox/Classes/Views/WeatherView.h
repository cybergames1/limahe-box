//
//  WeatherView.h
//  LimaHeBox
//
//  Created by jianting on 15/6/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherAPI.h"

@interface WeatherView : UIView

//天气情况
@property (nonatomic, assign) WeatherCode weatherCode;

//温度情况
@property (nonatomic, assign) NSInteger minTemperature;
@property (nonatomic, assign) NSInteger maxTemperature;

@end
