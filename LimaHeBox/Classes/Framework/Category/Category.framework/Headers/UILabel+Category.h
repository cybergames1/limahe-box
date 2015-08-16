//
//  UILabel+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

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

#pragma mark UILabel （MutableFontColorLabel）设置部分文本字体、颜色
@interface UILabel (MutableFontColorLabel)
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
- (void) setColor:(UIColor*) color font:(UIFont*) font fromIndex:(NSInteger) from;

/**
 为label的部分设置特定颜色和字体
 @node 需要在设置text后使用该方法
 @param color 指定的颜色
 @param font 指定的字体
 @param to  结束的范围，该范围不能超出label文本的总长度
 */
- (void) setColor:(UIColor*) color font:(UIFont*) font toIndex:(NSInteger) to;

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
 @note 该方法需要setText:之后使用，否则不起作用。
 */
- (void) applyParagraphStyle;

/**
 设置文本行间距，可正可负，正值增加行距，负值减小行距。
 */
- (void) setLineSpace:(CGFloat) lineSpace;

/**
 调整行距倍数，该参数不会改变实际上字体大小，改变的是行间距，默认0.0
 */
- (void) setLineHeightMultiple:(CGFloat) lineHeightMultiple;

/**
 设置首行缩进的距离(像素)。不能为负值，默认0.
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
 @details 若其值小于默认行高，则行间距变小，若其值大于默认行高，则不会引起任何变化
 @note 如果设置了该属性，字体类型不同的各个文字都会具有相同的行高。如果该行有图片等内容，
       其高度也会遵循该最低高度
 */
- (void) setMaximumLineHeight:(CGFloat) maximumLineHeight;
/**
 针对不同的字型与字号，可以透过指定最小行距(minimumLineHeight)来避免过高或过窄的状况发生。
 @details 若其值大于默认行高，则行间距变大，若其值小于默认行高，则不会引起任何变化
 @note 如果设置了该属性，字体类型不同的各个文字都会具有相同的行高。如果该行有图片等内容，
       其高度也会遵循该最低高度
 */
- (void) setMinimumLineHeight:(CGFloat) minimumLineHeight;

/**
 指定当前段落与其下面段落的距离,非负值
 @details 如果设置了paragraphSpacingBefore，是从paragraphSpacingBefore算起的距离。
 */
- (void) setParagraphSpace:(CGFloat) paragraphSpace;
/**
 当前段落顶部与该段落内容之间的距离(像素值)，默认值为0
 @details 显示上为段落内容以上部分的空白的高度
 */
- (void) setParagraphSpacingBefore:(CGFloat) paragraphSpacingBefore;

@end


#pragma mark UILabel （ActionLabel）label响应点击事件
/*! 需要导入头文件<CoreText/CoreText.h> */

@interface UILabel (ActionLabel)

/** 当前正在点中的链接文本 */
@property (nonatomic,readonly) NSString* activiteLinkText;

/**
 @details 给整个label增加点击方法，链接颜色为textColor，高亮颜色highlightTextColor。
          可以通过[setLinkColor:highlightColor:range:]设置链接颜色和高亮颜色

 @node 需要在设置text后使用该方法，如果highlightTextColor没有指定，则默认为grayColor
 @param target 相应的target，不能为nil
 @param action action方法，最多可带一个参数

 */
- (void) addTarget:(id)target action:(SEL)action;

/**
 @brief 给UILabel的部分text增加点击方法，链接颜色为textColor，高亮颜色highlightTextColor。
          可以通过[setLinkColor:highlightColor:range:]设置链接颜色和高亮颜色
 
 @param target 相应的target，不能为nil
 @param action action方法，最多可带一个参数
 @param linkRange 链接文本的范围。该范围需要真实有效。
 
 @node 需要在设置text后使用该方法，如果highlightTextColor没有指定，则默认为grayColor
 <li> 以下代码可以让文本“超链接”可以点击
 @code
   myLabel.text = @"这是一个含有超链接的文本";
   [myLabel addTarget:self action:@selector(myLabelAction:) range:NSMakeRange(6,3)];
   [myLabel setLinkColor:[UIColor blueColor] highlightColor:[UIColor grayColor] range:NSMakeRange(6,3)];
 @endcode
 */
- (void) addTarget:(id)target action:(SEL)action range:(NSRange) linkRange;

/**
 @brief 给UILabel的部分text增加点击方法，高亮颜色highlightTextColor。
        可以通过[setLinkColor:highlightColor:range:]设置链接颜色和高亮颜色
 
 @param target 相应的target，不能为nil
 @param action action方法，最多可带一个参数
 @param linkColor 链接的颜色，如果传 nil，默认使用 textColor
 @param linkRange 链接文本的范围。该范围需要真实有效。
 
 @node 需要在设置text后使用该方法，如果highlightTextColor没有指定，则默认为grayColor
 */
- (void) addTarget:(id)target action:(SEL)action
             color:(UIColor*) linkColor range:(NSRange) linkRange;

/**
 @brief 为label的可点部分（超级链接）设置颜色
 
 @param linkColor 指定的颜色
 @param range 指定的范围，该范围不能超出label文本的总长度
 
 @note 需要在设置text后使用该方法
 @details 如果文本的部分为可点链接，可以通过这句API设置特殊点击颜色
 */
- (void) setLinkColor:(UIColor*) linkColor range:(NSRange) range;

/**
 @brief 为label的可点部分（超级链接）设置颜色

 @param linkColor 指定的颜色
 @param highlightColor 链接点中后的高亮颜色
 @param range 指定的范围，该范围不能超出label文本的总长度
 
 @note 需要在设置text后使用该方法
 @note 如果不单独设置链接颜色，默认使用textColor颜色。
 */
- (void) setLinkColor:(UIColor*) linkColor highlightColor:(UIColor*) highlightColor range:(NSRange) range;

@end

/** 文字链接block */
typedef void(^UILabelActionBlock)(NSString* linkText);

/*!
 当前支持的连接类型: NSTextCheckingTypeDate,               //日期
                  NSTextCheckingTypeAddress,            //地址
                  NSTextCheckingTypeLink,               //URL链接
                  NSTextCheckingTypePhoneNumber,        //数字
                  NSTextCheckingTypeTransitInformation  //交通方案
 */
@interface UILabel (UILabelDataDetector)

/**
 点中后的block回调
 */
@property (nonatomic, copy) UILabelActionBlock actionBlock;

/** 
 自动检测链接并标记链接颜色
 @param checkingType 需要标记的链接类型
 @param linkColor 链接未点中状态的颜色
 
 @note 链接点中后的颜色使用highlightedTextColor（如果没有设置，默认使用cyanColor）
 */
- (void) autoTextDetector:(NSTextCheckingType) checkingType
                linkColor:(UIColor*) linkColor;

/**
 自动检测链接并标记链接颜色
 @param checkingType 需要标记的链接类型
 @param linkColor 链接未点中状态的颜色
 @param highlightColor 链接点中状态的颜色
 */
- (void) autoTextDetector:(NSTextCheckingType) checkingType
                linkColor:(UIColor*) linkColor
           highlightColor:(UIColor*) highlightColor;
@end

