//
//  SecondShareManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/5.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, SharePlatformType) {
    SharePlatformTypeWeibo,         //分享：微博
    SharePlatformTypeWeixin,        //分享：微信
    SharePlatformTypeWeixinZone,    //分享：微信朋友圈
    SharePlatformTypeQQZone,        //分享：QQ朋友圈
    SharePlatformTypeCopy,          //分享：复制链接
};

// block
typedef void(^SecondShareBlock) (NSString* finishText, NSError* error);

@interface SecondShareManager : NSObject

+ (void)shareVideo:(NSDictionary*) videoInfo
      platformType:(SharePlatformType) type
       finishBlock:(SecondShareBlock) block;

@end
