//
//  CommonTools.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "CommonTools.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
//#import "MBProgressHUD.h"
#import <CommonCrypto/CommonCryptor.h>
#include <CommonCrypto/CommonHMAC.h>

static NSString *macAdress = nil;
static NSString *uniqueIdentifier = nil;
static NSDateFormatter * formatter = nil;
static UIWindow *statusbarBGView = nil;
static NSString* rootPath = nil;

// 磁盘空间不足报警常量设置
#define kMinDiskSpace 300*1024*1024.0 // 300MB
#define kAlertDiskSpace 450*1024*1024.0 // 450MB
@implementation CommonTools

#pragma mark strings

+ (BOOL)isEmptyString:(NSString *)string
{
    if (string == nil){
        return YES;
    }
    
    NSString* newString = [CommonTools stringValue:string];
    if (nil == newString) {
        NSLog(@"string:%@!!!!!!! \n\n\n",[string description]);
        return YES;
    }
    if ([newString length] == 0 || [newString isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

+ (NSString*) stringValue:(id) value
{
    if (nil == value) {
        return nil;
    }
    
    if ([value isEqual:[NSNull null]]) {
        return @"";
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]){
        return [value stringValue];
    }
    return nil;
}

+ (NSInteger) integerValue:(id) value
{
    if ([value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value integerValue];
    }
    return 0;
}

+ (NSString*) parseDictionary:(NSDictionary*)dictionary forKey:(NSString*)key
{
    if (NO == [dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    if ([CommonTools isEmptyString:key]) {
        return nil;
    }
    
    return [CommonTools stringValue:[dictionary valueForKey:key]];
}

#pragma mark 图片加载管理
//加载图片,默认格式为“png”
+ (UIImage *)imageNamed:(NSString *)name
{
    return [UIImage imageNamed:name];
}
//加载图片
+ (UIImage *)imageWithName:(NSString *)name type:(NSString *)type
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.%@",name,type]];
}

+ (UIImage *)noCacheableImageWithName:(NSString*) name
{
    NSString* fullPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:@"png"];
    return [UIImage imageWithContentsOfFile:fullPath];
}

+(UIImage *)createResizeImage:(UIImage *)img aspectFitSize:(CGSize)fitSize
{
    float actualHeight = img.size.height;
    float actualWidth = img.size.width;
    
    if(actualWidth==actualHeight)
    {
        actualWidth = fitSize.width;
        actualHeight = fitSize.height;
    }
    
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = fitSize.width/fitSize.height;
    
    
    if(imgRatio!=maxRatio)
    {
        if(imgRatio < maxRatio)
        {
            imgRatio = fitSize.height / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = fitSize.height;
        }
        else
        {
            imgRatio = fitSize.width / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = fitSize.width;
        }
    }
    else
    {
        actualWidth = fitSize.width;
        actualHeight = fitSize.height;
    }
    
    
    CGRect rect = CGRectMake(0, 0, (int)actualWidth, (int)actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [img drawInRect:rect];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

#pragma mark- 代理方法
+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


#pragma mark- window快捷获取
+ (UIWindow*) keyWindow
{
    AppDelegate* delegate = [CommonTools appDelegate];
    return delegate.window;
}

+ (UIWindow*) visibleWindow
{
    UIWindow* visibleView = nil;
    UIWindowLevel windowLevel = UIWindowLevelNormal;
    NSArray* windows = [[UIApplication sharedApplication] windows];
    for (UIWindow* window in windows) {
        if (window.windowLevel >= windowLevel &&
            CGRectGetHeight(window.bounds) > 400) {
            visibleView = window;
            windowLevel = window.windowLevel;
        }
    }
    
    return visibleView;
}

+ (UIViewController*) visibleController
{
//    PPQRootTabViewController* root = [CommonTools rootViewController];
//    UIViewController* controller = [root presentedViewController];
//    if (nil != controller) {
//        //如果当前present一个controller，返回该controller提示最后一个
//        if ([controller isKindOfClass:[UINavigationController class]]) {
//            return [(UINavigationController*)controller visibleViewController];
//        }
//    }
//    
//    controller = [root selectedViewController];
//    if (nil != controller) {
//        if ([controller isKindOfClass:[UINavigationController class]]) {
//            return [(UINavigationController*)controller visibleViewController];
//        }
//    }
    return nil;
}

+ (void) setStatusBarStyle:(PPQStatusBarType)style
{
    if ([CommonTools isSystemVertionLowIOS7])
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    else
    {
        if (style == PPQStatusBarDarkContent)
        {
            statusbarBGView.hidden = YES;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
        else if (style == PPQStatusBarLightContent)
        {
            statusbarBGView.hidden = YES;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
        else if (style == PPQStatusBarDarkContentWithLightBG)
        {
            if (!statusbarBGView)
            {
                statusbarBGView = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 20.0f)];
                statusbarBGView.windowLevel = UIWindowLevelStatusBar - 1;
            }
            statusbarBGView.hidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            statusbarBGView.backgroundColor = [UIColor whiteColor];
            [[CommonTools visibleWindow] bringSubviewToFront:statusbarBGView];
        }
        else if (style == PPQStatusBarLightContentWithDarkBG)
        {
            if (!statusbarBGView)
            {
                statusbarBGView = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 20.0f)];
                statusbarBGView.windowLevel = UIWindowLevelStatusBar - 1;
            }
            statusbarBGView.hidden = NO;
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            statusbarBGView.backgroundColor = [UIColor blackColor];
            [[CommonTools visibleWindow] bringSubviewToFront:statusbarBGView];
        }
    }
}

+ (void) setStatusBarHidden:(BOOL)hidden
{
    [UIApplication sharedApplication].statusBarHidden = hidden;
}

/** 既有导航栏，又有tabBar **/
+ (CGFloat) viewHeightWithNavAndTab
{
    return KScreenHeight - 64.0f - KDefaultTabBarHeight;
}

/** 只有导航栏，没有tabbar **/
+ (CGFloat) viewHeightWithNav
{
    return KScreenHeight - 64.0f;
}

+ (CGFloat) viewTopWithNav
{
    return [CommonTools defaultNavigationBarHeight];
}

/** 只有tabbar，没有导航栏，状态栏是否上浮(在ios6中无效果)**/
+ (CGFloat) viewHeightWithTabWithStatusBarFloat:(BOOL)bFloat
{
    if ([CommonTools isSystemVertionLowIOS7])
    {
        return KScreenHeight - KDefaultTabBarHeight - kStatusBarHeight;
    }
    else
    {
        if (bFloat)
        {
            return KScreenHeight - KDefaultTabBarHeight;
        }
        else
        {
            return KScreenHeight - KDefaultTabBarHeight - kStatusBarHeight;
        }
    }
}

/** 全屏 **/
+(CGFloat) viewHeightFullWithTabWithStatusBarFloat:(BOOL)bFloat
{
    if ([CommonTools isSystemVertionLowIOS7])
    {
        return KScreenHeight - kStatusBarHeight;
    }
    else
    {
        if (bFloat)
        {
            return KScreenHeight;
        }
        else
        {
            return KScreenHeight - kStatusBarHeight;
        }
    }
}

+ (CGFloat) defaultNavigationBarHeight
{
    if ([CommonTools isSystemVertionLowIOS7] || [UIApplication sharedApplication].statusBarHidden)
    {
        return 44.0f;
    }
    else
    {
        return 64.0f;
    }
}


#pragma mark replaceDictionaryValue

+ (void)replaceDictionaryValue:(NSMutableDictionary*)dict value:(id)value forKey:(id)key
{
	[dict removeObjectForKey:key];
	[dict setObject:value forKey:key];
}

#pragma mark- 隐私,设备信息
+ (NSString*)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (NSString *)macAdress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)ipAdress
{
    NSString *localIP = nil;
    struct ifaddrs *addrs;
    if (getifaddrs(&addrs)==0) {
        const struct ifaddrs *cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                //NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                //if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                {
                    localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
                    break;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return localIP;
}

+ (NSString *)md5StringWithString:(NSString *)String;
{
    if ([CommonTools isEmptyString:String])
    {
        return nil;
    }
    
    const char *value = [String UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString autorelease];
}

+ (NSString *) uniqueGlobalDeviceIdentifier
{
    if ([CommonTools isEmptyString:macAdress])
    {
        macAdress = [[CommonTools macAdress] retain];
        if ([CommonTools isEmptyString:macAdress])
        {
            macAdress = @"";
        }
    }
    if ([CommonTools isEmptyString:uniqueIdentifier])
    {
        uniqueIdentifier = [[CommonTools md5StringWithString:macAdress] retain];
    }
    return uniqueIdentifier;
}

+ (NSString *) currentVersionString
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_build;
}

+ (NSString*) deviceHardwareStr
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    char *p = machine;
    for (size_t i = 0; i < size; i++)
    {
        if (*p == ',')
        {
            *p = '_';
        }
        p++;
    }
    NSString *_hardWareString = [[NSString alloc] initWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return  [_hardWareString autorelease];
}

+ (NSString *)getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char *answer = malloc(size);
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	free(answer);
	return results;
}

