//
//  PPQDataSource.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQDataSource.h"
#import "ASIDownloadCache.h"
#import "CommonTools.h"
#import "SocialTools.h"

@implementation PPQDataSource

#pragma mark ---
#pragma mark Init & Dealloc

- (id) initWithDelegate:(id<PPQDataSourceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.userInfo = nil;
        _isCanceled = NO;
        _isLoading = NO;
        _isFinished = NO;
        self.networkType = EPPQNetworkNoneTag;
        self.requestType = nil;
        return self;
    }
    return nil;
}

- (void) dealloc
{
    self.data = nil;
    self.userInfo = nil;
    self.delegate = nil;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    self.requestType = nil;
    
    [super dealloc];
}

#pragma mark Public Method
#pragma mark ---

- (void) startRequest
{
    [self startRequestWithCatchPolicy:PPQCatchPolicyFailBackToTheCache];
}

- (void) startRequestWithCatchPolicy:(PPQRequestCachePolicy)policy
{
    NSLog(@"%@", self.request.url);

    self.request.cachePolicy = policy;
    
    //如果是读缓存，那么需要同步
    if (policy == PPQCatchPolicyReadTheCache)
    {
        [self.request startLoadSynchronous];
        return;
    }
    
    [self.request startLoad];
}

- (BOOL) loadCache
{
    return YES;
}

- (void) cancelAllRequest
{
    [self.request cancelLoad];
}

- (BOOL) isLoading
{
    return self.request.isLoading;
}

- (BOOL) isFinished
{
    return self.request.isFinished;
}

- (BOOL) isCanceled
{
    return self.request.isCanceled;
}

#pragma mark Private Method
#pragma mark ---

- (NSError *) parseDataFromServer:(id)data
{
    //子类要覆盖
    NSInteger statusCode = self.request.responseStatusCode;
    if (data) {
        //当服务器有某些错误的情况下，返回的data=nil
        self.data = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
    }
    NSLog(@"\n  datasource: %@ \n  URL：%@ \n  statusCode:%ld \n  data:%s \n\n",NSStringFromClass([self class]),self.request.url,(long)statusCode,[[self.data description] UTF8String]);
 //   NSString *code = [(NSDictionary *)self.data objectForKey:KErrorCode];
    
    //服务器内部错误
    if (statusCode >= KErrorCodeServerError)
    {
        return [NSError errorWithDomain:KErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObject:@"服务器内部错误" forKey:NSLocalizedDescriptionKey]];
    }
    //code正常，也可能错误
    else if (statusCode >= KErrorCodeOKMin && statusCode <= KErrorCodeOKMax)
    {
        NSString *code = [(NSDictionary *)self.data objectForKey:@"code"];
        if (code && ![code isEqualToString:@"200"]) {
            NSString *msg = [(NSDictionary *)self.data objectForKey:@"data"];
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:0];
            [userInfo setObject:code ? code : @"CODE" forKey:KErrorCodeKey];
            [userInfo setObject:msg ? msg : @"NO MSG" forKey:NSLocalizedDescriptionKey];
            return  [NSError errorWithDomain:KErrorDomain code:[code integerValue] userInfo:userInfo];
        }
        return nil;
//        //正常
//        if ([code isEqualToString:KErrorNormal])
//        {
//            return nil;
//        }
//        //参数不合法等错误
//        else
//        {
//            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//            [userInfo setObject:([(NSDictionary *)self.data objectForKey:KErrorMSG] == nil) ? @"没有MSG" : [(NSDictionary *)self.data objectForKey:KErrorMSG] forKey:NSLocalizedDescriptionKey];
//            [userInfo setObject:([(NSDictionary *)self.data objectForKey:KErrorCode] == nil) ? @"CODE" : [(NSDictionary *)self.data objectForKey:KErrorCode] forKey:KErrorCodeKey];
//            
//            return [NSError errorWithDomain:KErrorDomain code:statusCode userInfo:userInfo];
//        }
    }
    return [NSError errorWithDomain:KErrorDomain code:statusCode userInfo:[NSDictionary dictionaryWithObject:@"未知错误" forKey:NSLocalizedDescriptionKey]];
}

#pragma mark Request Delegate
#pragma mark ---

- (void) requestStarted:(ASIHTTPRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(dataSourceDidStartLoad:)])
    {
        [self.delegate dataSourceDidStartLoad:self];
    }
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished ==> %@\r\n%@ \n",request.url, request.responseString);
    NSError *error = [self parseDataFromServer:request.responseData];
    if(!error)
    {
        if ([self.delegate respondsToSelector:@selector(dataSourceFinishLoad:)])
        {
            [self.delegate dataSourceFinishLoad:self];
        }
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(dataSource:hasError:)])
    {
        [self.delegate dataSource:self hasError:[SocialTools networkError:error]];
    }
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(dataSource:hasError:)])
    {
        [self.delegate dataSource:self hasError:[SocialTools networkError:request.error]];
    }
}

