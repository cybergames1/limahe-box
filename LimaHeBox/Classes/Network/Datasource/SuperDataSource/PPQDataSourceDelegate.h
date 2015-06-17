//
//  PPQDataSourceDelegate.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPQDataSource;

@protocol PPQDataSourceDelegate <NSObject>

@optional

- (void)dataSourceDidStartLoad:(PPQDataSource *)source;
- (void)dataSourceFinishLoad:(PPQDataSource *)source;
- (void)dataSourceDidCancel:(PPQDataSource *)source;
- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error;
- (void)dataSource:(PPQDataSource *)source progress:(CGFloat)progress;

@end
