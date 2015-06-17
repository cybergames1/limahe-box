//
//  PPQListDataSource.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQDataSource.h"


/**
 
    所有列表的数据源基类
 
 **/


@interface PPQListDataSource : PPQDataSource
{
    
}

@property (nonatomic, retain) NSString *cursor;

//刷新操作调用
- (void) refresh;

//加载更多
- (void) getMore;

@end
