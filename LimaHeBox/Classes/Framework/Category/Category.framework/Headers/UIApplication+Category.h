//
//  UIApplication+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark UIApplation (DirectoryPath) app主目录访问及文件创建
@interface UIApplication (ApplicationDirectoryPath)

/** 
 获取app在沙盒的Library文件夹地址 
 @details 结构为：/var/mobile/Applications/...../Library
 */
+ (NSString*) pathForLibraryDirectory;
/** 
 获取app在系统沙盒默认缓存Caches文件夹的地址
 @details 结构为：/var/mobile/Applications/...../Library/Caches
 */
+ (NSString*) pathForCachesDirectory;

/**
 获取app在系统沙盒图片缓存ImageCaches文件夹的地址
 @details 结构为：/var/mobile/Applications/...../Library/Caches/ImageCaches
 */
+ (NSString*) pathForImageCacheDirectory;

/**
 获取app在系统沙盒Data缓存DataCaches文件夹的地址
 @details 结构为：/var/mobile/Applications/...../Library/Caches/DataCaches
 */
+ (NSString*) pathForDataCacheDirectory;

/**
 获取app在系统沙盒默认缓存Crash log文件夹的地址
 @details 结构为：/var/mobile/Applications/...../Library/CrashLogs
 */
+ (NSString*) pathForCrashLogsDirectory;

/** 
 获取app在系统沙盒默认缓存Preferences文件夹的地址
 @details 结构为：/var/mobile/Applications/...../Library/Preferences
 */
+ (NSString*) pathForPreferenceDirectory;

/** 
 获取app在沙盒的Document文件夹地址 
 @note 默认会设置Document中存储的文件不支持iCloud和Itunes同步。
 @details 结构为：/var/mobile/Applications/...../Document 
 */
+ (NSString*) pathForDocumentDirectory;

/**
 获取app在沙盒的Temp文件夹地址，
 @details 结构为：/var/mobile/Applications/...../tmp
 */
+ (NSString*) pathForTempDirectory;

/**
 获取根目录的路径
 @details 结构为：/var/mobile/Applications/.....
 */
+ (NSString*) pathForHomeDirectory;

/**
 按照指定的路径创建文件(文件夹)
 @details 如果指定的路径包含在多层文件夹里，而且相应的文件夹都没有创建，
          该API会先尝试创建根目录的文件夹，然后再创建最终路径
 
 @note 如果传入的路径path是文件的路径而不是文件夹路径，API创建的是path去掉Extension后的文件夹
 @param path 指定的绝对路径，不能为nil
 @return YES如果创建成功，NO失败
 */
+ (BOOL) createDirectoryIfNecessaryAtPath:(NSString *)path;

/**
 标记文件夹不会被icloud或者itunes同步
 @note 在ios5以后的系统，需要标记不必被同步到icloud的文件，否则，apple在审核时会拒掉
 */
+ (BOOL) markDirectorySkipBackup:(NSString*) directoryPath;

@end

#pragma mark UIApplation (DirectoryPath) app主目录访问及文件创建
typedef void(^DirectoryFinishBlock) (NSUInteger fileCount, NSUInteger fileSize, NSError *error);
typedef void(^DirectoryProgressBlock) (CGFloat progress);

@interface UIApplication (DirectoryFiles)
/**
 @details 计算指定文件夹中文件的个数
 @param path 文件夹的路径
 
 @detail 如果该文件夹中还包括多个文件夹，每个文件夹只算做一个文件
 */
+ (NSInteger) directoryFilesCount:(NSString *)path;

/**
 @details 计算指定文件/文件夹的大小
 @param path 文件夹的路径
 @param finishBlock 完成的block
 @note 由于操作不能中断，如果block付值，在完成之前请不要销毁block
 */
+ (void) directorySpaceSize:(NSString *)directoryPath
                finishBlock:(DirectoryFinishBlock) finishBlock;

/**
 @details 计算指定多个文件/文件夹的大小
 @param path 多个文件夹的数组
 @param finishBlock 完成的block
 @note 由于操作不能中断，如果block付值，在完成之前请不要销毁block
 */
+ (void) directorySpaceSizeForPathes:(NSArray *)directoryPathes
                         finishBlock:(DirectoryFinishBlock) finishBlock;

/**
 @details 计算指定文件的大小
 @param filePath 文件的绝对路径
 
 @note filePath不能为文件夹的路径，否则将返回错误的大小，如果要计算文件夹的大小，请使用
 [UIApplication filesSpaceAtPath:finishBlock:]
 */