+ (NSString *)platform
{
	return [CommonTools getSysInfoByName:"hw.machine"];
}

+ (NSString *)platformType
{
	NSString *platform = [CommonTools platform];
    if ([platform hasPrefix:@"iPhone3"])			return @"iPhone4";
	if ([platform hasPrefix:@"iPhone4"])			return @"iPhone4s";
	if ([platform hasPrefix:@"iPhone5"])			return @"iPhone5";
    if ([platform hasPrefix:@"iPhone2"])	        return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone1,2"])	return @"iPhone3G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad1";
	if ([platform isEqualToString:@"iPad2,1"])      return @"iPad2";
    if ([platform hasPrefix:@"iPad2"])              return @"iPad3";
    if ([platform hasPrefix:@"iPad3"])              return @"iPad4";
	if ([platform hasPrefix:@"iPad4"])              return @"iPad5";
    
	if ([platform isEqualToString:@"iPod4,1"])      return @"iPod4";
	if ([platform isEqualToString:@"iPod5,1"])      return @"iPod5";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod3";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod1";
	if ([platform isEqualToString:@"iPod2,1"])      return @"iPod2";
	if ([platform isEqualToString:@"iPhone1,1"])	return @"iPhone1";
	return @"iPhone";
}

+ (BOOL) lowLeverHardwareDevice
{
    NSString* hardware = [CommonTools platform];
    if ([hardware hasPrefix:@"iPhone"] &&
        NSOrderedAscending == [hardware compare:@"iPhone5" options:NSNumericSearch]) {
        if ([hardware isEqualToString:@"iPhone4s"]) {
            return NO;
        }
        return YES;
    }
    if ([hardware hasPrefix:@"iPod"] &&
        NSOrderedAscending == [hardware compare:@"iPod5" options:NSNumericSearch]) {
        return YES;
    }
    
    if ([hardware hasPrefix:@"iPad"] &&
        NSOrderedAscending == [hardware compare:@"iPad3" options:NSNumericSearch]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isSystemVertionLowIOS7
{
    if (NSOrderedAscending == [[CommonTools systemVersion] compare:@"7.0" options:NSNumericSearch]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isSystemVertionLowIOS8
{
    if (NSOrderedAscending == [[CommonTools systemVersion] compare:@"8.0" options:NSNumericSearch]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isCurrentSoftWareVersionLowerTheVersion:(NSString *)version
{
    if ([[CommonTools currentVersionString] compare:version options:NSNumericSearch] == NSOrderedAscending)
    {
		return YES;
	}
	return NO;
}
#pragma mark- 磁盘空间
// 总磁盘空间
+ (NSNumber *) diskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

// 已用磁盘空间
+ (NSNumber *) usedDiskSpace
{
    return [NSNumber numberWithUnsignedLongLong:[[CommonTools diskSpace] unsignedLongLongValue] - [[CommonTools freeDiskSpace] unsignedLongLongValue]];
}

// 可用磁盘空间
+ (NSNumber *) freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];    
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (BOOL) enoughDiskSpaceToUse
{
    if ([[CommonTools freeDiskSpace] unsignedLongLongValue] > kMinDiskSpace) {
        return YES;
    }
    return NO;
}

+ (BOOL) needAlertDiskSpace
{
    if ([[CommonTools freeDiskSpace] unsignedLongLongValue] < kAlertDiskSpace) {
        return YES;
    }
    return NO;
}

#pragma mark 文件操作

+ (BOOL)removePathAt:(NSString *)path
{
	BOOL succeeded = YES;
    
    //文件不存在，返回成功
    if (![self fileIfExist:path])
    {
        return YES;
    }
    
	succeeded = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
	return succeeded;
}

+ (BOOL)fileIfExist:(NSString *)filePath
{
    BOOL rtn = YES;
    if([CommonTools isEmptyString:filePath])
    {
        return NO;
    }
    
    NSFileManager *file_manager = [NSFileManager defaultManager];
    rtn =  [file_manager fileExistsAtPath:filePath];
    return rtn;
}

+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path
{
    if ([path isEqualToString:EMPTY_STRING])
    {
        return NO;
    }
    
	BOOL succeeded = YES;
	if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
		NSError *err = nil;
		succeeded = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
		if (!succeeded)
        {
			return NO;
		}
	}
	return succeeded;
}

+ (long long)fileSize:(NSString *)filePath
{
    NSFileManager *file_manager = [NSFileManager defaultManager];
    if ([file_manager fileExistsAtPath:filePath])
    {
        NSDictionary * attributes = [file_manager attributesOfItemAtPath:filePath error:nil];
        // file size
        NSNumber *theFileSize;
        theFileSize = [attributes objectForKey:NSFileSize];
        if (theFileSize)
        {
            return [theFileSize longLongValue];
        }
    }
    return 0;
}

+ (NSString *) changeFileURL:(NSURL *)url;
{
    if ([url isFileURL])
    {
        NSString *string = [url absoluteString];
        NSString *s = [string substringFromIndex:16];
        NSString *subString = @"/private";
        subString = [subString stringByAppendingString:s];
        return subString;
    }
    return [url absoluteString];
}

#pragma mark 缓存路径

//文件根目录
+ (NSString *)pathForApplicationRoot
{
    if ([rootPath length] > 0) {
        return rootPath;
    }
    //用Library,作为自定义根目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,  NSUserDomainMask, YES);
	if ([paths count] > 0)
    {
        rootPath = [[NSString alloc] initWithFormat:@"%@",[paths objectAtIndex:0]];
	}
	return rootPath;
}

+ (NSString *)pathForCachedTickers
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"APICachedTickers"];
    return root;
}

//图片缓存路径
+ (NSString *)pathForCacheImages
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQCachesImages"];
    return root;
}

//音乐缓存路径
+ (NSString *)pathForCacheMusics
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQCacheMusics"];
    return root;
}

