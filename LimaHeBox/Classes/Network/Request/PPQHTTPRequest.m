//
//  PPQHTTPRequest.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQHTTPRequest.h"
#import "CommonTools.h"

#pragma mark --
#pragma mark QiYiHTTPRequest private

@interface PPQHTTPRequest(Private)
{
    
}

@end


@implementation PPQHTTPRequest

@synthesize cachePolicy = _cachePolicy;

#pragma mark --
#pragma mark Init & Dealloc

- (id) initWithDelegate:(id<PPQHTTPRequestDelegate>)delegate theURl:(NSURL *)url
{
    if ([CommonTools isEmptyString:[url absoluteString]])
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.url = url;
        
        [self initSubObjects];
        return self;
    }
    return nil;
}

- (void) initSubObjects
{
    _isLoading = NO;
    self.progressEnabel = NO;
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:self.url];
    request.cachePolicy = ASIFallbackToCacheIfLoadFailsCachePolicy;
    request.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    request.delegate = self;
    self.ASIRequest = request;
    [request release];
}

- (void) reuse
{
    ASIHTTPRequest *request = [[self.ASIRequest copy] autorelease];
    self.ASIRequest = request;
}

- (void) dealloc
{
    self.delegate = nil;
    self.url = nil;
    [self.ASIRequest cancel];
    [self.ASIRequest clearDelegatesAndCancel];
    self.ASIRequest = nil;
    [super dealloc];
}

#pragma mark --
#pragma mark Public

- (void) addRequestHeader:(NSString *)header value:(NSString *)value
{
    [self.ASIRequest addRequestHeader:header value:value];
}

- (void) startLoad
{
    [self.ASIRequest startAsynchronous];
}

- (void) startLoadSynchronous
{
    [self.ASIRequest startSynchronous];
}

- (void) cancelLoad
{
    [self.ASIRequest cancel];
}

- (void) clearAndCancel
{
    self.delegate = nil;
    [self.ASIRequest clearDelegatesAndCancel];
}

- (BOOL) isLoading
{
    return self.ASIRequest.inProgress;
}

- (BOOL) isFinished
{
    return self.ASIRequest.isFinished;
}

- (BOOL) isCanceled
{
    return self.ASIRequest.isCancelled;
}

- (void) setCachePolicy:(PPQRequestCachePolicy)cachePolicy
{
    _cachePolicy = cachePolicy;
    self.ASIRequest.cachePolicy = (ASICachePolicy)cachePolicy;
}

- (PPQRequestCachePolicy) cachePolicy
{
    return _cachePolicy;
}

- (NSInteger) responseStatusCode
{
    return self.ASIRequest.responseStatusCode;
}

- (NSDictionary *) responseHeader
{
    return self.ASIRequest.responseHeaders;
}

- (void) setIsRunOnBackground:(BOOL)isRunOnBackground
{
    self.ASIRequest.shouldContinueWhenAppEntersBackground = isRunOnBackground;
}

- (void) setProgressEnabel:(BOOL)progressEnabel
{
    if (self.isLoading)
    {
        return;
    }
    
    _progressEnabel = progressEnabel;
    if (progressEnabel)
    {
        self.ASIRequest.uploadProgressDelegate = self;
        self.ASIRequest.downloadProgressDelegate = self;
    }
    else
    {
        self.ASIRequest.uploadProgressDelegate = nil;
        self.ASIRequest.downloadProgressDelegate = nil;
    }
}

#pragma mark --
#pragma mark ASIRequestDelegate & ASIRequestProgressDelegate


- (void)requestStarted:(ASIHTTPRequest *)request
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(requestStarted:)])
    {
        [self.delegate requestStarted:self.ASIRequest];
    }
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(request:didReceiveResponseHeaders:)])
    {
        [self.delegate request:self.ASIRequest didReceiveResponseHeaders:responseHeaders];
    }
}

- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(request:willRedirectToURL:)])
    {
        [self.delegate request:self.ASIRequest willRedirectToURL:newURL];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(requestFinished:)])
    {
        [self.delegate requestFinished:self.ASIRequest];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //如果是取消调过来的请求，那么调用取消的代理方法
    if (request.isCancelled)
    {
        if ([(NSObject *)self.delegate respondsToSelector:@selector(requestCanceled:)])
        {
            [self.delegate requestCanceled:self.ASIRequest];
        }
        return;
    }
    if ([(NSObject *)self.delegate respondsToSelector:@selector(requestFailed:)])
    {
        [self.delegate requestFailed:self.ASIRequest];
    }
}

- (void)requestRedirected:(ASIHTTPRequest *)request
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(requestRedirected:)])
    {
        [self.delegate requestRedirected:self.ASIRequest];
    }
}

- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
    
}

- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
    
}

- (void)setProgress:(float)newProgress
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(setProgress:)])
    {
        [self.delegate setProgress:newProgress];
    }
}

@end
