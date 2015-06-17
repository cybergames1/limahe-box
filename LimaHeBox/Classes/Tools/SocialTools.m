//
//  SocialTools.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "SocialTools.h"
#import "ASIHTTPRequest.h"
#import "NetworkConstant.h"

@implementation SocialTools

#pragma mark- 底层Error处理

/*
 这个方法负责过滤网络底层的错误，然后给上层提供用户可以理解的错误信息
 */

+ (NSError*) networkError:(NSError*)error
{
    //非底层错误，直接返回
    if (error.code >= KErrorCodeOKMin && error.code <= KErrorCodeOKMax)
    {
        return error;
    }
    
    NSInteger code_ = -1;
    NSString* description_ = nil;
    switch (error.code)
    {
        case ASIConnectionFailureErrorType:
        {
            code_ = kErrorCodeConnectionFailure;
            description_ = @"您的网络似乎有些问题";
        }
            break;
        case ASIRequestTimedOutErrorType:
        {
            code_ = kErrorCodeConnectionFailure;
            description_ = @"网络请求时间超时";
        }
            break;
            
        case ASIRequestCancelledErrorType:
        {
            code_ = kErrorCodeConnectionFailure;
            description_ = @"网络请求取消";
        }
            break;
            
        default:
        {
            code_ = kErrorCodeDefaultError;
            description_ = @"网络连接出现错误";
        }
            break;
    }
    
    return [NSError errorWithDomain:KErrorDomain code:code_ userInfo:[NSDictionary dictionaryWithObjectsAndKeys:description_,NSLocalizedDescriptionKey,nil]];
}

@end









