//
//  FTActionLabel.h
//  FTActionLabel
//
//  Created by Sean on 13-9-22.
//  Copyright (c) 2013年 Sean. All rights reserved.
//

/*!
 @brief 支持超链接+点击的label控件，
 1、布局调整支持多种类型
 2、可点击文本支持多种方式（参见TParseType）
 */

#import "FTDefine.h"
@class FTParser;
@protocol FTActionLabelDelegate;

@interface FTActionLabel : UIView
/**  delegate */
@property (nonatomic, assign) id<FTActionLabelDelegate> delegate;

/** 链接解析样式,默认不解析TParseTypeNone */
@property (nonatomic, assign) TParseType parseType;

/** 字号(字体大小)，默认=15 */
@property (nonatomic, assign) CGFloat fontSize;
/** hyperLinkCorner，超链接点中后阴影的corner，default=3 */
@property (nonatomic, assign) CGFloat hyperLinkCorner;
/**
 首行缩进距离,（像素值，非字符个数），默认0
 */
@property (nonatomic, assign) CGFloat firstLineHeadIndent;
/**
 alignment，default=NSTextAlignmentLeft
 */
@property (nonatomic, assign) NSTextAlignment alignment;
/**
 lineBreakMode，default=NSLineBreakByCharWrapping
 */
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;

// Line Space
/**
 maxLineSpace，default=9.0
 */
@property (nonatomic, assign) CGFloat maxLineSpace;
/**
 minLineSpace，default=0.0
 */
@property (nonatomic, assign) CGFloat minLineSpace;
/**
 lineSpacing，default=1.0
 */
@property (nonatomic, assign) CGFloat lineSpacing;

// Text Color
/** 文本颜色，默认[UIColor blackColor] */
@property (nonatomic, copy) UIColor* textColor;
/** 链接颜色，default=[UIColor greenColor] */
@property (nonatomic, copy) UIColor* hyperlinkColor;
/**
 hyperLinkShadowColor color，default=[UIColor grayColor]
 if nil,we will not show shadow when touch the hyperLink.
 */
@property (nonatomic, copy) UIColor* hyperLinkShadowColor;
/**
 highlightHyperlinkColor color，default=[UIColor grayColor]
 */
@property (nonatomic, copy) UIColor* highlightHyperlinkColor;
@end

@interface FTActionLabel (ShowText)

/**  NSAttributedString */
@property (nonatomic) NSAttributedString* attributedString;

/** parse */
@property (nonatomic) FTParser* parser;

/** text */
@property (nonatomic) NSString* text;

@end

/*! FTActionLabelDelegate */
@class FTHyperLink;
@protocol FTActionLabelDelegate <NSObject>
@optional
/**
 actionLabel事件的回抛
 */
- (void)actionLabel:(FTActionLabel *)label
 didTappedHyperLink:(FTHyperLink *)hyperLink;

@end


