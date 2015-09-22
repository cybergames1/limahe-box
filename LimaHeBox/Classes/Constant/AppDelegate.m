//
//  AppDelegate.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "BoxSideBarController.h"
#import "WeiXinManager.h"
#import "WeiboSDK.h"
#import "AccountManager.h"
#import "SettingManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册微信
    [WXApi registerApp:kWXSSO];
    
    //注册微博SDK
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    
    //初始化基本设置
    [SettingManager prepareApplication];
    
    if ([AccountManager isLogin]) {
        //注册系统通知
//        [BoxSideBarController unregisterForRemoteNotification];
//        [BoxSideBarController registerSystemRemoteNotification];
    }
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
    
    BoxSideBarController *root = [[[BoxSideBarController alloc] init] autorelease];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    NSLog(@"reciveLocalNotification");
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意！" message:@"你的箱子离你过远" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//    [alert show];
//    [alert release];
}

#pragma mark 处理URL，适用于第三方分享跳转
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([[url absoluteString] hasPrefix:kSinaWeiboSSO] ||
        [[url absoluteString] hasPrefix:kWXSSO] ||
        [[url absoluteString] hasPrefix:kWeiboSDKSSO])
    {
        return [SettingManager handleOpenURL:url];
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url absoluteString] hasPrefix:kSinaWeiboSSO] ||
        [[url absoluteString] hasPrefix:kWXSSO] ||
        [[url absoluteString] hasPrefix:kWeiboSDKSSO])
    {
        return [SettingManager handleOpenURL:url];
    }
    return NO;
}

@end
