//
//  PPQListDataSource.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQListDataSource.h"

@interface PPQListDataSource()
{
    
}

//根据cursor获取列表
- (void) getPageWithCursor:(NSString *)cursor;

@end

@implementation PPQListDataSource

- (void) dealloc
{
    self.cursor = nil;
    [super dealloc];
}

- (void) refresh
{
    self.networkType = EPPQNetworkNormalTag;
    [self getPageWithCursor:self.cursor];
}

- (void) getMore
{
    self.networkType = EPPQNetworkMoreTag;
    [self getPageWithCursor:self.cursor];
}

#pragma mark- set
- (void) getPageWithCursor:(NSString *)cursor
{
    
}

@end
