//
//  FTHyperLink.h
//  ActionLabel
//
//  Created by Sean on 13-9-22.
//  Copyright (c) 2013年 Sean. All rights reserved.
/*!
 链接结构定义
*/

#import "FTDefine.h"
@interface FTHyperLink : NSObject

/**
 link text
*/
 @property (nonatomic, copy, readonly) NSString* linkText;

/**
 link type
*/
@property (nonatomic, readonly) TParseType type;

/**
 link range
*/
@property (nonatomic, readonly) NSRange range;

/**
 link rects
*/
@property (nonatomic, readonly) NSMutableArray* linkRects;

/**
 link tag，用于区分不同的link,default=0
*/
@property (nonatomic, assign) NSInteger tag;

/**
 init
 
 @param text 文本内容
 @param type parser类型
 @param range range
*/
-(id) initWithText:(NSString*) text
          linkType:(TParseType) type
             range:(NSRange) range;

/**
 计算range的位置
 */
+ (NSRange) newRange:(NSRange) range lengthOffset:(CGFloat) l;
@end