//GlobleSetting所在的目录
+ (NSString *)pathForCacheSetting
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQGlobleSetting"];
    return root;
}

//CrashLog所在的目录
+ (NSString *)pathForCrashLogs
{
    //用Library,作为自定义根目录
    NSString *root = [CommonTools pathForApplicationRoot];
    return [root stringByAppendingPathComponent:@"PPQCrashLogs"];
}
//临时文件夹,用于存放需要上传的视频及选取的封面
+ (NSString *) pathForTemp
{
//    if (![[PPQSettingManager sharedManager] isLogin])
//    {
//        NSString *path = [CommonTools pathForApplicationRoot];
//        path = [path stringByAppendingPathComponent:@"PPQGlobleTempFile"];
//        return path;
//    }
//    NSString *path = [CommonTools pathForAdminUsers];
//    path = [path stringByAppendingPathComponent:[PPQSettingManager sharedManager].userHistory.currentUser.userId];
//    path = [path stringByAppendingPathComponent:@"PPQUserTempFile"];
    NSString *path = [CommonTools pathForApplicationRoot];
    path = [path stringByAppendingPathComponent:@"PPQGlobleTempFile"];
    return path;
}

/** 用户信息总存储位置 **/
+ (NSString *)pathForAdminUsers
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQAdminUsers"];
    return root;
}
/** 用户登录历史 **/
+ (NSString *)pathForUserHistoryList
{
    NSString *path = [CommonTools pathForAdminUsers];
    path = [path stringByAppendingPathComponent:@"PPQUserHistory"];
    return path;
}



