//
//  WeatherSource.h
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

/**
 * 获取省列表
 */
@interface WeatherSource : PPQDataSource

- (void)getWeatherInfo:(NSString *)api;

@end
