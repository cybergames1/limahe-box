//
//  UILabel+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark UILabel （UnderLineLabel）带下划线的elabel
@interface UILabel (UnderLineLabel)
/**
 设置带下划线的文本
 @param range 下划线的范围
 @node 需要在设置text后使用该方法
 */
- (void) setUnderlineTextRange:(NSRange) range;

/**
 设置带下划线的文本
 @param range 下划线的范围
 @param lineStyle 下划线样式
 @node 需要在设置text后使用该方法
 */
- (void) setUnderlineTextRange:(NSRange) range
                     lineStyle:(NSUnderlineStyle) lineStyle;
@end

#pragma mark UILabel （AutoFitLayout）自动布局
@interface UILabel(AutoFitLayout)
/**
 @brief 根据指定的字体Font和初始frame，自动调整文本的高度并对齐上部（不影响textAlignment）。
 @details 使用这个方法之前可以先设置一个初始的frame，如果初始frame=CGRectZero，默认按照宽度=320.0计算高度。
 如果初始设置得frame高度高于实际文本高度，则居上部展示
 
 @warning 需要在设置text后使用该方法
 */
- (void) autoFitLayoutTop;

/**
 @brief 根据指定的字体Font和初始frame，自动调整文本的高度并对齐下部（不影响textAlignment）。
 @details 使用这个方法之前可以先设置一个初始的frame，如果初始frame=CGRectZero，默认按照宽度=320.0计算高度。
 如果初始设置得frame高度高于实际文本高度，则居下部展示
 
 @warning 需要在设置text后使用该方法
 */
- (void) autoFitLayoutBottom;

@end


#pragma mark UILabel （ColorLabel）设置部分文本颜色
@interface UILabel (ColorLabel)
/**
 为label的部分设置特定颜色
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param range 指定的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color withRange:(NSRange) range;

/**
 为label的部分设置特定颜色
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param from  开始的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color FromIndex:(NSInteger) from;

/**
 为label的部分设置特定颜色
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param to    结束的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color toIndex:(NSInteger) to;

/**
 为label的部分设置特定颜色和字体
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param font 指定的字体
 @param range 指定的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color font:(UIFont*) font withRange:(NSRange) range;

/**
 为label的部分设置特定颜色和字体
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param font 指定的字体
 @param from  开始的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color font:(UIFont*) font FromIndex:(NSInteger) from;

/**
 为label的部分设置特定颜色和字体
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param font 指定的字体
 @param to  结束的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color font:(UIFont*) font toIndex:(NSInteger) to;

@end

#pragma mark UILabel （MutableFontLabel）设置部分文本特殊字体
@interface UILabel (MutableFontLabel)
/**
 为label的部分设置特定字体
 @node 需要在设置text后使用该方法,该方法可以被调用多次
 @param font 指定的字体
 @param range 指定的范围，该范围不能超出label文本的总长度
 */
- (void) setFont:(UIFont*) font withRange:(NSRange) range;

@end

#pragma mark UILabel （ParagraphStyle）设置文本布局
@interface UILabel (ParagraphStyle)
/**
 设置完属性，需要调用 -applyParagraphStyle 应用
 */
- (void) applyParagraphStyle;

/**
 设置文本行间距
 */
- (void) setLineSpace:(CGFloat) lineSpace;

/**
 调整行距，使用lineHeightMultiple更改行距倍数.
 */
- (void) setLineHeightMultiple:(CGFloat) lineHeightMultiple;

/**
 设置首行缩进的距离(像素)。不能为负值
 */
- (void) setFirstLineHeadIndent:(CGFloat) firstLineHeadIndent;

/**
 调整全部文字的缩排距离，可当作左边 padding 使用
 */
- (void) setHeadIndent:(CGFloat) headIndent;

/**
 调整文字尾端的缩排距离。需要注意的是，这里指定的值可以当作文字显示的宽（正值），
 而也可当作右边padding（负值）使用，依据输入的正负值而定.
 */
- (void) setTailIndent:(CGFloat) tailIndent;

/**
 针对不同的字型与字号，可以透过指定最大(maximumLineHeight)来避免过高或过窄的状况发生。
 */
- (void) setMaximumLineHeight:(CGFloat) maximumLineHeight;
/**
 针对不同的字型与字号，可以透过指定最小行距(minimumLineHeight)来避免过高或过窄的状况发生。
 */
- (void) setMinimumLineHeight:(CGFloat) minimumLineHeight;

/**
 指定段落结尾距离
 */
- (void) setParagraphSpace:(CGFloat) paragraphSpace;
/**
 段落开头距离(像素值)
 */
- (void) setParagraphSpacingBefore:(CGFloat) paragraphSpacingBefore;

@end


#pragma mark UILabel （ActionLabel）label响应点击事件
@interface UILabel (ActionLabel)
/**
 @details 给整个label增加点击方法，链接颜色为textColor，高亮颜色通过[setLinkColor:withRange:]设置。
 如果没有设置，默认为highlightTextColor
 @node 需要在设置text后使用该方法，如果highlightTextColor没有指定，则默认为grayColor
 @param target 相应的target，不能为nil
 @param action action方法，最多可带一个参数
 @code
   [myLabel addTarget:self action:@selector(myLabelAction:)];
 @endcode
 */
- (void) addTarget:(id)target action:(SEL)action;

/**
 为label的可点部分（超级链接）设置颜色
 @note 需要在设置text后使用该方法
 @param linkColor 指定的颜色
 @param range 指定的范围，该范围不能超出label文本的总长度
 @details 如果文本的部分为可点链接，可以通过这句API设置特殊点击颜色
 @note 如果不单独设置链接颜色，默认使用textColor颜色。
 */
- (void) setLinkColor:(UIColor*) linkColor withRange:(NSRange) range;

@end