+ (NSString *)pathForGlobleJsonCache
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQGlobleJsonCache"];
    return root;
}





/** 本地视频的缩略图地址（本地视频界面能加载出的所有视频的缩略图） **/
+ (NSString *)pathForAlbumThumb
{
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"PPQLocalAlbumThumb"];
    return root;
}

//+ (NSString *)pathForUserAlbumThumb
//{
//    NSString *path = [CommonTools pathForUploadingHistory];
//    
//    if (!path)
//    {
//        path = [CommonTools pathForAlbumThumb];
//    }
//    
//    path = [path stringByAppendingPathComponent:@"PPQVideoThumb"];
//    return path;
//}


//+ (NSString *)pathForUploadingHistoryThumb
//{
//    NSString *path = [CommonTools pathForUploadingHistory];
//    path = [path stringByAppendingPathComponent:@"PPQVideoThumb"];
//    return path;
//}


+ (NSString *)pathForTempMovie
{
    NSString *root = NSTemporaryDirectory();
    return root;
}

//-------------------------------------------------
+ (NSString *)pathForStorageUser {
    NSString *root = [CommonTools pathForApplicationRoot];
    root = [root stringByAppendingPathComponent:@"StorageUser"];
    return root;
}

+ (void)postNotificationName:(NSString *)name
                      object:(id)object
                    userInfo:(NSDictionary *)dic
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:dic];
}

