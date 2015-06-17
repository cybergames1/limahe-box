//
//  PPQPostDataRequest.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPQHTTPRequest.h"
#import "ASIFormDataRequest.h"

/**
 
 //网络请求 为POST方法
 
 **/

#pragma mark --
#pragma mark QiYiHTTPRequest Interface

@interface PPQPostDataRequest : PPQHTTPRequest
{
    
}

//其他属性请到基类添加
@property (assign, nonatomic) ASIPostFormat postFormat;
@property (assign, nonatomic) NSStringEncoding stringEncoding;

@end


@interface PPQPostDataRequest (Public)

- (void)appendAppKey;

- (void)appendPostData:(NSData *)data;

- (void)addPostValue:(id <NSObject>)value
              forKey:(NSString *)key;


- (void)setPostValue:(id <NSObject>)value
              forKey:(NSString *)key;


- (void)addFile:(NSString *)filePath
         forKey:(NSString *)key;


- (void)addFile:(NSString *)filePath
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key;


- (void)setFile:(NSString *)filePath
         forKey:(NSString *)key;


- (void)setFile:(NSString *)filePath
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key;


- (void)addData:(NSData *)data
         forKey:(NSString *)key;


- (void)addData:(id)data
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key;


- (void)setData:(NSData *)data
         forKey:(NSString *)key;


- (void)setData:(id)data
   withFileName:(NSString *)fileName
 andContentType:(NSString *)contentType
         forKey:(NSString *)key;

- (void)addRequestHeader:(NSString *)header
                   value:(NSString *)value;

@end