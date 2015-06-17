//
//  NSString+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark NSString (EmptyString) 空字符串
@interface NSString (EmptyString)
/*
 @details 从给定的object得到一个字符串
 @return 如果object本身为字符串或者能转化成字符串，则返回得到的字符串，否则nil
 @note 如果object为nil，返回nil
 */
+ (NSString*) stringValue:(id)object;

/**
 @details 判断给定的object是否为空的字符串
 @details @“”或者nil判定为空字符串
 @return YES如果为空串或者stringValue非NSString类型，否则NO
 */
+ (BOOL) isEmptyString:(id) stringValue;

@end

#pragma mark 判断字符串包含
@interface NSString (NSStringContainString)
/**
 @details 判断字符串是否包含其他字符串
 @param string 另一个字符串。
 @return YES如果该字符串包含string。返回NO，如果传nil。
 */
- (BOOL)containsString:(NSString *)string;

@end

#pragma mark NSString (NSStringCharacterCount) 字符串字符个数
@interface NSString (NSStringCharacterCount)
/**
 @details 计算一个NSString类型字符串ASCII编码的长度，如果words不是字符串类型，返回0.
 @note 汉字2个字节，英文以及符号1个字节。
 */
+ (NSInteger) wordNumber:(NSString*)words;

/**
 @details 计算一个NSString类型字符串ASCII编码的长度
 @note 汉字2个字节，英文以及符号1个字节。
 */
- (NSInteger) number;

@end

#pragma mark NSString (TrimString) 去除多余的空格
@interface  NSString (TrimString)
/**
 @details 裁剪字符串（去除字符串中间的空格）
 @param originString 要处理的字符串
 @return 返回处理后的新字符串，nil如果源串非法
 */

+ (NSString*) trimString:(NSString*)originString;
@end

#pragma mark NSString (NSStringFormatString) 格式化字符串
@interface NSString (NSStringFormatString)
/**
 格式化时长，一小时内（显示00:01、45:59），超过一小时（显示01:00:20、04:31:12）
 @param durationValue NSString or NSNumber value
 */
+ (NSString *) formatedDuration:(id) durationValue;

/**
 格式化数字：0  -> 00，12 -> 12
 @param number 要处理的数字，整型
 */
+ (NSString *) formatedNumber:(NSInteger) number;

/**
 @details 计算文件的大小，比如20K，0.06G，347M等，保留2位有效数字
 */
+ (NSString*) fileSizeWithDouble:(double) value;

/**
 按照指定格式格式化时间
 @param date 指定的日期，NSDate类型
 @param style 时间格式类型，不能为nil
 */
+ (NSString *) formateDateValue:(NSDate *)date
                      withStyle:(NSString *)style;
@end

#import <UIKit/UIKit.h>
#pragma mark NSString (NSStringBoundingSize) 计算字符占用的宽度/高度
@interface NSString (NSStringBoundingSize)

/**
 按照指定的maxWidth、行数限制maxLines和字体font
 计算文本需要的展示size。该API需要IOS6.0以上版本支持
 
 @param maxWidth 文本的最大宽度，不能为0或者负值
 @param maxLines 最大行数限制，参数为非负值，0表示不限制
 @param font     字体类型，如果不传，默认系统字体，字号17
 */
- (CGSize) boundingSizeWithConstrainedWidth:(CGFloat) maxWidth
                              maxLinesLimit:(NSInteger) maxLines
                                       font:(UIFont *) font;
@end

#pragma mark NSString (NSStringMD245)
@interface NSString (NSStringMD245)
/** MD2 string*/
- (NSString *)MD2String;

/** MD4 string*/
- (NSString *)MD4String;

/** MD5 string*/
- (NSString *)MD5String;
@end

#pragma mark NSString (NSStringBase64)
@interface NSString (NSStringBase64)
/** encode = NSUTF8StringEncoding */
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/** encode = NSUTF8StringEncoding */
- (NSString *)base64EncodedString;
/** encode = NSUTF8StringEncoding */
- (NSString *)base64DecodedString;
- (NSData *) base64DecodedData;
@end

#pragma mark NSString (NSStringPredicate) 判断邮箱、电话合法性
extern NSString* const NSPredicateValidEmailMatches; // email
extern NSString* const NSPredicateValidPhoneMatches; // phone
extern NSString* const NSPredicateValidMobileMatches; // mobile
extern NSString* const NSPredicateValidNameMatches; // user name
extern NSString* const NSPredicateValidRemoteURLMatches; // url

@interface NSString (NSStringPredicate)
/**
 判断字符串是否为有效的Email字符串
 @param emailString 需要检测的email
 
 @return YES如果为有效的Email，否则NO
 */