+ (void)addNotificationObsever:(id)observe
                        action:(SEL)sel
                          name:(NSString *)name
                        object:(id)object
{
    [[NSNotificationCenter defaultCenter] addObserver:observe selector:sel name:name object:object];
}


+ (void) scheduleLocalNotification:(NSString*)msg
                        withAction:(NSString*) action
                          userInfo:(NSDictionary*) userInfo
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification != nil) {
        notification.repeatInterval = 0;//不循环
        notification.timeZone = [NSTimeZone defaultTimeZone];
        
        notification.alertBody = msg;//提示信息 弹出提示框
        notification.alertAction = action;  //提示框按钮
        notification.hasAction = NO;
        notification.userInfo = userInfo;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    [notification release];
}

#pragma mark 为视频时长格式化时间
/*
 一小时内    00:01、45:59
 超过一小时   01:00:00、04:31:12
 */
+ (NSString *) formateDuration:(id) durationValue
{
    CGFloat duration = 0;
    if ([durationValue isKindOfClass:[NSNumber class]] ||
        [durationValue isKindOfClass:[NSString class]]) {
        duration = [durationValue floatValue];
    }
    // 时间做进位转换，四舍五入，大于0.5秒不足1秒按1秒计
    NSInteger _newDuration = (int)(duration + 0.5);
    if (duration <= 0)
    {
        return @"00:00";
    }
    NSInteger hour = _newDuration/Q_HOUR;
    NSInteger minute = (_newDuration%((int)Q_HOUR))/Q_MINUTE;
    NSInteger secont = _newDuration%((int)Q_MINUTE);
    
    hour = (hour >= 99)?99:hour;
    if (hour > 0) {
        return [NSString stringWithFormat:@"%@:%@:%@",[CommonTools formatNumber:hour],[CommonTools formatNumber:minute],[CommonTools formatNumber:secont]];
    }
    return [NSString stringWithFormat:@"%@:%@",[CommonTools formatNumber:minute],[CommonTools formatNumber:secont]];
}

+ (NSString *) formatNumber:(NSInteger) number
{
    if (number < 10) {
        return [NSString stringWithFormat:@"0%ld",(long)number];
    }
    
    return [NSString stringWithFormat:@"%ld",(long)number];
}

