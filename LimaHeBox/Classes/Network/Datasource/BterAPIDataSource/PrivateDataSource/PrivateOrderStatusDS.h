//
//  PrivateOrderStatusDS.h
//  BterAPI
//
//  Created by jianting on 14/10/11.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

/*
 * 下单状态
 */
@interface PrivateOrderStatusDS : PPQDataSource

- (void)orderStatus:(NSString *)orderId;

@end
