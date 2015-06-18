//
//  WeatherProvince.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeatherProvince.h"
#import "WeatherAPI.h"

@implementation WeatherProvince

- (void)getProvinceList
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    WeatherAPI *api = [[WeatherAPI alloc] init];
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[api apiURLString]]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    [api release];
    
    //body & header
    [self startRequest];
}

@end