#define kBillion     1000000000 // 10亿
#define kHudMillion  100000000  // 1亿
#define kTenMillion  10000000   // 1千万
#define kMillion     1000000    // 100万
#define kTenMyriad   100000     // 10万
#define kMyriad      10000      // 1万
#define kThousand    1000       // 1千
/*
 0 ~ 9,999   正常显示
 10,000 ~ 10,999 1.0万
 11,000 ~ 99,999 x.y万(1≤x,y≤9)
 100,000 ~ 109,999 10万
 110,000 ~ 999,999 xy万(1≤x,y≤9)
 1,000,000 ~ 109,999 100万
 ...   ...
 ...   1000万
 ...   1.0亿
 ...   10亿  
 */
+ (NSString*) playCount:(id) countValue
{
    NSInteger count = [CommonTools integerValue:countValue];
    if (count < kMyriad) {
        // <1万，显示 ***个
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
    if (count < kTenMyriad){
        //1万~10万
        return [NSString stringWithFormat:@"%ld.%ld万",(long)(count/kMyriad),(long)((count % kMyriad)/kThousand)];
    }
    if (count < kHudMillion){
        //10万~1亿
        return [NSString stringWithFormat:@"%ld万",(long)(count/kMyriad)];
    }
    if (count < kBillion){
        //1亿~10亿
        return [NSString stringWithFormat:@"%ld.%ld亿",(long)(count/kHudMillion),(long)((count % kHudMillion)/kTenMillion)];
    }
    return [NSString stringWithFormat:@"%ld亿",(long)(count/kHudMillion)];;
}

/*
 1-99    正常显示
 超过99  显示99+
 */
+ (NSString*) messageCount:(id) countValue
{
    NSInteger count = 0;
    if ([countValue isKindOfClass:[NSNumber class]] ||
        [countValue isKindOfClass:[NSString class]]) {
        count = [countValue integerValue];
    }
    if (count <= 99) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
    return @"99+";
}

/*
 1-10秒内: 刚刚
 11-60秒: n秒前
 1-60分钟: n分钟前,秒舍弃,⽐比如 5分35秒前,显⽰示为 5分钟之前
 1-2⼩小时: 1⼩小时前,如果跨天了,按“昨天”显⽰示
 ≥2⼩小时: n⼩小时前,24⼩小时制
 昨天: 昨天
 前天: 前天
 3-6天: n天前
 7-13天: 1周前
 14-20天: 2周前
 21-30天: 半个月前
 1-5个月: n个月前
 ≥6个月: 半年前
 跨年: 1年前;2年前...
 */
+ (NSString*) formateDate:(id) aDate
{
    if (aDate == nil) {
        return nil;
    }
    NSDate* somedayDate = nil;
    if ([aDate isKindOfClass:[NSDate class]]) {
        somedayDate = (NSDate*)aDate;
    }
    else if([aDate isKindOfClass:[NSString class]]){
        somedayDate = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    }
    else if([aDate isKindOfClass:[NSNumber class]]){
        somedayDate = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    }
    else{
        return nil;
    }
    CGFloat timeInterval = fabs([somedayDate timeIntervalSinceNow]);
    if (timeInterval <= 10) {
        // 1-10秒内,刚刚
        return @"刚刚";
    }
    else if (timeInterval < Q_MINUTE){
        // 11-60秒,n秒前
        return [NSString stringWithFormat:@"%ld秒前",(long)timeInterval];
    }
    else if (timeInterval < Q_HOUR){
        // 1-60分钟 n分钟前
        return [NSString stringWithFormat:@"%ld分钟前",(long)(timeInterval/Q_MINUTE)];
    }
    else if (timeInterval < Q_DAY){
        //1⼩时前、n小时前
        return [NSString stringWithFormat:@"%ld小时前",(long)(timeInterval/Q_HOUR)];
    }
    else if (timeInterval < Q_DAY*2){
        //昨天、
        return @"昨天";
    }
    else if (timeInterval < Q_DAY*3){
        //前天
        return @"前天";
    }
    else if (timeInterval < Q_DAY*6){
        //3-6天 n天前
        return [NSString stringWithFormat:@"%ld天前",(long)(timeInterval/Q_DAY)];
    }
    else if (timeInterval < Q_DAY*13){
        //7-13天: 1周前
        return @"1周前";
    }
    else if (timeInterval < Q_DAY*20){
        //14-20天: 2周前
        return @"2周前";
    }
    else if (timeInterval < Q_MONTH){
        //21-30天: 半个月前
        return @"半个月前";
    }
    else if (timeInterval < Q_MONTH*6){
        //1-5个月: n个月前
        return [NSString stringWithFormat:@"%ld个月前",(long)(timeInterval/Q_MONTH)];
    }
    else if (timeInterval < Q_YEAR){
        //≥6个月: 半年前
        return @"半年前";
    }
    else{
        // 跨年: 1年前;2年前...
        return [NSString stringWithFormat:@"%ld年前",(long)(timeInterval/Q_YEAR)];
    }
    return nil;
}

/*
 往年视频显示年、月、日、时间,如2012年8月9日 11:39
 当年视频显示月、日、时间,如8月9日 11:39
 */
+ (NSString*) formatPublishDate:(id) aDate
{
    if (aDate == nil) {
        return nil;
    }
    NSDate* somedayDate = nil;
    if ([aDate isKindOfClass:[NSDate class]]) {
        somedayDate = (NSDate*)aDate;
    }
    else if([aDate isKindOfClass:[NSString class]]){
        somedayDate = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    }
    else if([aDate isKindOfClass:[NSNumber class]]){
        somedayDate = [NSDate dateWithTimeIntervalSince1970:[aDate integerValue]];
    }
    else{
        return nil;
    }
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents* day_ = [cal components:NSYearCalendarUnit
                                    fromDate:somedayDate];
    NSDateComponents* today_ = [cal components:NSYearCalendarUnit
                                      fromDate:[NSDate date]];
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
    }
    if (day_.year < today_.year)
    {
        [formatter setDateFormat:@"YYYY年M月d日 HH:mm"];
        return [formatter stringFromDate:somedayDate];
    }
    else{
        [formatter setDateFormat:@"M月d日 HH:mm"];
        return [formatter stringFromDate:somedayDate];
    }
    return nil;
}

