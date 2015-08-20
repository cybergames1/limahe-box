//
//  FTExpression.h
//  ActionLabel
//
//  Created by Sean on 13-11-2.
//  Copyright (c) 2013年 Sean. All rights reserved.
//  自定义解析类型，以解析话题 #*****# 为例@"(#[\u4e00-\u9fa5a-zA-Z0-9_-]+#)"

#import "FTDefine.h"

/**
 正则表达式中，常用字符的unicode取值范围
 */
extern NSString* const CharactersUnicodeRange ;  //英文大小写字母
extern NSString* const ChineseUnicodeRange ;     //汉字
extern NSString* const NumberUnicodeRange ;      //数字
extern NSString* const EmojiUnicodeRange;        //全部的emoji


@interface FTExpression : NSObject

/**
 expression string，比如@"(#[\u4e00-\u9fa5_-]+#)",default=nil
 */
@property (nonatomic, copy) NSString* expressionString;

/**
 preMark，比如“#”,default=nil
*/
@property (nonatomic, copy) NSString* preMark;

/** 
 subMark，比如“#”,default=nil
*/
@property (nonatomic, copy) NSString* subMark;

/** 
 parser type
 @details 该参数必须指定一个类型
*/
@property (nonatomic, assign) TParseType parseType;

/** 
 min link length，对于话题#***#，需要要求最小为3,default=0
*/
@property (nonatomic, assign) NSInteger minLength;

/**
 解析后是否需要删除preMark和subMark字段,default=NO
 @details 以话题#你好#为例，如果shouldDeleteMark=YES，解析后文本为 你好，
       如果shouldDeleteMark=NO，解析后文本为 #你好#
 */
@property (nonatomic, assign) BOOL shouldDeleteMark;

/**
 tag用于区分不同的expressiton,default=0
 @details 对于TParseTypeCustom类型的多个expression，建议设置不同的tag
 */
@property (nonatomic, assign) NSInteger tag;

/** 
 init with expressionString
 使用举例：
 @code 
     FTExpression* exp = [[FTExpression alloc] initWithExpressionString:@"(#[\u4e00-\u9fa5a-zA-Z0-9_-]+#)"];
     exp.preMark = @"#";
     exp.subMark = @"#";
     exp.parseType = TParseTypeTopic;
     exp.minLength = 3;
 @endcode
*/
- (id)initWithExpressionString:(NSString*) expressionString;

@end
