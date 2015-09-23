//
//  BoxSideBarController.h
//  LimaHeBox
//
//  Created by jianting on 15/8/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxSideBarController : UITabBarController

- (void)showSideBar;

//登出都要回到首页
+ (void)logout;

/** 注册系统通知 **/
+ (void)registerSystemRemoteNotification;
/** 注销系统通知 **/
+ (void)unregisterForRemoteNotification;

@end
