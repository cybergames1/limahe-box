//
//  DeviceDataSource.h
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface DeviceDataSource : PPQDataSource

- (void)getDeviceInfo:(NSString *)deviceId;

@end
