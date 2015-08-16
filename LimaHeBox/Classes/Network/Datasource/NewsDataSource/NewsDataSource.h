//
//  NewsDataSource.h
//  LimaHeBox
//
//  Created by jianting on 15/8/15.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface NewsDataSource : PPQDataSource

- (void)getNewsListWithPage:(NSInteger)page
                   pageSize:(NSInteger)pageSize;

- (void)getNewsInfoWithId:(NSString *)newsId;

@end
