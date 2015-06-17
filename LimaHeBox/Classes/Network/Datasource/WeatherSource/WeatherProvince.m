//
//  WeatherProvince.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeatherProvince.h"

@implementation WeatherProvince

- (void)getProvinceList
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:@"http://www.weather.com.cn/adat/cityinfo/101010100.html"]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    //body & header
    [self startRequest];
}

@end
