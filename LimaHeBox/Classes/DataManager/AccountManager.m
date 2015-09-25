//
//  AccountManager.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AccountManager.h"
#import "BoxSideBarController.h"
#import "DeviceManager.h"

@interface MUser ()

@property (nonatomic,copy) NSString *userAuthToken;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userIcon;
@property (nonatomic,copy) NSString *userPhone;
@property (nonatomic,copy) NSString *userAge;
@property (nonatomic,copy) NSString *userCity;
@property (nonatomic,copy) NSString *userGender;
@property (nonatomic,copy) NSString *userAddress;
@property (nonatomic,copy) NSString *userDeviceId;

@end

@implementation MUser

- (void)dealloc {
    self.userAuthToken = nil;
    self.userName = nil;
    self.userIcon = nil;
    self.userPhone = nil;
    self.userId = nil;
    self.userAge = nil;
    self.userCity = nil;
    self.userGender = nil;
    self.userAddress = nil;
    self.userDeviceId = nil;
    [super dealloc];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSString *)userIcon {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[_userIcon lastPathComponent]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.userAuthToken = [dictionary objectForKey:@"token"];
        self.userId = [dictionary objectForKey:@"userid"];
        self.userName = [dictionary objectForKey:@"username"];
        self.userGender = [dictionary objectForKey:@"sex"];
        self.userPhone = [dictionary objectForKey:@"mobile"];
        self.userCity = [dictionary objectForKey:@"city"];
        self.userAge = [dictionary objectForKey:@"age"];
        self.userAddress = [dictionary objectForKey:@"address"];
        self.userIcon = [[NSBundle mainBundle] pathForResource:@"pf_logo1@2x" ofType:@"png"];
        self.userDeviceId = [dictionary objectForKey:@"toolsn"];
    }
    return self;
}

@end

@implementation MUser (UpdateData)

- (void) updateUserValue:(id) value forKey:(NSString*) key
{
    if (nil == value || nil == key) {
        return;
    }
    if ([kUserInfoNameKey isEqualToString:key]) {
        //userName
        self.userName = value;
    }else if ([kUserInfoIconKey isEqualToString:key]) {
        //userIcon
        self.userIcon = value;
    }else if ([kUserInfoPhoneKey isEqualToString:key]) {
        //userPhoneNumber
        self.userPhone = value;
    }else if ([kUserInfoGenderKey isEqualToString:key]) {
        //userGender
        self.userGender = value;
    }else if ([kUserInfoAgeKey isEqualToString:key]) {
        //userAge
        self.userAge = value;
    }else if ([kUserInfoCityKey isEqualToString:key]) {
        //userCity
        self.userCity = value;
    }else if ([kUserInfoAddressKey isEqualToString:key]) {
        //userAddress
        self.userAddress = value;
    }else if ([kUserInfoDeviceIdKey isEqualToString:key]) {
        //userAddress
        self.userDeviceId = value;
    }else if ([kUserInfoAuthKey isEqualToString:key]) {
        //userAuthToken
        self.userAuthToken = value;
    }else {
        //
    }
    
    [[AccountManager sharedManager] saveStorage];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoDidUpdateNotification object:nil];
}

@end

NSString* const  kUserInfoAuthKey = @"_authcookie";
NSString* const  kUserInfoOPTokenKey = @"_openAPIAccessToken";
NSString* const  kUserInfoNameKey = @"_userName";
NSString* const  kUserInfoIntroductionKey = @"_userIntroduction";
NSString* const  kUserInfoAddressKey = @"_userAddress";
NSString* const  kUserInfoProvinceKey = @"_userProvince";
NSString* const  kUserInfoCityKey = @"_userCity";
NSString* const  kUserInfoAgeKey = @"_userAge";
NSString* const  kUserInfoBirthdayKey = @"_userBirthday";
NSString* const  kUserInfoIconKey = @"_userIcon";
NSString* const  kUserInfoPhoneKey = @"_userPhone";
NSString* const  kUserInfoGenderKey = @"_userGender";
NSString* const  kUserInfoDeviceIdKey = @"_userDeivceId";

@implementation AccountManager

+ (AccountManager *)sharedManager
{
    static AccountManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AccountManager storageModel] retain];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(userDidChange:) name:kUserDidChangedNotification object:nil];
    });
    return instance;
}

- (void)userDidChange:(NSNotification *)notification {
    if ([[self class] isLogin]) {
        //[BoxSideBarController registerSystemRemoteNotification];
    }
}

+ (MUser *)testUser {
    MUser *user = [[MUser alloc] init];
    user.userIcon = [[NSBundle mainBundle] pathForResource:@"pf_logo1@2x" ofType:@"png"];
    user.userName = @"张三";
    user.userPhone = @"13802318211";
    return [user autorelease];
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
    [BoxSideBarController unregisterForRemoteNotification];
    [BoxSideBarController logout];
    [AccountManager sharedManager].loginUser = nil;
    [[AccountManager sharedManager] deleteStorage];
    [DeviceManager sharedManager].currentDevice = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserDidLogOutNotification object:nil];
}


@end
