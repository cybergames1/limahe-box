//
//  UIDevice+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark UIDevice （Platform）设备系统信息
@interface UIDevice (UIDevicePlatform)
/** 获取手机硬件的platform，比如（iPhone1,2）等 */
+ (NSString *)platform;

/** 获取手机硬件的platformType，比如：iphone4S，ipad5等 */
+ (NSString *)platformType;

/** 获取手机硬件的platformDesctiption，比如：iPadMiniRetina(WiFi+CDMA)等 */
+ (NSString *)platformDesctiption;

/**
 判断当前手机操作系统的version是否低与给定的值
 @param systemVersion指定的值，比如"4.0"
 */
+ (BOOL)isCurrentSystemVersionLowerThan:(NSString*)systemVersion;
+ (BOOL)IOS9System; //系统为ios9.0.0 ~
+ (BOOL)IOS8System; //系统为ios8.0.0 ~ 8.3
+ (BOOL)IOS7System; //系统为ios7.0.0~7.9.9
+ (BOOL)IOS6System; //系统为ios6.0.0~6.9.9

/** 手机操作系统版本低于IOS 6.0 **/
+ (BOOL)SystemLowThanIOS6;
/** 手机操作系统版本低于IOS 7.0 **/
+ (BOOL)SystemLowThanIOS7;
/** 手机操作系统版本低于IOS 8.0 **/
+ (BOOL)SystemLowThanIOS8;
/** 手机操作系统版本低于IOS 9.0 */
+ (BOOL)SystemLowThanIOS9;

/** 手机屏幕尺寸是 iphone4、iphone4s 类型的手机 */
+ (BOOL)Iphone4StyleDevice;
/** 手机屏幕尺寸是 iphone5、iphone5s 类型的手机 */
+ (BOOL)Iphone5StyleDevice;
/** 手机屏幕尺寸是 iphone6 类型的手机 */
+ (BOOL)Iphone6StyleDevice;
/** 手机屏幕尺寸是 iphone6 Plus 类型的手机 */
+ (BOOL)Iphone6PlusStyleDevice;

@end

#pragma mark - 
@interface UIDevice (UIDevideDescription)
/**  */
- (NSString*) orientationDescription;

@end

#pragma mark UIDevice （DiskSpace）磁盘大小
@interface UIDevice (UIDeviceDiskSpace)
/** 磁盘空间总大小 */
+ (NSNumber *) diskTotleSpace;
/** 磁盘使用大小 */
+ (NSNumber *) diskUsedSpace;
/** 磁盘剩余 */
+ (NSNumber *) diskFreeSpace;

/** 计算文件大小，比如20K，398M，43G等  */
+ (NSString*) fileSizeWithNumber:(NSNumber*) number;
+ (NSString*) fileSizeWithDouble:(double) value;

@end


#pragma mark (UIDeviceMemoryUse) 内存占用

@interface UIDevice (UIDeviceMemoryUse)
/** 设备总内存 */
+ (NSUInteger) deviceTotleMemory;

/** 格式化的总内存大小，比如128b，256Kb，1024Mb，4Gb等 */
+ (NSString*) formatedDeviceTotleMemory;

/** 设备当前可用内存 */
+ (NSUInteger) deviceAvailableMemory;

/** 格式化的可用内存大小，比如128b，256Kb，1024Mb，4Gb等 */
+ (NSString*) formatedDeviceAvailableMemory;

/** 获取App占用的内存大小 */
+ (NSUInteger) currentAppMemoryUsed;

/** 格式化的App占用内存大小，比如128b，256Kb，1024Mb，4Gb等 */
+ (NSString*) formatedCurrentAppMemoryUsed;

@end






