//
//  PPQNetWorkURLs.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-15.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark 公共部分
@interface PPQNetWorkURLs : NSObject


@end


#pragma mark - 登录注册
@interface PPQNetWorkURLs (LoginRegister)

//API的host
#define APIHOST  @"http://118.192.8.126:8080/apps_mn/index.php"

//登录
#define LOGIN @"/user/login"
+ (NSString *)login;

//注册
#define REGISTER @"/user/reg"
+ (NSString *)registerBox;

//获取新闻列表
#define NEWSLIST @"/news/getlist"
+ (NSString *)getNewsListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize;

//新闻内容
#define NEWSINFO @"/news/getnewsinfo"
+ (NSString *)getNewsInfoWithId:(NSString *)newsId;

@end












