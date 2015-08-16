//
//  LRDataSource.m
//  LimaHeBox
//
//  Created by jianting on 15/8/15.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LRDataSource.h"
#import "PPQPostDataRequest.h"

@implementation LRDataSource

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs login]]];
    
    [request addPostValue:userName forKey:@"username"];
    [request addPostValue:password forKey:@"password"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)registerWithUserName:(NSString *)userName password:(NSString *)password phone:(NSString *)phone {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs registerBox]]];
    
    [request addPostValue:userName forKey:@"username"];
    [request addPostValue:password forKey:@"password"];
    [request addPostValue:phone forKey:@"mobile"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

@end
