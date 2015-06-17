//
//  PPQPostDataRequest.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQPostDataRequest.h"

@implementation PPQPostDataRequest


#pragma mark ---
#pragma mark Init & Dealloc


- (void) initSubObjects
{
    _isLoading = NO;
    self.progressEnabel = NO;
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:self.url];
    request.cachePolicy = ASIDoNotReadFromCacheCachePolicy;
    request.delegate = self;
    self.ASIRequest = request;
    [request release];
}

- (void) dealloc
{
    [super dealloc];
}

#pragma mark ---
#pragma mark Getter & Setter

- (void) setPostFormat:(ASIPostFormat)postFormat
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setPostFormat:postFormat];
}

- (ASIPostFormat) postFormat
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    return request.postFormat;
}

- (void) setStringEncoding:(NSStringEncoding)stringEncoding
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    request.stringEncoding = stringEncoding;
}

- (NSStringEncoding) stringEncoding
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    return request.stringEncoding;
}

#pragma mark ---
#pragma mark Public Method

- (void)appendPostData:(NSData *)data
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request appendPostData:data];
}

- (void)addPostValue:(id <NSObject>)value
              forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addPostValue:value forKey:key];
}


- (void)setPostValue:(id <NSObject>)value
              forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setPostValue:value forKey:key];
}


- (void)addFile:(NSString *)filePath
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addFile:filePath forKey:key];
}


- (void)addFile:(NSString *)filePath
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addFile:filePath withFileName:fileName andContentType:contentType forKey:key];
}


- (void)setFile:(NSString *)filePath
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setFile:filePath forKey:key];
}


- (void)setFile:(NSString *)filePath
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setFile:filePath withFileName:fileName andContentType:contentType forKey:key];
}


- (void)addData:(NSData *)data
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addData:data forKey:key];
}


- (void)addData:(id)data
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addData:data withFileName:fileName andContentType:contentType forKey:key];
}


- (void)setData:(NSData *)data
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setData:data forKey:key];
}


- (void)setData:(id)data
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request setData:data withFileName:fileName andContentType:contentType forKey:key];
}

- (void)addRequestHeader:(NSString *)header value:(NSString *)value
{
    ASIFormDataRequest *request = (ASIFormDataRequest *)self.ASIRequest;
    [request addRequestHeader:header value:value];
}


@end
