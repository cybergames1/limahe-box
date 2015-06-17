//
//  PrviateTradesDS.m
//  BterAPI
//
//  Created by jianting on 14/10/13.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PrviateTradesDS.h"
#import "PPQPostDataRequest.h"
#import "CommonTools.h"

@implementation PrviateTradesDS

- (void)tradesForTicker:(NSString *)ticker
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    /** 参数 图片data */
    PPQPostDataRequest *request_ = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:@"https://bter.com/api/1/private/mytrades"]];
    request_.postFormat = ASIMultipartFormDataPostFormat;
    request_.ASIRequest.shouldAttemptPersistentConnection = YES;
    request_.cachePolicy = ASIDoNotReadFromCacheCachePolicy;
    request_.isRunOnBackground = YES;
    
    [request_ addRequestHeader:@"Key" value:API_Key];
    [request_ addRequestHeader:@"Sign" value:[CommonTools hmacSha1:API_Secret text:@""]];
    [request_ addPostValue:ticker forKey:@"pair"];
    
    
    self.request = request_;
    [request_ release];
    
    [self startRequest];
}

@end
