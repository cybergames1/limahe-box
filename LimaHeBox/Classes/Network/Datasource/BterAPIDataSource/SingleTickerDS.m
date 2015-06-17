//
//  SingleTickerDS.m
//  BterAPI
//
//  Created by jianting on 14/10/11.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "SingleTickerDS.h"

@implementation SingleTickerDS

- (void)tickerInfo:(NSString *)ticker
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[NSString stringWithFormat:@"http://data.bter.com/api/1/ticker/%@",ticker]]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    
    //body & header
    [self startRequest];
}

@end
