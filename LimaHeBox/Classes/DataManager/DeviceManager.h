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
/** 是否在线 **/
@property (nonatomic, assign) BOOL isOnline;
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

extern NSString* const DeviceInfoIsOnlineKey;
extern NSString* const DeviceInfoWeightKey;

extern NSString* const UpdateDeviceInfoNotification;


@interface DeviceManager : NSObject

@property (nonatomic, retain) MDevice * currentDevice;

+ (DeviceManager *)sharedManager;

/**
  获取设备信息:gps，温湿度，称重
 **/
- (void)startGetDeviceInfo:(void(^)(NSError *))start
                   success:(void(^)())success
                   failure:(void(^)(NSError*))failure;

/**
  上传deviceToken，用于收取push通知
 **/
- (void)uploadDeviceToken:(NSString *)deviceToken;

@end

enum {
    WeightStepStartModle, //开启模式，先要查看设备状态
    WeightStepStartWeight, //开启称重
    WeightStepSendInstruction, //发送指令
    WeightStepGETWeight, //获取称重数据
    WeightStepStopModle, //停止模式
};
typedef NSInteger WeightStep;

@interface DeviceManager (Weight)

/**
 由于称重比较特殊，专门处理
 称重流程，开启称重模式->点击"start"发送称重指令->获取称重信息->关闭称重模式
 **/
- (void)setWeightStep:(WeightStep)step
                start:(void(^)(NSError *))start
              success:(void(^)())success
              failure:(void(^)(NSError*))failure;

@end
