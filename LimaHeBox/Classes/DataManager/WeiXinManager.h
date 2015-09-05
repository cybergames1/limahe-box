//
//  WeiXinManager.h
//  Papaqi
//
//  Created by jianting on 15/8/7.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"

/**
 @brief  封装了微信的相关操作
 
 
 **/

#define kWXSSO                  @"wx060eaaa26413937e"

@protocol WeixinManagerResponseDelegate <NSObject>

- (void) weixinShareFinishSuccessWithRsp:(BaseResp *)resp;
- (void) weixinShareFInishErrorWithRsp:(BaseResp *)resp;

@end

@interface WeiXinManager : NSObject<WXApiDelegate>
{
    id<WeixinManagerResponseDelegate> _responseDelegate;
}

@property (nonatomic, assign) id<WeixinManagerResponseDelegate> responseDelegate;

+ (WeiXinManager *) sharedInstance;

+ (BOOL) openWxApp;
+ (BOOL) isWeixinInstalled;

//分享给微信好友  thumb直接传对应的UIImage*大图对象
- (void) shareVideoToWeixinFriendWithTitle:(NSString *)title
                              desctription:(NSString *)desctription
                                       url:(NSString *)url
                                thumbImage:(UIImage *)thumb;

//分享给好友圈  thumb直接传对应的UIImage*大图对象
- (void) shareVideoToWeixinTimelineWithTitle:(NSString *)title
                                desctription:(NSString *)desctription
                                         url:(NSString *)url
                                  thumbImage:(UIImage *)thumb;

//回应微信
- (void) shareVideoRespToWeixinWithTitle:(NSString *)title
                            desctription:(NSString *)desctription
                                     url:(NSString *)url
                          thumbImagePath:(NSString *)path;

//微信登录
- (void) weixinLogin;

@end

