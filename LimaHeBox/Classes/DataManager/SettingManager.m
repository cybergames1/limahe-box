//
//  SettingManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/22.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "SettingManager.h"
#import "Reachability.h"
#import "CommonTools.h"
#import "WeiXinManager.h"
#import "WeiboManager.h"
#import "SinaWeibo.h"
#import "UserDefaultConstant.h"

static Reachability* defaultReachability = nil;

@interface SettingManager ()

@property (nonatomic, retain) SinaWeibo * sinaOAuth;

@end

@implementation SettingManager

- (void)dealloc {
    self.sinaOAuth = nil;
    [super dealloc];
}

+ (SettingManager *)sharedManager
{
    static SettingManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SettingManager alloc] init];
    });
    return instance;
}

+ (BOOL)handleOpenURL:(NSURL *)openURL
{
    if ([[openURL absoluteString] hasPrefix:kSinaWeiboSSO])
    {
        return [[[SettingManager sharedManager] sinaOAuth] handleOpenURL:openURL];
    }
    else if ([[openURL absoluteString] hasPrefix:kWXSSO])
    {
        return [WXApi handleOpenURL:openURL delegate:[WeiXinManager sharedInstance]];
    }
    else if ([[openURL absoluteString] hasPrefix:kWeiboSDKSSO])
    {
        return [WeiboSDK handleOpenURL:openURL delegate:[WeiboManager sharedInstance]];
    }
    
    return NO;
}

@end

@implementation SettingManager (prepareAppData)

+ (void) prepareApplication
{
    //启动网络状态监听
    defaultReachability = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
    [defaultReachability startNotifier];
    
    //创建目录
    [CommonTools createDirectoryIfNecessaryAtPath:[CommonTools  pathForStorageClass]];
}

@end

@implementation SettingManager (Bluetooth)

- (void)setBthWarningFileName:(NSString *)bthWarningFileName {
    if ([CommonTools isEmptyString:bthWarningFileName]) {
        bthWarningFileName = @"HOOK1.WAV";
    }
    [[NSUserDefaults standardUserDefaults] setObject:bthWarningFileName forKey:Bluetooth_File_Name];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)bthWarningFileName {
    NSString *fileName = [[NSUserDefaults standardUserDefaults] objectForKey:Bluetooth_File_Name];
    if ([CommonTools isEmptyString:fileName]) {
        fileName = @"HOOK1.WAV";
    }
    return fileName;
}

- (void)setOpenVibration:(BOOL)openVibration {
    [[NSUserDefaults standardUserDefaults] setObject:@(openVibration) forKey:Bluetooth_OpenVibration];
}

- (BOOL)openVibration {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:Bluetooth_OpenVibration] boolValue];
}

@end