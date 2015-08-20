//
//  LRTools.m
//  PaPaQi
//
//  Created by jianting on 13-11-18.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "LRTools.h"

@implementation LRTools

+ (LRTools *)sharedTools
{
    static LRTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LRTools alloc] init];
    });
    return instance;
}

+ (void)startPPQifNeeded {
//    LoginFinish finshBlock = [[LRTools sharedTools] finishBlock];
//    if (finshBlock) {
//        finshBlock();
//        [[LRTools sharedTools] setFinishBlock:nil];
//    }
}

#pragma mark - 验证邮箱、手机号合法性
+ (BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL)NSStringIsValidPhoneNumber:(NSString*)checkString
{
    /**
     移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     联通：130,131,132,152,155,156,185,186
     电信：133,1349,153,180,189
     大陆地区固话及小灵通
     区号：010,020,021,022,023,024,025,027,028,029
     号码：七位或八位
     */
    NSString *MOBILE = @"^((\\+86)|(86))?1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}$";
    /*
     NSString *CM    = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
     NSString *CU    = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
     NSString *CT    = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
     NSString *PHS   = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
     */
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:checkString];
}

+ (BOOL)NSStringIsValidUserNick:(NSString *)nickString
{
    /**
     只有数字、字母、下划线、汉字
     */
    NSString *nick = @"[a-zA-Z0-9_\u4e00-\u9fa5]+";
    
    NSPredicate *nickTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nick];
    return [nickTest evaluateWithObject:nickString];
}

+ (BOOL)NSStringIsValidPassword:(NSString *)passwordString
{
    /**
     只有数字、字母
     */
    NSString *pwd = @"^[A-Za-z0-9]+$";
    
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pwd];
    return [pwdTest evaluateWithObject:passwordString];
}

+ (BOOL)NSStringContainsEmoji:(NSString*) string
{
    if ([LRTools isEmptyString:string]) {
        return NO;
    }
    __block BOOL hasEmoji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    *stop = YES;
                    hasEmoji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                *stop = YES;
                hasEmoji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                *stop = YES;
                hasEmoji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                *stop = YES;
                hasEmoji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                *stop = YES;
                hasEmoji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                *stop = YES;
                hasEmoji = YES;
            }
            if (NO == hasEmoji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    *stop = YES;
                    hasEmoji = YES;
                }
            }
        }
    }];
    return hasEmoji;
}

+ (NSString*)truePhoneString:(NSString*)phone
{
    if ([LRTools isEmptyString:phone]) {
        return nil;
    }
    // 去掉空格
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phoneString = nil;
    if ([phone hasPrefix:@"+86"]) {
        phoneString = [phone substringFromIndex:3];
    }
    else if ([phone hasPrefix:@"86"]){
        phoneString = [phone substringFromIndex:2];
    }
    else{
        phoneString = phone;
    }
    
    NSString* truePhone = [phoneString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    truePhone = [truePhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    truePhone = [truePhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    if ([LRTools NSStringIsValidPhoneNumber:truePhone]) {
        return truePhone;
    }
    return nil;
}

#pragma mark - 服务器返回的错误信息

+ (NSString *)errorStringFromDictionary:(NSDictionary *)dic
{
    return [dic valueForKey:@"msg"];
}

#pragma mark - snsList

+ (NSString *)stringWithList:(id)snsList
{
    NSString *snsString = @"";
    
    if ([snsList isKindOfClass:[NSArray class]])
    {
        for (NSDictionary *snsItem in snsList)
        {
            int snsId = [[snsItem valueForKey:@"sns_id"] intValue];
            if ([CommonTools isEmptyString:snsString])
            {
                snsString = [NSString stringWithFormat:@"%d",snsId];
            }
            else
            {
                snsString = [snsString stringByAppendingFormat:@",%d",snsId];
            }
        }
    }
    
    return snsString;
}

@end