+ (BOOL) isValidEmailString:(NSString*)emailString;

/**
 判断字符串是否为有效的固定电话号码
 @details 区号3~4位，号码段7~8位，支持4位分机号
 @param phoneString 需要检测的固话号码
 
 @return YES如果为有效的固话，否则NO
 */
+ (BOOL) isValidTelephone:(NSString*)phoneString;

/**
 判断字符串是否为有效的手机号码
 @details 移动：134[0~8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705***.
 @details 联通：130,131,132,152,155,156,185,186,1709***.
 @details 电信：133,1349***,153,180,189,1700***.
 @details 170虚拟运营商专属号段，电信是1700;联通是1709;移动是1705。
 @param mobileString 需要检测的手机号码
 
 @return YES如果为有效的手机号，否则NO
 */
+ (BOOL) isValidMobile:(NSString*)mobileString;

/**
 判断是否为有效的用户名
 @details 有效的用户名为："汉字"、"数字"、"英文字母"、“_”。
 @note 该方法只能检测用户名是否严格按照上述说明构成，但是无法区分首字母是否能由“数字”、“_”
       等字符构成
 @return YES如果为有效的用户名，否则NO
 */
+ (BOOL) isValidUserName:(NSString *)userName;

/**
 判断是否为有效的remote url
 @details 有效的url 字符串以"http""https"开头

 @return YES如果为有效的用户名，否则NO
 */
+ (BOOL) isValidRemoteURL:(NSString*) urlString;
@end


#pragma mark NSJSONSerialization  字符串随机数
@interface NSString (RandomNumberString)
/**
 产生指定位数的由A~Z组成的字符串
 @param length 字符串要求的长度，非负值
 */
+ (NSString*) randomString:(NSInteger) length;

/**
 产生指定位数的由纯汉字组成的字符串
 @param length 字符串要求的长度，非负值
 */
+ (NSString*) randomChineseString:(NSInteger) length;

/**
 产生指定位数的由纯汉字、A~Z组成的字符串
 @param length 字符串要求的长度，非负值
 */
+ (NSString*) randomChineseCharacterString:(NSInteger) length;

/**
 产生指定位数的由纯汉字、0~9组成的字符串
 @param length 字符串要求的长度，非负值
 */
+ (NSString*) randomChineseNumberString:(NSInteger) length;

/**
 产生指定位数的由a~z、A~Z和0~9组成的字符串
 @param length 字符串要求的长度，非负值
 */
+ (NSString*) randomComplexString:(NSInteger) length;

/**
 产生指定位数的随机数字的字符串.首字母可以为0
 @param length 字符串位数，非负值
 */
+ (NSString*) randomNumberString:(NSInteger)length;

/**
 产生指定位数的随机数字的字符串
 @param length 字符串位数，非负值
 @param nonzeno 首字母能否为0,如果nonzeno=YES,随机数的首字母只能为1~9.
 */
+ (NSString*) randomNumberString:(NSInteger)length
              firstNumberNonZero:(BOOL)nonzero;
/**
 时间戳字符串，格式为20141221070101（年月日时分秒）
 */
+ (NSString*) timestampString;

/**
 时间戳字符串，格式为style。具体格式说明，@see NSDate (NSDateFormatDate)
 */
+ (NSString*) timestampStringForStyle:(NSString*) style;
@end

#pragma mark NSJSONSerialization 字符串json化
@interface NSJSONSerialization (JSONFormat)
/**
 NSString转成Json类型数据，options选择NSJSONReadingAllowFragments|NSJSONReadingMutableContainers
 @param string 需要处理的字符串
 @param error 错误error
 
 @note 返回结果为autorelease
 */
+ (id)JSONObjectWithString:(NSString *)string
                     error:(NSError **)error;
/**
 Json转成NSString类型数据，options选择NSJSONReadingAllowFragments|NSJSONReadingMutableContainers
 @param obj   需要处理的obj
 @param error 错误error
 
 @note 返回结果为autorelease
 */
+ (NSString *)stringWithJSONObject:(id)obj
                             error:(NSError **)error;

@end


#pragma mark URL encode
@interface NSString (NSStringURLEncodingUTF8)
/**
 
 */
- (NSString *) URLEncodingUTF8String;

/**
 
 */
- (NSString *) URLDecodingUTF8String;

@end


@interface NSString (NSStringUnicode)
/**
 返回string的unicode码
 */
- (NSString*) unicodeString;

/**
 @brief 根据给定的unicode码生成string
 */
- (NSString*) stringWithUnicode:(NSString*) strUnicode;

@end