+ (NSUInteger) fileSizeAtPath:(NSString *) filePath
                    fileCount:(NSUInteger *) fileCount
                        error:(NSError **) error;

/**
 @details 删除指定路径文件夹下所有的文件
 @param path 文件夹的路径
 @param progressBlock 进度block
 
 @warning progress 删除进度，每删除一个文件，都会更新进度值
 @warning finish   删除是否完成，如果YES=finish，标识文件全部删除
 @warning error    错误信息.如果error不为nil，表示有错误发生，删除结束
 */
+ (void) deleteFilesForPath:(NSString*) directoryPath
              progressBlock:(DirectoryProgressBlock) progressBlock
                finishBlock:(DirectoryFinishBlock) finishBlock;

/**
 @details 删除指定路径文件夹下所有的文件
 @param path 文件夹的路径
 @param progressBlock 进度block
 @param lastModifiDate 文件最后访问时间。访问时间在该日期之前的都会被清除
 @warning progress 删除进度，每删除一个文件，都会更新进度值
 @warning finish   删除是否完成，如果YES=finish，标识文件全部删除
 @warning error    错误信息.如果error不为nil，表示有错误发生，删除结束
 @note 由于操作不能中断，如果block付值，在完成之前请不要销毁block
 @code
     [UIApplication deleteFiles:_yourDirPath lastModifiDate:[NSDate dateWithTimeIntervalSinceNow:0] progressBlock:^(CGFloat progress)
         {
             // print progress
         }
     finishBlock:^(NSUInteger fileCount, NSUInteger fileSize, NSError *error)
         {
             if (error) {
             
             }
             else{
                 // fileCount=file count be deleted
                 // fileSize= all deleted files's size
         }
     }];
 @endcode
 */
+ (void) deleteFilesForPath:(NSString*) directoryPath
             lastModifiDate:(NSDate*) lastModifiDate
              progressBlock:(DirectoryProgressBlock) progressBlock
                finishBlock:(DirectoryFinishBlock) finishBlock;
/**
 @details 删除指定路径文件夹下所有的文件
 @param pathes 多个文件夹的路径
 @param progressBlock 进度block
 @param lastModifiDate 文件最后访问时间。访问时间在该日期之前的都会被清除
 @warning progress 删除进度，每删除一个文件，都会更新进度值
 @warning finish   删除是否完成，如果YES=finish，标识文件全部删除
 @warning error    错误信息.如果error不为nil，表示有错误发生，删除结束
 @note 由于操作不能中断，如果block付值，在完成之前请不要销毁block
 */
+ (void) deleteFilesAtPathes:(NSArray*) pathes
              lastModifiDate:(NSDate*) lastModifiDate
               progressBlock:(DirectoryProgressBlock) progressBlock
                 finishBlock:(DirectoryFinishBlock) finishBlock;

// Notifination
extern NSString* const kDirectoryDeleteProgressNotifination; //清理文件进度的通知
extern NSString* const kDirectoryDeleteFinishNotifination;   //清理文件完成的通知

// notifination key
extern NSString* const kDirectoryFileCountKey;     //文件个数
extern NSString* const kDirectoryFileTotleSizeKey; //文件大小
extern NSString* const kDirectoryErrorKey;         //错误信息
extern NSString* const kDirectoryProgressKey;      //进度
@end


#pragma mark UIApplation (RemoteNotifination) 通知
@interface UIApplication (RemoteNotifination)
/**
 @details 判断App是否打开了推送开关/是否允许推送服务
 */
+ (BOOL) isAPPEnabledRemoteNotification;

@end


#pragma mark UIApplication (AppVersion) app版本
@interface UIApplication (ApplicationVersion)
/**
 @details 获取当前App的版本,比如:1.0.1
 @note 此数据获取的是app的版本，不是操作系统的版本
 */
+ (NSString*) applationVersion;

/**
 @details 获取当前运行app的bundle包的名字，标识了束的可执行主文件的名称（一般为app bundle 的名字）。
          对于一个应用程序来说,就是该应用程序的可执行文件。比如 Safari
 */
+ (NSString*) applationExecutableName;

/**
 @details 获取当前运行app的名字。该名字是系统显示给用户用的(在 appleStore 展示的名字)。
          这个名称可以与文件系统中的束名“applationExecutableName”不同
 */
+ (NSString*) applationDisplayName;

/**
 @details app 运行需要的最低操作系统版本，比如“6.0”
 */
+ (NSString*) applationMinimumOSVersion;

@end

#pragma mark - visibleViewController
@interface UIApplication (visibleViewController)

/** 当前正在显示的，处于最上面的 viewController */
+ (UIViewController*) visibleViewController;

@end





