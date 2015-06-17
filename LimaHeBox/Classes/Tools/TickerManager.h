//
//  TickerManager.h
//  BterAPI
//
//  Created by jianting on 14/10/12.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTicker.h"

@interface TickerManager : NSObject

+ (TickerManager *)sharedManager;


- (void)addTicker:(MTicker *)ticker;
- (void)removeTicker:(MTicker *)ticker;

- (MTicker *)tickerAtIndex:(NSInteger)index;
- (MTicker *)tickerWithName:(NSString *)ticker;

@end