+ (NSString*) formateDateValue:(NSDate*)date
                     withStyle:(NSString*)style
{
    if (NO == [date isKindOfClass:[NSDate class]]) {
        return nil;
    }
    if ([CommonTools isEmptyString:style]) {
        return nil;
    }
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:style];
    return [formatter stringFromDate:date];
}


#pragma mark Show HUBView / Alert
//+ (void) showHunViewWithTitle:(NSString*) title
//{
//    [MBProgressHUD hideAllHUDsForView:[CommonTools visibleWindow] animated:NO];
//    MBProgressHUD* hub = [MBProgressHUD showHUDAddedTo:[CommonTools visibleWindow] animated:YES];
//    hub.removeFromSuperViewOnHide = YES;
//    hub.mode = MBProgressHUDModeText;
//    hub.labelText = title;
//    [hub hide:YES afterDelay:2.0];
//}

+ (void) showAlertWithTitle:(NSString*)title
{
    UIAlertView* _showAlert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [_showAlert show];
    [_showAlert autorelease];
}

#pragma mark - Only for test
+(NSDictionary *)dictionaryFromMainBundleFile:(NSString *)file ofType:(NSString *)type
{
    NSString *path=[[NSBundle mainBundle] pathForResource:file ofType:type];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    NSDictionary *fileDictionary = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:nil];
    return fileDictionary;
}


+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text
{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t cHMAC[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    hash = output;
    
    return hash;
}


+ (NSString *)stringValueForFloat:(CGFloat)num
{
    NSString *str = nil;
    
    if (num >= 1.0)
    {
        str = [NSString stringWithFormat:@"%.2f",num];
    }
    else if (num < 1.0 && num >= 0.01)
    {
        str = [NSString stringWithFormat:@"%.3f",num];
    }
    else if (num < 0.01 && num >= 0.001)
    {
        str = [NSString stringWithFormat:@"%.4f",num];
    }
    else if (num < 0.001 && num >= 0.0001)
    {
        str = [NSString stringWithFormat:@"%.5f",num];
    }
    else if (num < 0.0001 && num >= 0.00001)
    {
        str = [NSString stringWithFormat:@"%.7f",num];
    }
    else
    {
        str = [NSString stringWithFormat:@"%.8f",num];
    }
    
    return str;
}
@end



