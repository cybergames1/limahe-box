//
//  ExchangeListDS.m
//  BterAPI
//
//  Created by jianting on 14/10/10.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "ExchangeListDS.h"

@implementation ExchangeListDS

- (void)getExchangeList
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:@"http://data.bter.com/api/1/pairs"]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    //body & header
    [self startRequest];
}

@end
