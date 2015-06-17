//
//  SocialTools.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTools.h"

/**
 
 // 朋友圈部分的Tools方法，添加前请先查看CommentTools里面是否有满足需求的代码，如果有，请在SocialTools里面
    直接调用CommentTools方法
 
 
 **/


#pragma mark ---------------------------
#pragma mark 服务端返回错误字段定义
#pragma mark ---------------------------

/** 错误Domain **/
#define KErrorDomain @"PPQERRORDOMAIN"
/** 错误信息相关 **/
#define KErrorCode @"code"
#define KErrorCodeKey @"errorCode"
#define KErrorMSG @"msg"
#define KErrorNormal @"A00000"
#define KErrorUploadMore @"A00018"
#define KErrorCodeServerError 500
#define KErrorCodeOKMin 200
#define KErrorCodeOKMax 206


@interface SocialTools : NSObject

#pragma mark- 底层Error处理
+ (NSError*) networkError:(NSError*)error;
@end

