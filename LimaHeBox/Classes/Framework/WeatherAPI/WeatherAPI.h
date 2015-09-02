//
//  WeatherAPI.h
//  LimaHeBox
//
//  Created by jianting on 15/6/18.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherDefines.h"

typedef NS_ENUM(NSInteger, WeatherCode) {
    WeatherCodeSunny                 = 0, //晴
    WeatherCodeCloudy                = 1, //多云
    WeatherCodeOvercast              = 2, //阴
    WeatherCodeShower                = 3, //阵雨
    WeatherCodeThundershower         = 4, //雷阵雨
    WeatherCodeThundershowerWithHail = 5, //雷阵雨伴有冰雹
    WeatherCodeSleet                 = 6, //雨夹雪
    WeatherCodeLightRain             = 7, //小雨
    WeatherCodeModerateRain          = 8, //中雨
    WeatherCodeHeavyrain             = 9, //大雨
    WeatherCodeStorm                 = 10,//暴雨
    WeatherCodeHeavyStorm            = 11,//大暴雨
    WeatherCodeSevereStorm           = 12,//特大暴雨
    WeatherCodeSnowFlurry            = 13,//阵雪
    WeatherCodeLightSnow             = 14,//小雪
    WeatherCodeModerateSnow          = 15,//中雪
    WeatherCodeHeavySnow             = 16,//大雪
    WeatherCodeSnowStorm             = 17,//暴雪
    WeatherCodeFoggy                 = 18,//雾
    WeatherCodeIceRain               = 19,//冻雨
    WeatherCodeDusstorm              = 20,//沙尘暴
    WeatherCodeLightToModerateRain   = 21,//小到中雨
    WeatherCodeModerateToHeavyRain   = 22,//中到大雨
    WeatherCodeHeavyRainToStorm      = 23,//大到暴雨
    WeatherCodeStromToHeavyStrom     = 24,//暴雨到大暴雨
    WeatherCodeHeavyToSevereStorm    = 25,//大暴雨到特大暴雨
    WeatherCodeLightToModerateSnow   = 26,//小到中雪
    WeatherCodeModerateToHeavySnow   = 27,//中到大雪
    WeatherCodeHeavySnowToSnowstorm  = 28,//大到暴雪
    WeatherCodeDust                  = 29,//浮沉
    WeatherCodeSand                  = 30,//扬沙
    WeatherCodeSandstorm             = 31,//强沙风暴
    WeatherCodeHaze                  = 53,//霾
    WeatherCodeUnknown               = 99,//无
};

typedef NS_ENUM(NSInteger, WindDirectionCode) {
    WindDirectionCodeNoWind     = 0, //无持续风向
    WindDirectionCodeNortheast  = 1, //东北风
    WindDirectionCodeEastt      = 2, //东风
    WindDirectionCodeSoutheast  = 3, //东南风
    WindDirectionCodeSouth      = 4, //南风
    WindDirectionCodeSouthwest  = 5, //西南风
    WindDirectionCodeWest       = 6, //西风
    WindDirectionCodeNorthwest  = 7, //西北风
    WindDirectionCodeNorth      = 8, //北风
    WindDirectionCodeWhirlwind  = 9, //旋转风
};

/** 风力单位mile/h */
typedef NS_ENUM(NSInteger, WeatherForceLevel) {
    WeatherForceLevel10         = 0, //微风
    WeatherForceLevel10_17      = 1, //3-4级
    WeatherForceLevel17_25      = 2, //4-5级
    WeatherForceLevel25_34      = 3, //5-6级
    WeatherForceLevel34_43      = 4, //6-7级
    WeatherForceLevel43_54      = 5, //7-8级
    WeatherForceLevel54_65      = 6, //8-9级
    WeatherForceLevel65_77      = 7, //9-10级
    WeatherForceLevel77_89      = 8, //10-11级
    WeatherForceLevel89_102     = 9, //11-12级
};

@interface WeatherAPI : NSObject

@property (nonatomic, retain) NSMutableDictionary * weatherInfo;

- (void)getWeatherInfoAreaId:(NSString *)areaId completion:(void (^)(BOOL finished))completion;

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


