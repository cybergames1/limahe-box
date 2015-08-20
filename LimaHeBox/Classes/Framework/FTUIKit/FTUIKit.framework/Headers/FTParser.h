//
//  FTParser.h
//  ActionLabel
//
//  Created by Sean on 13-9-22.
//  Copyright (c) 2013年 Sean. All rights reserved.
//

/*!
 
   富文本解析器，根据text及parserType的不同解析出链接，目前支持。可以单独调用，也可以配合UILabel使用 
 你需要在工程中引入<CoreText/CoreText.h>、<CoreText/CoreText.h>
 
 1、<普通人名>，格式：<张三>
 2、@人名，格式：@张三
 3、#话题#，格式：#今天天气不错#
 4、URL链接，格式：http://www.iqiyi.com
 5、数字（电话、日期等），格式：20130922，18601020304
 6、自定义类型
*/

#import "FTDefine.h"

@class FTParser;
#if NS_BLOCKS_AVAILABLE
typedef void (^FTBasicBlock)(void);
// 完成回调
typedef void (^FTParseSuccessBlock)(FTParser *parser);
#endif

@interface FTParser : NSObject
<NSCopying>
{
#if NS_BLOCKS_AVAILABLE
    FTParseSuccessBlock successBlock;
#endif
}
/**
 根据默认的参数得到parser的快捷方式
 @node 如果需要parser多条数据（比如在tableview中），在调用parseCoreTextData:
       之后，你需要把 [parser copy]存储起来，而不是存储parser，因为每次解析数据后，都会改变parser
       里面的值
 */
+ (FTParser*) defaultParser;

/**
 返回解析后的attributedString(NSAttributedString)字符串
 @node 该字符串包括布局后的所有信息，可以付给UILabel使用，但是没法处理点击事件
 */
@property (nonatomic, readonly) NSAttributedString* attributedString;
 /**
  如果有超链接，返回超链接数组
  */
@property (nonatomic, readonly) NSMutableArray *hyperLinks;
 /**
  frameRef,coretext显示使用
  */
@property (nonatomic, readonly) CTFrameRef frameRef;


@end

#pragma mark FTParser (ParserTextStyle)
@interface FTParser (ParserTextStyle)
/**
 文本行间距，默认0
*/
@property (nonatomic, assign) CGFloat lineSpace;
/**
 首行缩进距离，默认0
*/
@property (nonatomic, assign) CGFloat firstLineHeadIndent;
/**
 最小文本行间距，默认0
*/
@property (nonatomic, assign) CGFloat minLineSpace;
/**
 最大文本行间距，默认9
*/
@property (nonatomic, assign) CGFloat maxLineSpace;
/**
 文本字间距，默认0
*/
@property (nonatomic, assign) CGFloat characterSpace;
/**
 文本段间距，默认0
*/
@property (nonatomic, assign) CGFloat paragraphSpace;
/**
 文本字数限制，0表示不做限制，否则传最大个数,默认为0
*/
@property (nonatomic, assign) NSInteger textCountLimit;

/**
 文本上边距，默认0
*/
@property (nonatomic, assign) CGFloat paddingTop;
/**
 文本左边距，默认0
*/
@property (nonatomic, assign) CGFloat paddingLeft;
/**
 文本下边距，默认0
*/
@property (nonatomic, assign) CGFloat paddingBottom;
/**
 文本右边距，默认0
*/
@property (nonatomic, assign) CGFloat paddingRight;
/**
 文本对齐模式，默认kCTTextAlignmentLeft
*/
@property (nonatomic, assign) CTTextAlignment textAlignment;
/**
 文本换行模式，默认kCTLineBreakByCharWrapping
*/
@property (nonatomic, assign) CTLineBreakMode textLineBreakMode;


@end

#pragma mark FTParser (ParserFontSet)
@interface FTParser (ParserFontSet)
// font
/**
 字体字号大小，默认15
*/
@property (nonatomic, assign) CGFloat fontSize;
/**
 超链接字号大小，默认15
*/
@property (nonatomic, assign) CGFloat hyperLinkFontSize;
/**
 字体名字，默认“Helvetica”
*/
@property (nonatomic, copy)   NSString *fontName;
/**
 超链接字体名字，默认自动与fontName相同
*/
@property (nonatomic, copy)   NSString *hyperLinkFontName;          

@end

#pragma mark FTParser (ParserColorSet)
@interface FTParser (ParserColorSet)
// color
/**
 普通文本颜色，默认blackColor
*/
@property (nonatomic, retain) UIColor *textColor;
/**
 超链接颜色，默认（182, 41, 52）
*/
@property (nonatomic, retain) UIColor *hyperLinkColor;
/**
 超链接点中后的阴影颜色，默认（171, 171, 171）,为nil则不显示阴影
*/
@property (nonatomic, retain) UIColor *hyperLinkShadowColor;
/**
 链接点中高亮颜色，默认（255, 255, 255）
*/
@property (nonatomic, retain) UIColor *highlightedHyperLinkColor;

// background
/**
 点击后的背景图片，如果设置，优先显示图片背景
*/
@property (nonatomic, retain) UIImage *backGroundImage;
/**
 点击后的背景颜色，默认whiteColor
*/
@property (nonatomic, retain) UIColor* backGroundColor;

@end

#pragma mark FTParser (ParserText)
/*!
 FTParser (ParserText)
 */
@interface FTParser (ParserText)
/**
 超链接parse类型，默认TParseTypeNone
*/
@property (nonatomic, assign) TParseType parseType;
/**
 自定义parse类型，仅对TParseTypeCustom和TParseTypeAll有效
 @node 如果需要解析的超链接类型比较复杂或者想使用自定义的类型，
       可以把定义好的类型数组通过customExpressions赋给parser。
       关于如何创建自定义expreseeion，请@see FTExpression
*/
@property (nonatomic, copy) NSArray* customExpressions;

/**
 布局完成后，最终文本高度
*/
@property (nonatomic, readonly) CGFloat totleHeight;
/**
 文本布局最大宽度，默认屏幕尺寸宽度
 该宽度包括左、右两侧预留的空白。所以最小值要大于paddingLeft+paddingRight
*/
@property (nonatomic, assign) CGFloat textMaxWidth;

/**
 调用该方法让parser异步解析文本，并通过block反馈给调用者
 如果解析完成，block返回带有全部信息的FTParser
 如果解析失败，block=nil
 */
- (void) parseText:(NSString*) text
       finishBlock:(FTParseSuccessBlock) block;

/**
 调用该方法让parser同步解析文本，结果不做回调
 比如用在tableView的cell里,使用这个方法做draw前的预处理，可以增加draw的速度
*/
- (void) parseCoreTextData:(NSString*) content;

/**
 用默认的参数设置同步解析文本，使用这个方法做draw前的预处理，可以增加draw的速度
 @node 关于默认参数设置，参见各个参数的说明
 @return 返回解析后的parser，parser中放有与布局及action相关的所有信息
 */
+ (FTParser*) parseTextData:(NSString*) content;
@end










