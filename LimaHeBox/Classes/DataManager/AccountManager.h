//
//  AccountManager.h
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxStorageModel.h"

@interface MUser : NSObject

@property (nonatomic,copy,readonly) NSString *userId;
@property (nonatomic,copy,readonly) NSString *userName;
@property (nonatomic,copy,readonly) NSString *userIcon;
@property (nonatomic,copy,readonly) NSString *userPhone;
@property (nonatomic,copy,readonly) NSString *userAge; //暂时只是显示年龄，以后要改成生日的date
@property (nonatomic,copy,readonly) NSString *userCity;
@property (nonatomic,copy,readonly) NSString *userGender; //现在为字符串，以后改成0/1这种形式
@property (nonatomic,copy,readonly) NSString *userAddress;
@property (nonatomic,copy,readonly) NSString *userDeviceId;

/**
 用服务端返回的字典类型初始化loginUser
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface MUser (UpdateData)
/**
 更新用户资料信息
 @param value 用户信息
 @param key 用户 key，必须是下面定义的key
 */
- (void) updateUserValue:(id) value forKey:(NSString*) key;

@end

extern NSString* const kUserInfoAuthKey;         // authcookie
extern NSString* const kUserInfoOPTokenKey;      // openAPIAccessToken
extern NSString* const kUserInfoNameKey;         // user name
extern NSString* const kUserInfoIntroductionKey; // user Introduction
extern NSString* const kUserInfoAddressKey;      // user Address
extern NSString* const kUserInfoProvinceKey;     // user province
extern NSString* const kUserInfoCityKey;         // user city
extern NSString* const kUserInfoAgeKey;          // user Age
extern NSString* const kUserInfoBirthdayKey;     // user Birthday
extern NSString* const kUserInfoIconKey;         // user Icon
extern NSString* const kUserInfoPhoneKey;        // user Phone
extern NSString* const kUserInfoGenderKey;       // user Gender
extern NSString* const kUserInfoDeviceIdKey;     // user DeviceId

@interface AccountManager : BoxStorageModel

@property (nonatomic, retain) MUser *loginUser;

+ (AccountManager *)sharedManager;

/** 判断是否有账号已经登录 */
+ (BOOL) isLogin;

/** 判断当前登录账号是否曾经登过 **/
+ (BOOL) currentUserWasLogin;

/** 登出账号，删除当前账号信息，发账号已登出的通知 */
+ (void) logout;

@end
