//
//  SingleTickerDS.h
//  BterAPI
//
//  Created by jianting on 14/10/11.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

/*
 * 单项交易行情 API
 */

@interface SingleTickerDS : PPQDataSource

- (void)tickerInfo:(NSString *)ticker;

@end
