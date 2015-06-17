//
//  NSData+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//


#import <Foundation/Foundation.h>

#pragma mark NSData (MD5)
@interface NSData (NSDataMD5)
/** MD2 string*/
- (NSString *)MD2String;

/** MD4 string*/
- (NSString *)MD4String;

/** MD5 string*/
- (NSString *)MD5String;

/** SHA1Digest */
- (NSString *)SHA1Digest;

/** SHA224Digest */
- (NSString *)SHA224Digest;

/** SHA256Digest */
- (NSString *)SHA256Digest;

/** SHA384Digest */
- (NSString *)SHA384Digest;

/** SHA512Digest */
- (NSString *)SHA512Digest;
@end


#pragma mark NSData (Base64)
@interface NSData (NSDataBase64)

/** encode = NSUTF8StringEncoding */
+ (NSData *) dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end

#pragma mark NSData (NSBundleData)
@interface NSData (NSBundleData)
/**
 @details 从 mainBundle 获取指定名称 fileName 和类型 type 的文件
 @note 如果 fileName 本身是绝对路径，type 可以指定为 nil。
 */
+ (instancetype) bundleDataWithName:(NSString*) fileName ofType:(NSString*) type;

@end

#pragma mark NSData (NSDataContentType)
typedef NS_ENUM(NSInteger, NSDataType) {
    NSDataTypeNone = 0,      //数据空或者格式不明
    
    NSDataTypeImagePNG = 10, //png
    NSDataTypeImageJPG,      //jpg、jpeg
    NSDataTypeImageGIF,      //gif
    NSDataTypeImageTIFF,     //tiff
    NSDataTypeImageWEB,      //web格式
    
    NSDataTypeDefault = 1,   //非图片类型
};
@interface NSData (NSDataContentType)
/**
 获取 NSData 的文件类型
 */
+ (NSDataType) ContentDataType:(NSData*) data;
@end

#pragma mark NSData (NSDataCacheManager)
@interface NSData (NSDataCacheManager)
/**
 设置默认的缓存地址。如果不设置，默认~Library/Caches
 @param defaultPath 默认缓存地址
 */
+ (void) SetDefaultCachesDirectoryPath:(NSString*) defaultPath;

/**
 缓存NSData到文件
 @param url data的url，不能为nil
 */
- (void) storeDataWithUrl:(NSString*) url;

/**
 缓存NSData到文件
 @param url data的url，不能为nil
 @param directoryPath 文件夹得路径，如果传nil，将使用默认路径
 */
- (void) storeDataWithUrl:(NSString*) url fileDirectory:(NSString*)directoryPath;
/**
 缓存NSData到文件
 @param key data所在地址的url的 MD5，不能为nil
 @param directoryPath 文件夹得路径，如果传nil，将使用默认路径
 */
- (void) storeDataForKey:(NSString*) key fileDirectory:(NSString*)directoryPath;

/**
 缓存NSData到文件
 @param data 要保存的数据
 @param url data的url，不能为nil
 */
+ (void) storeData:(NSData*) data withUrl:(NSString*) url;

/**
 缓存NSData到文件
 @param data 要保存的数据
 @param url data的url，不能为nil
 @param directoryPath 文件夹得路径，如果传nil，将使用默认路径
 */
+ (void) storeData:(NSData*) data withUrl:(NSString*) url fileDirectory:(NSString*)directoryPath;

/**
 缓存NSData到文件
 @param data 要保存的数据
 @param key data所在地址的url的 MD5，不能为nil
 @param directoryPath 文件夹得路径，如果传nil，将使用默认路径
 */
+ (void) storeData:(NSData*) data forKey:(NSString*) key fileDirectory:(NSString*)directoryPath;

/**
 获取之前缓存的资源
 @param url 数据的网络url地址
 @param directoryPath 所在文件夹地址
 */
+ (NSData*) cachedDataWithUrl:(NSString*) url;

/**
 获取之前缓存的资源
 @param key 数据的网络url地址md5
 @param directoryPath 本地磁盘文件夹地址
 */
+ (NSData*) cachedDataForKey:(NSString*) key fileDirectory:(NSString*)directoryPath;

/**
 获取本地磁盘缓存得cache地址
 @param url 数据的网络url地址
 @param directoryPath 本地磁盘文件夹地址
 @return 返回正确得缓存地址，nil如果url非法或者为空
 */
+ (NSString*) cachePathForUrl:(NSString*) url inDirectory:(NSString*) directoryPath;

@end

#pragma mark NSData (NSDataFromURL)
/**
 @details progress block
 @param receivedData 接收到的数据
 @param expectedData 总大小
*/
 typedef void (^RemoteDataDownloadProgressBlock) (long long receivedData, long long expectedData);
/**
 @details finish block
 @param url 数据的 url 地址
 @param data 下载好的数据
 @param fromCache 数据是否来自缓存（YES：缓存 NO：下载）
 @param error 如果下载发生错误，错误信息会放在 error 中。
*/
 typedef void (^RemoteDataDownloadFinishBlock) (NSURL *url, NSData *data, BOOL fromCache, NSError *error);

typedef NS_ENUM(NSInteger, NSDataCachePolicy) {
    NSDataCachePolicyDefault = 0,      //首先查找缓存，没有则加载网络
    NSDataCachePolicyNetworkOnly = 10, //只加载网络
    NSDataCachePolicyCacheOnly = 20,   //只加载缓存，不读取网络
};
@interface NSData (NSDataFromURL)
/**
 从网络异步下载NSData
 @param url 图片得url地址，不能为nil
 @param completion 下载完成后block
 @discussion 每次调用设置60.0秒的超时时间，超过该时间按超时失败处理。该方法可能非主线程，需要更新UI请在主线程中处理。
 @attention 如果需要认证信息才能下载数据，请求所需的认证信息必须指定作为URL的一部分。
            如果认证信息失效，或者证书丢失，连接将尝试以没有认证信息的方式进行。
 @note 适用于iOS 5.0及之后版本，取消使用[NSData canclePreviousDownload:yourURL]或者
       [NSData cancleAllDownload]。
 */
+ (void)dataWithRemoteURL:(NSURL *)url
            progressBlock:(RemoteDataDownloadProgressBlock) progress
          completionBlock:(RemoteDataDownloadFinishBlock)completion;

/**
 从网络异步下载NSData
 @param url 图片得url地址，不能为nil
 @param completion 下载完成后block
 @param timeoutInterval 超时时间，超过该时间按超时失败处理。该方法可能非主线程，需要更新UI请在主线程中处理。
 @param cachePolicy 缓存策略
 @attention <li>该方法调用后不能被cancle，故请使用在保证不会被中间打断的条件下。
            <li>如果需要认证信息才能下载数据，请求所需的认证信息必须指定作为URL的一部分。
            <li>如果认证信息失效，或者证书丢失，连接将尝试以没有认证信息的方式进行。
 @note 适用于iOS 5.0及之后版本，取消使用[NSData canclePreviousDownload:yourURL] 或者
       [NSData cancleAllDownload]。
 */

+ (void)dataWithRemoteURL:(NSURL *)url
          timeoutInterval:(NSTimeInterval) timeoutInterval
              cachePolicy:(NSDataCachePolicy) cachePolicy
            progressBlock:(RemoteDataDownloadProgressBlock) progress
          completionBlock:(RemoteDataDownloadFinishBlock)completion;


/**
 取消指定的下载任务
 @param url 需要取消的 url
 */
+ (void) canclePreviousDownload:(NSURL*) url;

/**
  取消所有下载任务
 */
+ (void) cancleAllDownload;

@end








