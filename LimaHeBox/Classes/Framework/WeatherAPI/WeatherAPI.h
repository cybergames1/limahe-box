//
//  WeatherAPI.h
//  LimaHeBox
//
//  Created by jianting on 15/6/18.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherDefines.h"

@interface WeatherAPI : NSObject

@property (nonatomic, retain) NSMutableDictionary * weatherInfo;

- (void)getWeatherInfo:(void (^)(BOOL finished))completion;

@end

// ----------------------------------------
// data keys

WH_EXTERN NSString *const WeahterPropertyDayWeather; //白天天气
WH_EXTERN NSString *const WeatherPropertyNightWeather; //晚上天气
WH_EXTERN NSString *const WeatherPropertyDayTemperature; //白天温度
WH_EXTERN NSString *const WeatherPropertyNightTemperature; //晚上温度
WH_EXTERN NSString *const WeatherPropertyDayWindDirection; //白天风向
WH_EXTERN NSString *const WeatherPropertyNightWindDirection; //晚上风向
WH_EXTERN NSString *const WeatherPropertyDayWindForce; //白天风力
WH_EXTERN NSString *const WeatherPropertyNightWindForce; //晚上风力