//
//  TickerManager.m
//  BterAPI
//
//  Created by jianting on 14/10/12.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "TickerManager.h"

@interface TickerManager ()
{
    NSMutableArray * _tickers;
}

@end

@implementation TickerManager

- (void)dealloc
{
    [_tickers release];_tickers = nil;
    
    [super dealloc];
}

+ (TickerManager *)sharedManager
{
    static dispatch_once_t pred;
    static TickerManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[TickerManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _tickers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


- (void)addTicker:(MTicker *)ticker
{
    if (ticker)
    {
        [_tickers addObject:ticker];
    }
}

- (void)removeTicker:(MTicker *)ticker
{
    if (ticker)
    {
        [_tickers removeObject:ticker];
    }
}

- (MTicker *)tickerAtIndex:(NSInteger)index
{
    if (index >= 0 && index < [_tickers count])
    {
        return [_tickers objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

- (MTicker *)tickerWithName:(NSString *)ticker
{
    MTicker *mticker = nil;
    
    if (ticker && ticker.length)
    {
        for (MTicker *t in _tickers)
        {
            if ([t.tickerName compare:ticker options:NSCaseInsensitiveSearch] == NSOrderedSame)
            {
                mticker = t;
                break;
            }
        }
    }
    
    return mticker;
}

@end
