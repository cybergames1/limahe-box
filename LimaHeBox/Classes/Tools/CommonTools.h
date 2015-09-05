//
//  CommonTools.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 
    // common Tools
    // 包含了最常用的Tools方法，不要随意向里面添加方法，应该从其他Tools中向这里面抽象
 
 
 **/

typedef NS_ENUM(NSInteger, PPQStatusBarType)
{
    /** 下面两个，状态栏浮在内容上面，所以布局的时候不用考虑状态栏的高度 **/
    /** 不带有黑色背景，文字是白色 **/
    PPQStatusBarLightContent,
    /** 不带有白色背景，文字是黑色 **/
    PPQStatusBarDarkContent,
    
    /** 同上两个，只不过带有背景 一般来讲，如果用了一下两个，那么布局的时候应该去掉状态栏的高度 **/
    PPQStatusBarLightContentWithDarkBG,
    PPQStatusBarDarkContentWithLightBG
};

/*
 UI 导航栏+Tabbar+状态栏的高度
 */

/** tabbar的真实高度 **/
#define KDefaultTabBarRealHeight 75.0f
/** tabbar的去掉上面弧顶后的高度 **/
#define KDefaultTabBarHeight 50.0f
#define kStatusBarHeight 20

/*
 屏幕的宽、高尺寸
 */
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define EMPTY_STRING @""

#pragma mark- 定义时间
/*
 定义时间
 */
#define Q_MINUTE    60.0f       //1分钟
#define Q_HOUR      3600.0      //1小时
#define Q_DAY       86400.0     //1天
#define Q_WORKDAY   432000.0    //5天
#define Q_WEEK      604800.0    //1周
#define Q_MONTH     (30.5 * Q_DAY)
#define Q_YEAR      (365 * Q_DAY)
#define Q_NSEC_PER_SEC 1000000000ull

#define Q_Record_Delay_Time 0.5
#define Q_Montage_Max_Record_Time 7.0f
#define Q_Record_Max_Time 6 * Q_MINUTE
#define degreesToRadians(x) (M_PI * (x) / 180.0)

#define CachedTickersPath @"CachedTickers"

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

@class AppDelegate;
@class PPQRootTabViewController;

@interface CommonTools : NSObject

#pragma mark strings
//判断是否为空字符串
+ (BOOL)isEmptyString:(NSString *)string;

//返回字符串数据
+ (NSString*) stringValue:(id) value;
//返回integer整数
+ (NSInteger) integerValue:(id) value;

/**
 按照指定的key解析字典
 @return 如果dictionary或者key非法，返回nil。返回对应的value
 */
+ (NSString*) parseDictionary:(NSDictionary*)dictionary
                       forKey:(NSString*)key;

#pragma mark 图片加载管理
//加载图片,默认格式为“png”
+ (UIImage *)imageNamed:(NSString *)name;
//加载图片
+ (UIImage *)imageWithName:(NSString *)name type:(NSString *)type;

//该方法返回的图片不会系统cache,格式为png
+ (UIImage *)noCacheableImageWithName:(NSString*) name;
+(UIImage *)createResizeImage:(UIImage *)img aspectFitSize:(CGSize)fitSize;
#pragma mark- 代理方法
//获取代理对象
+ (AppDelegate *)appDelegate;

// rootViewController
+ (PPQRootTabViewController*) rootViewController;

#pragma mark- window快捷获取
/**
 得到当前的keyWindow,也即AppDelegate创建的Window
 说明：该Window排除UIAlert、UIActionSheet、UIStatusBar、
 键盘UIKeyBoard这一类的window
 用途：用于显示提示框（MBProgressHub）
 */
+ (UIWindow*) keyWindow;

/**
 最上层window
 说明：包括mainWindow、键盘UIKeyBoard、UIAlert、UIActionSheet，
 但排除UIStatusBar等高度不足400的Window
 用途：用于显示提示框（MBProgressHub）
 */
