//
//  AccountManager.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AccountManager.h"
#import "UserDefaultConstant.h"

@interface MUser ()

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userIcon;
@property (nonatomic,copy) NSString *userPhone;

@end

@implementation MUser

- (void)dealloc {
    self.userName = nil;
    self.userIcon = nil;
    self.userPhone = nil;
    [super dealloc];
}

@end

@implementation AccountManager

+ (AccountManager *)sharedManager
{
    static AccountManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AccountManager alloc] init];
    });
    return instance;
}

+ (BOOL) isLogin
{
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    if (loginUser) {
        return YES;
    }
    return NO;
}

//核查一遍现在的登录用户是否曾经在这个机器上登过
+ (BOOL)currentUserWasLogin {
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    BOOL userWasLogin = NO;
    
    NSMutableArray *userList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:Login_UserList]];
    for (NSString *userId in userList) {
        if ([userId isEqualToString:loginUser.userId]) {userWasLogin = YES;break;}
    }
    if (!userWasLogin) {
        [userList addObject:loginUser.userId];
        [[NSUserDefaults standardUserDefaults] setObject:userList forKey:Login_UserList];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return userWasLogin;
}

+ (void) logout
{
    [AccountManager sharedManager].loginUser = nil;
}


@end
