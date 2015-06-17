//
//  PrivatePlaceOrderDS.m
//  BterAPI
//
//  Created by jianting on 14/10/11.
//  Copyright (c) 2014年 jianting. All rights reserved.
//

#import "PrivatePlaceOrderDS.h"
#import "PPQPostDataRequest.h"
#import "CommonTools.h"

@implementation PrivatePlaceOrderDS

- (void)placeOrderWithTicker:(NSString *)ticker type:(NSString *)type rate:(CGFloat)rate amount:(CGFloat)amount
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    /** 参数 图片data */
    PPQPostDataRequest *request_ = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:@"https://bter.com/api/1/private/placeorder"]];
    //[request_ addData:imageData withFileName:@"header.jpg" andContentType:@"image/jpg" forKey:@"pic"];
    request_.postFormat = ASIMultipartFormDataPostFormat;
    request_.ASIRequest.shouldAttemptPersistentConnection = YES;
    request_.cachePolicy = ASIDoNotReadFromCacheCachePolicy;
    request_.isRunOnBackground = YES;
    
    [request_ addRequestHeader:@"Key" value:API_Key];
    [request_ addRequestHeader:@"Sign" value:[CommonTools hmacSha1:API_Secret text:@""]];
    [request_ addPostValue:ticker forKey:@"pair"];
    [request_ addPostValue:type forKey:@"type"];
    [request_ addPostValue:[NSNumber numberWithFloat:rate] forKey:@"rate"];
    [request_ addPostValue:[NSNumber numberWithFloat:amount] forKey:@"amount"];
    
    self.request = request_;
    [request_ release];
    
    [self startRequest];
}

@end