+ (UIWindow*) visibleWindow;

/**
 获取当前显示的controller
 @return 返回该controller。nil如果当前显示的不是一个controller
 */
+ (UIViewController*) visibleController;
#pragma mark 设置状态栏

/**
 做了 ios6 和 ios7 的适配，
 在ios6中 lightContent不适用，转换成黑色不透明
 
 **/
+ (void) setStatusBarStyle:(PPQStatusBarType)style;

/**
 隐藏状态栏
 
 **/
+ (void) setStatusBarHidden:(BOOL)hidden;

#pragma mark 各种类型页面的view的高度

/** 既有导航栏，又有tabBar **/
+ (CGFloat) viewHeightWithNavAndTab;


/** 只有导航栏，没有tabbar **/
+ (CGFloat) viewHeightWithNav;
/** view的y值 **/
+ (CGFloat) viewTopWithNav;

/** 只有tabbar，没有导航栏 **/
+ (CGFloat) viewHeightWithTabWithStatusBarFloat:(BOOL)bFloat;

/** 全屏 **/
+ (CGFloat) viewHeightFullWithTabWithStatusBarFloat:(BOOL)bFloat;

/** 导航栏高度 **/
+ (CGFloat) defaultNavigationBarHeight;




#pragma mark replaceDictionaryValue
+ (void)replaceDictionaryValue:(NSMutableDictionary*)dict value:(id)value forKey:(id)key;

#pragma mark- 隐私,设备信息
//客户端系统版本
+ (NSString*)systemVersion;
//手机型号
+ (NSString *)platformType;
//获取mac地址
+ (NSString *)macAdress;
//获取IP
+ (NSString *)ipAdress;
//做md5
+ (NSString *)md5StringWithString:(NSString *)String;
//获取设备唯一标示符 通过mac地址的md5
+ (NSString *) uniqueGlobalDeviceIdentifier;
#pragma mark 啪啪奇版本
//获取App当前版本号
+ (NSString *) currentVersionString;
//获取设备类型
+ (NSString*) deviceHardwareStr;
// 低硬件设备：iphone3gs、iphone4、ipod1~ipod4、iPad1、ipad2
+ (BOOL) lowLeverHardwareDevice;
//判断系统版本是否是否不低于IOS7
+ (BOOL) isSystemVertionLowIOS7;
//判断系统版本是否是否不低于IOS7
+ (BOOL) isSystemVertionLowIOS8;
//判断某个版本与当前app版本的关系
+ (BOOL) isCurrentSoftWareVersionLowerTheVersion:(NSString *)version;
#pragma mark- 磁盘空间
// 总磁盘空间
+ (NSNumber *) diskSpace;
// 已用磁盘空间
+ (NSNumber *) usedDiskSpace;
// 可用磁盘空间
+ (NSNumber *) freeDiskSpace;
// 可用磁盘是否充足
+ (BOOL) enoughDiskSpaceToUse;
// 是否警告可用空间剩余量
+ (BOOL) needAlertDiskSpace;

#pragma mark 文件操作
//删除文件
+ (BOOL)removePathAt:(NSString *)path;
//判断文件是否存在
+ (BOOL)fileIfExist:(NSString *)filePath;
//如果路径上没有这个文件夹，那么创建
+ (BOOL)createDirectoryIfNecessaryAtPath:(NSString *)path;
//文件大小
+ (long long)fileSize:(NSString *)filePath;
//将一个fileURL转换成一个文件系统的url
+ (NSString *) changeFileURL:(NSURL *)url;

#pragma mark 缓存路径
//文件根目录
+ (NSString *)pathForApplicationRoot;

//缓存的所有币种
+ (NSString *)pathForCachedTickers;

//////////////////////////////////////////////
//////////////////////////////////////////////


