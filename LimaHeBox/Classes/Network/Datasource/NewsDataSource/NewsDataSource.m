//
//  NewsDataSource.m
//  LimaHeBox
//
//  Created by jianting on 15/8/15.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "NewsDataSource.h"
#import "PPQHTTPRequest.h"

@implementation NewsDataSource

- (void)getNewsListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs getNewsListWithPage:page pageSize:pageSize]]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)getNewsInfoWithId:(NSString *)newsId {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQHTTPRequest *request = [[PPQHTTPRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs getNewsInfoWithId:newsId]]];
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

@end
