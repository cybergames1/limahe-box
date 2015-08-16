//
//  PPQNetWorkURLs.m
//  PaPaQi
//
//  Created by fangyuxi on 13-11-15.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQNetWorkURLs.h"
#import "CommonTools.h"

@implementation PPQNetWorkURLs

@end

@implementation PPQNetWorkURLs (LoginRegister)

+ (NSString *)login {
    return [NSString stringWithFormat:@"%@%@",APIHOST,LOGIN];
}

+ (NSString *)registerBox {
    return [NSString stringWithFormat:@"%@%@",APIHOST,REGISTER];
}

+ (NSString *)getNewsListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    return [NSString stringWithFormat:@"%@%@?pagenumber=%ld&pagesize=%ld",APIHOST,NEWSLIST,page,pageSize];
}

+ (NSString *)getNewsInfoWithId:(NSString *)newsId {
    return [NSString stringWithFormat:@"%@%@?id=%@",APIHOST,NEWSINFO,newsId];
}

@end







