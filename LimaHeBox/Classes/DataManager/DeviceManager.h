//
//  DeviceManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MDevice : NSObject

/** 设备号 **/
@property (nonatomic, copy) NSString * deviceId;
/** GPS经纬度 **/
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/** 温度 **/
@property (nonatomic, assign) CGFloat temperature;
/** 湿度 **/
@property (nonatomic, assign) CGFloat wet;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface DeviceManager : NSObject

@property (nonatomic, retain) MDevice * currentDevice;

+ (DeviceManager *)sharedManager;

@end