//图片缓存路径，缓存网络图片
+ (NSString *)pathForCacheImages;
//音乐缓存路径
+ (NSString *)pathForCacheMusics;
//全局设置所在的目录
+ (NSString *)pathForCacheSetting;
//CrashLog所在的目录
+ (NSString *)pathForCrashLogs;
//临时文件夹,用于存放需要上传的视频及选取的封面
+ (NSString *)pathForTemp;
/** 用户信息存储位置 **/
+ (NSString *)pathForAdminUsers;
/** 用户登录历史 **/
+ (NSString *)pathForUserHistoryList;
/** 用户json缓存 **/
+ (NSString *)pathForCurrentUserJsonCache;
/** 全局json缓存 **/
+ (NSString *)pathForGlobleJsonCache;
/** 当前用户setting缓存 **/
+ (NSString *)pathForCurrentUserSetting;
/** 后台任务存储路径，需要区分各个用户 **/
+ (NSString *)pathForOfflineHistory;

/** 本地视频的缩略图地址（本地视频界面能加载出的所有视频的缩略图） **/
+ (NSString *)pathForAlbumThumb;

/** 匿名用户的视频缩略图地址 **/
+ (NSString *)pathForUserAlbumThumb;

/**正在审核的task**/
+ (NSString *)pathForUnpublishedHistory;
/** 上传的视频的缩略图历史图片 **/
+ (NSString *)pathForUploadingHistoryThumb;
/** 正在上传历史 **/
+ (NSString *)pathForUploadingHistory;
/** 
 微博、微信(上传)分享后，用户操作完毕后，如果云视频里面没有这条视频，
 那么将这条视频加入到这个列表里面
 **/
+ (NSString *)pathForUploadedHistory;
/** 微信、朋友圈等上传完后，需要用户手动分享的任务 */
+ (NSString *)pathForWaitingForShareHistory;

/** 压缩后的视频主路径 */
+ (NSString *)pathForTempMovie;

//------------------------------------
+ (NSString *)pathForStorageUser;

#pragma mark 通知

+ (void)postNotificationName:(NSString *)name
                      object:(id)object
                    userInfo:(NSDictionary *)dic;

+ (void)addNotificationObsever:(id)observe
                        action:(SEL)sel
                          name:(NSString *)name
                        object:(id)object;

#pragma mark 本地通知
+ (void) scheduleLocalNotification:(NSString*)msg
                        withAction:(NSString*) action
                          userInfo:(NSDictionary*) userInfo;



#pragma mark 为视频时长格式化时间
/*
 格式 01:24:05 或者 24:05
 适用于视频时长,最高99:59:59
 */
+ (NSString *) formateDuration:(id) durationValue;

// 格式化的数字，比如 1->01, 24->24
+ (NSString *) formatNumber:(NSInteger) number;

#pragma mark 格式化评论、赞、视频播放数
/*
 该条规则适用于评论、赞、播放次数
 */
+ (NSString*) playCount:(id) countValue;

#pragma mark 格式化提醒badge数
/*
 适用于回复提醒、评论提醒、关注申请。
 */
+ (NSString*) messageCount:(id) countValue;

#pragma mark 格式化视频、评论发布时间
/*
 适用于视频发布时间,评论回复时间
 */
+ (NSString*) formateDate:(id) aDate;

#pragma mark 详情页发布的日期
/*
 详情页具体显示发布的日期和时间 
 */
+ (NSString*) formatPublishDate:(id) aDate;

/*
 基于特定格式格式化时间
 */
+ (NSString*) formateDateValue:(NSDate*)date
                     withStyle:(NSString*)style;


#pragma mark Show HUBView / Alert
+ (void) showHunViewWithTitle:(NSString*) title;
+ (void) showAlertWithTitle:(NSString*)title;

/*
 用于从测试json文件初始化Dictionary对象
 */
+(NSDictionary *)dictionaryFromMainBundleFile:(NSString *)file ofType:(NSString *)type;


+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text;


/*
 根据价格判断取小数点后几位
 */
+ (NSString *)stringValueForFloat:(CGFloat)num;

@end







