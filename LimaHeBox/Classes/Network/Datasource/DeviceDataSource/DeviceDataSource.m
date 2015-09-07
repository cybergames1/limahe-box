//
//  DeviceDataSource.m
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "DeviceDataSource.h"
#import "PPQPostDataRequest.h"

@implementation DeviceDataSource

- (void)getDeviceInfo:(NSString *)deviceId {
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

@end
