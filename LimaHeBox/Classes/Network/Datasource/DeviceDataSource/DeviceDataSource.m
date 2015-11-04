//
//  DeviceDataSource.m
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "DeviceDataSource.h"
#import "PPQPostDataRequest.h"
#import "AccountManager.h"

@implementation DeviceDataSource

- (void)getDeviceInfo:(NSString *)deviceId {
    self.networkType = EPPQNetGetDeviceInfo;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs deviceInfo]]];
    
    [request addPostValue:deviceId forKey:@"toolsn"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)startWeight:(NSString *)deviceId {
    self.networkType = EPPQNetStartWeight;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs startWeight]]];
    
    [request addPostValue:deviceId forKey:@"toolsn"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)sendInstruction:(NSString *)deviceId {
    self.networkType = EPPQNetSendInstruction;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs sendInstruction]]];
    
    [request addPostValue:deviceId forKey:@"toolsn"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)stopWeight:(NSString *)deviceId {
    self.networkType = EPPQNetStopWeight;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs stopWeight]]];
    
    [request addPostValue:deviceId forKey:@"toolsn"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)getWeight:(NSString *)deviceId {
    self.networkType = EPPQNetGetWeight;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs getWeight]]];
    
    [request addPostValue:deviceId forKey:@"toolsn"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

- (void)uploadDeviceToken:(NSString *)deviceToken {
    self.networkType = EPPQNetUploadDeviceToken;
    [self cancelAllRequest];
    [self.request clearAndCancel];
    self.request = nil;
    
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    PPQPostDataRequest *request = [[PPQPostDataRequest alloc] initWithDelegate:self theURl:[NSURL URLWithString:[PPQNetWorkURLs getWeight]]];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    
    [request addPostValue:deviceToken forKey:@"iosid"];
    [request addPostValue:loginUser.userAuthToken forKey:@"token"];
    [request addPostValue:loginUser.userId forKey:@"userid"];
    
    self.request = request;
    self.request.isRunOnBackground = YES;
    [request release];
    [self startRequest];
}

@end
