//
//  PPQHTTPRequestDelegate.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

@protocol PPQHTTPRequestDelegate <NSObject>

@optional

//这些都是默认的代理方法，可以通过单独设置request的代理方法，如果设定了， 那么这些失效
- (void)requestStarted:(ASIHTTPRequest *)request;
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)requestCanceled:(ASIHTTPRequest *)request;
- (void)requestRedirected:(ASIHTTPRequest *)request;

//这个是用于自定义数据接受的方法，如果实现了，那么提供的相应属性失效
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;

- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request;
- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request;

//上传和下载进度
- (void)setProgress:(float)newProgress;

@end
