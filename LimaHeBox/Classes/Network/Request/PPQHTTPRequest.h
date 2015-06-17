//
//  PPQHTTPRequest.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "PPQHTTPRequestDelegate.h"

/**
    
    //网络请求 为GET方法
 
 **/

typedef NS_ENUM(NSInteger, PPQRequestCachePolicy)
{
    PPQCatchPolicyFailBackToTheCache = ASIFallbackToCacheIfLoadFailsCachePolicy, /** 不管有没有缓存，都先访问服务器，访问失败了就会读缓存.这个选项经常被用来与其它选项组合使用。请求失败时，使用本地缓存数据，如果使用本地缓冲，请求会成功不会引发错误（这个在处理异常时非常有用）**/
    PPQCatchPolicyReadTheCache = ASIDontLoadCachePolicy, /** 仅仅读缓存，如果没有缓存也不会去访问服务器，也不会回调错误.只要有缓存，就读取缓存数据而不管数据是否过期。如果缓存中没有数据，则停止，不向服务器请求。 */
    PPQCatchPolicyDoNotReadTheCache = ASIDoNotReadFromCacheCachePolicy, /** 不管怎样都不读缓存 **/
    PPQCatchPolicyDoNotWriteToTheCache = ASIDoNotWriteToCacheCachePolicy /** 不写缓存 **/
};


@interface PPQHTTPRequest : NSObject<ASIHTTPRequestDelegate, ASIProgressDelegate>
{
    ASIHTTPRequest *_ASIRequest;
    id<PPQHTTPRequestDelegate> _delegate;
    BOOL _isLoading;
    BOOL _progressEnabel;
    PPQRequestCachePolicy _policy;
    
    NSURL *_url;
}

@property (nonatomic, retain) ASIHTTPRequest *ASIRequest;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, assign) id<PPQHTTPRequestDelegate> delegate;
@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, readonly) BOOL isFinished;
@property (nonatomic, readonly) BOOL isCanceled;
@property (nonatomic, assign) PPQRequestCachePolicy cachePolicy;
@property (nonatomic, assign) BOOL isRunOnBackground;
@property (nonatomic, assign) BOOL progressEnabel;
@property (nonatomic, readonly) NSInteger responseStatusCode;
@property (nonatomic, readonly) NSDictionary *responseHeader;

@end

#pragma mark --
#pragma mark QiYiHTTPRequest protected

@interface PPQHTTPRequest (Protected)
{
    
}

- (void) initSubObjects;

@end

#pragma mark --
#pragma mark QiYiHTTPRequest public

@interface PPQHTTPRequest (Public)

- (id) initWithDelegate:(id<PPQHTTPRequestDelegate>)delegate theURl:(NSURL *)url;

//方便可维护，请用到ASIHTTPRequest属性，或者其他方法的，请在这里继续包装，然后说明
- (void) startLoad;

//同步方法
- (void) startLoadSynchronous;
- (void) cancelLoad;
- (void) clearAndCancel;
- (void) reuse;

- (void) addRequestHeader:(NSString *)header value:(NSString *)value;

@end


/*
 ASIUseDefaultCachePolicy 0  // 默认情况下的缓存策略(它不能与其它策略组合使用)
 
 ASIDoNotReadFromCacheCachePolicy  1 // 当前请求不读取缓存数据。
 
 ASIDoNotWriteToCacheCachePolicy  2 // 当前请求不写缓存数据。
 ASIAskServerIfModifiedWhenStaleCachePolicy  4 // 默认缓存行为，request会先判断是否存在缓存数据，如果没有再进行网络请求。 如果存在缓存数据，并且数据没有过期，则使用缓存。如果存在缓存数据，但已经过期，request会先进行网络请求，判断服务器版本与本地版本是否一样，如果一样，则使用缓存。如果服务器有新版本，会进行网络请求，并更新本地缓存。（使用GET请求时有效）
 
 ASIAskServerIfModifiedCachePolicy  8 // 每次请求都会 去服务器判断是否有更新。（使用GET请求时有效）
 ASIOnlyLoadIfNotCachedCachePolicy 16 // 只要有缓存，就读取缓存数据而不管数据是否过期。直到请求的数据不在缓冲中时，才去服务器获取。
 
 ASIDontLoadCachePolicy  32 // 只要有缓存，就读取缓存数据而不管数据是否过期。如果缓存中没有数据，则停止，不向服务器请求。
 
 ASIFallbackToCacheIfLoadFailsCachePolicy  64 // 这个选项经常被用来与其它选项组合使用。请求失败时，使用本地缓存数据，如果使用本地缓冲，请求会成功不会引发错误（这个在处理异常时非常有用）
*/

