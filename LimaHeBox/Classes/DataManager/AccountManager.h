//
//  AccountManager.h
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUser : NSObject

@property (nonatomic,copy,readonly) NSString *userId;
@property (nonatomic,copy,readonly) NSString *userName;
@property (nonatomic,copy,readonly) NSString *userIcon;
@property (nonatomic,copy,readonly) NSString *userPhone;

@end

@interface AccountManager : NSObject

@property (nonatomic, retain) MUser *loginUser;

+ (AccountManager *)sharedManager;

/** 判断是否有账号已经登录 */
+ (BOOL) isLogin;

/** 判断当前登录账号是否曾经登过 **/
+ (BOOL) currentUserWasLogin;

/** 登出账号，删除当前账号信息，发账号已登出的通知 */
+ (void) logout;

@end
