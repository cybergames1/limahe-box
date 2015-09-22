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

static Reachability* defaultReachability = nil;

@implementation SettingManager

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