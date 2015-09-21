//
//  LRDataSource.h
//  LimaHeBox
//
//  Created by jianting on 15/8/15.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PPQDataSource.h"

@interface LRDataSource : PPQDataSource

/** 登录 **/
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password;

/** 注册 **/
- (void)registerWithUserName:(NSString *)userName
                    password:(NSString *)password
                       phone:(NSString *)phone;

/** 修改密码 **/
- (void)updatePwdWithUserName:(NSString *)userName
                       oldpwd:(NSString *)oldpwd
                       newpwd:(NSString *)newpwd;

/** 更新个人信息 **/
- (void)updateInfoWithGender:(NSString *)gender
                         age:(NSString *)age
                     address:(NSString *)address
                        city:(NSString *)city
                    deviceId:(NSString *)deviceId;

@end
