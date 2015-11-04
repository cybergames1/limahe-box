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

+ (NSString *)updatePassword {
    return [NSString stringWithFormat:@"%@%@",APIHOST,UPDATE_PASSWORD];
}

+ (NSString *)updateInfo {
    return [NSString stringWithFormat:@"%@%@",APIHOST,UPDATE_INFO];
}

+ (NSString *)sendAuthCode {
    return [NSString stringWithFormat:@"%@%@",APIHOST,SEND_AUTHCODE];
}

+ (NSString *)getNewsListWithPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    return [NSString stringWithFormat:@"%@%@?pagenumber=%ld&pagesize=%ld",APIHOST,NEWSLIST,(long)page,(long)pageSize];
}

+ (NSString *)getNewsInfoWithId:(NSString *)newsId {
    return [NSString stringWithFormat:@"%@%@?id=%@",APIHOST,NEWSINFO,newsId];
}

+ (NSString *)deviceInfo {
    return [NSString stringWithFormat:@"%@%@",APIHOST,DEVICEINFO];
}

+ (NSString *)startWeight {
    return [NSString stringWithFormat:@"%@%@",APIHOST,STARTWEIGHT];
}

+ (NSString *)stopWeight {
    return [NSString stringWithFormat:@"%@%@",APIHOST,STOPWEIGHT];
}

+ (NSString *)sendInstruction {
    return [NSString stringWithFormat:@"%@%@",APIHOST,SENDINSTRUCTION];
}

+ (NSString *)getWeight {
    return [NSString stringWithFormat:@"%@%@",APIHOST,GETWEITHG];
}

@end