- (void) requestCanceled:(ASIHTTPRequest *)request
{
    if ([self.delegate respondsToSelector:@selector(dataSourceDidCancel:)])
    {
        [self.delegate dataSourceDidCancel:self];
    }
}

- (void) setProgress:(float)newProgress
{
    if ([self.delegate respondsToSelector:@selector(dataSource:progress:)])
    {
        [self.delegate dataSource:self progress:newProgress];
    }
}

@end


@implementation PPQDataSource (CacheManager)

#pragma mark-
#pragma mark- restore Response Data

- (BOOL)restoreResponseData:(id) data
{
    return [self restoreResponseData:data forRequestUrl:self.request.url];
}

- (BOOL)restoreResponseData:(id) data forRequestUrl:(NSURL*) url
{
    if (data == nil || [CommonTools isEmptyString:[url absoluteString]])
    {
        return NO;
    }
    
    NSData* newData = nil;
    if ([data isKindOfClass:[NSString class]])
    {
        newData = [(NSString*)data dataUsingEncoding:[self.request.ASIRequest responseEncoding]];
    }
    else if ([data isKindOfClass:[NSData class]])
    {
        newData = (NSData*)data;
    }
    else if ([data isKindOfClass:[NSDictionary class]]){
        newData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
    }
    
    if (newData == nil)
    {
        return NO;
    }
    
    ASIDownloadCache* cache = [ASIHTTPRequest defaultCache];
    ASIHTTPRequest* requese = [[ASIHTTPRequest alloc] initWithURL:url];
    requese.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    NSString* path = [cache pathToStoreCachedResponseDataForRequest:requese];
    [requese release];
    if ([CommonTools isEmptyString:path])
    {
        return NO;
    }
    
    NSError* error = nil;
    BOOL finish = [newData writeToFile:path options:NSDataWritingAtomic error:&error];
    return finish;
}

+ (BOOL)restoreResponseData:(id) data forRequestUrl:(NSURL*) url
{
    if (data == nil || [CommonTools isEmptyString:[url absoluteString]])
    {
        return NO;
    }
    
    NSData* newData = nil;
    if ([data isKindOfClass:[NSString class]])
    {
        newData = [(NSString*)data dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if ([data isKindOfClass:[NSData class]])
    {
        newData = (NSData*)data;
    }
    else if ([data isKindOfClass:[NSDictionary class]]){
        newData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
    }
    
    if (newData == nil)
    {
        return NO;
    }
    
    ASIDownloadCache* cache = [ASIHTTPRequest defaultCache];
    ASIHTTPRequest* requese = [[ASIHTTPRequest alloc] initWithURL:url];
    requese.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    NSString* path = [cache pathToStoreCachedResponseDataForRequest:requese];
    [requese release];
    if ([CommonTools isEmptyString:path])
    {
        return NO;
    }
    
    NSError* error = nil;
    BOOL finish = [newData writeToFile:path options:NSDataWritingAtomic error:&error];
    return finish;
}

+ (id) cacheDataWithUrl:(NSURL*) url
{
    if (url == nil) {
        return nil;
    }
    
    ASIDownloadCache* cache = [ASIHTTPRequest defaultCache];
    
    NSString* path = [cache pathToCachedResponseDataForURL:url];
    if ([CommonTools isEmptyString:path])
    {
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:[cache cachedResponseDataForURL:url] options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
}

#pragma mark-
#pragma mark- Clear cache

+ (void) clearAllCachesWithUrl:(NSURL*) url
{
    if (url == nil)
    {
        return;
    }
    
    ASIDownloadCache* cache = [ASIHTTPRequest defaultCache];
    
    NSString* path = [cache pathToCachedResponseDataForURL:url];
    if ([CommonTools isEmptyString:path])
    {
        return;
    }
    BOOL finish = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    if (finish == NO)
    {
        ;
    }
}

#pragma mark-
#pragma mark- cache Exist
+ (BOOL) cacheExistWithURL:(NSURL*) url
{
    return [PPQDataSource cacheExistWithURL:url dataKey:@"data"];
}
+ (BOOL) cacheExistWithURL:(NSURL*) url dataKey:(NSString*) dataKey
{
    id cacheData = [PPQDataSource cacheDataWithUrl:url];
    if (cacheData == nil) {
        return NO;
    }
    
    if (NO == [cacheData isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if ([CommonTools isEmptyString:dataKey])
    {
        dataKey = @"data";
    }
    
    id data = [cacheData valueForKey:dataKey];
    if (data == nil) {
        return NO;
    }
    if ([data isKindOfClass:[NSArray class]]) {
        if ([(NSArray*)data count] <= 0) {
            return NO;
        }
    }
    else if ([data isKindOfClass:[NSDictionary class]]){
        if ([(NSDictionary*)data count] <= 0) {
            return NO;
        }
    }
    
    return YES;
}

@end
