//
//  PrviateTradesDS.h
//  BterAPI
//
//  Created by jianting on 14/10/13.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface PrviateTradesDS : PPQDataSource

- (void)tradesForTicker:(NSString *)ticker;

@end
