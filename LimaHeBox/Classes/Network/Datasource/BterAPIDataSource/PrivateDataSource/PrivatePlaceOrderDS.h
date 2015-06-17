//
//  PrivatePlaceOrderDS.h
//  BterAPI
//
//  Created by jianting on 14/10/11.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface PrivatePlaceOrderDS : PPQDataSource

/*
 * @param ticker,币的id，tickerA_tickerB形式
 * @param type,买卖类型，BUY或SELL表示买和卖
 * @param rate,价格
 * @param amount,量
 */
- (void)placeOrderWithTicker:(NSString *)ticker
                        type:(NSString *)type
                        rate:(CGFloat)rate
                      amount:(CGFloat)amount;

@end
