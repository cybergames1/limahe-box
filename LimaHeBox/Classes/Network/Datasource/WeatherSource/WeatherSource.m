//
//  WeatherSource.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeatherSource.h"
#import "WeatherAPI.h"

@implementation WeatherSource

- (void)getWeatherInfo:(NSString *)api
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:api]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    //body & header
    [self startRequest];
}

@end
