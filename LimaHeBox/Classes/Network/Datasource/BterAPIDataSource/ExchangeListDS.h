//
//  ExchangeListDS.h
//  BterAPI
//
//  Created by jianting on 14/10/10.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

/*
 * 所有交易对 API
 */

@interface ExchangeListDS : PPQDataSource

- (void)getExchangeList;

@end
