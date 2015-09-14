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
/** 称重 **/
@property (nonatomic, assign) CGFloat weight;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

/** 更新个人信息 **/
- (void)updateValue:(id)value forKey:(NSString *)key;

/** 称重是另外一个接口，所以特别提出一个更新称重的方法 **/
- (void)updateWeightWithDictionary:(NSDictionary *)dic;

@end

extern NSString* const UserInfoWeightKey;

extern NSString* const UpdateUserInfoNotification;


@interface DeviceManager : NSObject

@property (nonatomic, retain) MDevice * currentDevice;

+ (DeviceManager *)sharedManager;

@end
