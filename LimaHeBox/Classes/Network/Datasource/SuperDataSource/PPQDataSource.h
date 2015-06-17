//
//  PPQDataSource.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPQDataSourceDelegate.h"
#import "PPQHTTPRequest.h"

#import "PPQNetWorkURLs.h"
#import "NetworkConstant.h"
/**
    
    数据源基类，负责下载，解析数据
 
 **/

@interface PPQDataSource : NSObject<PPQHTTPRequestDelegate>
{
    id<PPQDataSourceDelegate> _delegate;
    BOOL _isLoading;
    BOOL _isFinished;
    BOOL _isCanceled;
}

@property (nonatomic, retain) PPQHTTPRequest *request;
@property (nonatomic, retain) id data;
@property (nonatomic, assign) id<PPQDataSourceDelegate> delegate;
@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly) BOOL isFinished;
@property (nonatomic, readonly) BOOL isCanceled;
@property (nonatomic, assign) PPQNetworkTag networkType;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, retain) NSString *requestType;


- (id) initWithDelegate:(id<PPQDataSourceDelegate>)delegate;


/** 默认的catchPolicy为 ASIFallbackToCacheIfLoadFailsCachePolicy **/
- (void) startRequest;
/** 指定catchPolicy **/
- (void) startRequestWithCatchPolicy:(PPQRequestCachePolicy)policy;
- (void) cancelAllRequest;
- (NSError *) parseDataFromServer:(id)data;

- (BOOL) loadCache;

@end

@interface PPQDataSource (CacheManager)
/*
 存储（覆盖）服务器返回数据,适用场合：在需要修改返回数据的某些字段后，
 需要重新保存该数据,比如：赞、评论视频后，赞数量（评论数）需要增加的场合
 
 data：修改后的数据 (NSString/NSData类型)
 */
- (BOOL)restoreResponseData:(id) data;
/*
 存储（覆盖）服务器返回数据,适用场合：在需要修改返回数据的某些字段后，
 需要重新保存该数据,比如：赞、评论视频后，赞数量（评论数）需要增加的场合
 
 data：修改后的数据 (NSString/NSData类型)
 url : 对应的url (NSUrl类型)
 */
- (BOOL)restoreResponseData:(id) data forRequestUrl:(NSURL*) url;
+ (BOOL)restoreResponseData:(id) data forRequestUrl:(NSURL*) url;
/*
 取得缓存数据,返回数据为格式化好的json
 url:对应的url (NSUrl类型)
 */
+ (id) cacheDataWithUrl:(NSURL*) url;

/*
 根据特定的url清空网络缓存
 */
+ (void) clearAllCachesWithUrl:(NSURL*) url;

/*
 是否有缓存:
 1、有缓存文件 2、缓存文件中data字段有内容
 url:对应的url (NSUrl类型)
 dataKey：默认取“data”
 */
+ (BOOL) cacheExistWithURL:(NSURL*) url;
/*
 是否有缓存:
 1、有缓存文件 2、缓存文件中data字段有内容
 url:    对应的url (NSUrl类型)
 dataKey:数据字段的关键字，比如“data”
 */
+ (BOOL) cacheExistWithURL:(NSURL*) url dataKey:(NSString*) dataKey;


@end
