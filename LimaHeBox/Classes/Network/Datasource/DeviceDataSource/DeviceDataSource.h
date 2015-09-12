//
//  DeviceDataSource.h
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface DeviceDataSource : PPQDataSource

/** 获取设备信息，如gps，温湿度等 **/
- (void)getDeviceInfo:(NSString *)deviceId;

/** 启动称重 **/
- (void)startWeight:(NSString *)deviceId;

/** 获取称重信息 **/
- (void)getWeight:(NSString *)deviceId;

@end
