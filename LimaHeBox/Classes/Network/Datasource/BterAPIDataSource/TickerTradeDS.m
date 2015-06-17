//
//  TickerTradeDS.m
//  BterAPI
//
//  Created by jianting on 14/10/13.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "TickerTradeDS.h"

@implementation TickerTradeDS

- (void)tickerTrade:(NSString *)ticker
{

    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[NSString stringWithFormat:@"http://data.bter.com/api/1/trade/%@",ticker]]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    //body & header
    [self startRequest];
}

@end
