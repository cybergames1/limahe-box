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