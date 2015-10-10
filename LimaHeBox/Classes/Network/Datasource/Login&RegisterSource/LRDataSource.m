//
//  LRDataSource.m
//  LimaHeBox
//
//  Created by jianting on 15/8/15.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LRDataSource.h"
#import "PPQPostDataRequest.h"
#import "AccountManager.h"
#import "LRTools.h"

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
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)updatePwdWithUserName:(NSString *)userName oldpwd:(NSString *)oldpwd newpwd:(NSString *)newpwd {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs updatePassword]]];
    
    [request addPostValue:userName forKey:@"username"];
    [request addPostValue:oldpwd forKey:@"oldpassword"];
    [request addPostValue:newpwd forKey:@"newpassword"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)updateInfoWithGender:(NSString *)gender
                         age:(NSString *)age
                     address:(NSString *)address
                        city:(NSString *)city
                    deviceId:(NSString *)deviceId
{
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs updateInfo]]];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    NSString *authToken = [loginUser userAuthToken];
    
    if (authToken) {
        [request addPostValue:authToken forKey:@"token"];
    }
    
    if (gender) {
        [request addPostValue:gender forKey:@"sex"];
    }
    
    if (age) {
        [request addPostValue:age forKey:@"age"];
    }
    
    if (address) {
        [request addPostValue:address forKey:@"address"];
    }
    
    if (city) {
        [request addPostValue:city forKey:@"city"];
    }
    
    if (deviceId) {
        [request addPostValue:deviceId forKey:@"toolsn"];
    }
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)sendAuthCode:(NSString *)phone {
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs sendAuthCode]]];
    [request addPostValue:phone forKey:@"phone"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

@end
