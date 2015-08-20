//
//  FTDefine.h
//  ActionLabel
//
//  Created by Sean on 13-9-22.
//  Copyright (c) 2013年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#define kTextMaxLength 9999 //文本最大字数限制

/** 
 文本解析类型
 */
typedef NS_ENUM(NSInteger, TParseType){
    TParseTypeNone = -1,            // none
    TParseTypeUrl = 1,              // url，示例：http://******,不允许出现汉字和特殊编码字符
    
    TParseTypeAt = 2 << 1,          // @，示例：@***,只允许汉字、数字、英文和_，其他字符不兼容
    TParseTypeAtWithEmoji = 2 << 2, // @，示例：@***,允许汉字、Emoji、数字、英文和_，其他字符不兼容
    
    TParseTypeTopic = 3 << 1,         // ##，示例：#***#,只允许汉字、数字、英文和_，其他字符不兼容
    TParseTypeTopicWithEmoji = 3 << 2,// ##，示例：#***#,允许汉字、Emoji、数字、英文和_，其他字符不兼容
    
    TParseTypeName = 5 << 1,          // name，示例：<***>，只允许汉字、数字、英文、*和_，其他字符不兼容
    TParseTypeNameWithEmoji = 5 << 2, // name，示例：<***>，允许汉字、Emoji、数字、英文、*和_，其他字符不兼容
    
    TParseTypeNumber = 7 << 1,      // number，示例：12,要求最少2位
    TParseTypePhone = 7 << 2,       // telephone，示例：01012345678，（010）12345678，010-12345678
    TParseTypeMobile = 7 << 3,      // mobile，示例：8613012345678,(86)13012345678,(+86)13012345678,+8613012345678
    TParseTypeEmail = 7 << 4,       // email，示例：***@***.com
    TParseTypeDate = 7 << 5,        // date，示例：2013-01-01,12:10
    
    // all type
    TParseTypeAll = TParseTypeName|TParseTypeUrl|TParseTypeAt|TParseTypeTopic|TParseTypePhone|TParseTypeMobile|TParseTypeEmail|TParseTypeDate,
    
    TParseTypeCustom = 11 << 1,     // custom type
    TParseTypeDefault = TParseTypeNone,
} ;

/*
 FTScrollView滚动方向
 */
typedef NS_ENUM(NSInteger,FTScrollDirection){
    FTScrollDirectionLandscape,  //水平方向滚动
};

/*
 FTProgressView样式定义
 */
typedef NS_ENUM(NSInteger,FTProgressViewStyle) {
    FTProgressViewStyleBar = 1,       // (可以带圆角)圆柱形进度，默认灰色边框+填充为高亮灰色
    
    FTProgressViewStyleCircle = 10,   // 圆环形进度，顺时针增加
    
    FTProgressViewStylePieChart = 20, // 圆饼状进度，顺时针增加
    
    FTProgressViewStyleImage = 30,    // 图片样式，可以指定颜色或者图片，目前只支持长条状图片
} ;

/**
 进度条两端样式
 */
typedef NS_ENUM(NSInteger, FTProgressViewLineCapType) {
    FTProgressViewLineCapTypeRound,   //圆角样式
    FTProgressViewLineCapTypeButt,    //
    FTProgressViewLineCapTypeSquare,  //
};

// 输入框边框样式
typedef NS_ENUM(NSInteger, FTInputBorderStyle) {
    FTInputBorderStyleNone = 0,        //
    FTInputBorderStyleRoundedRect = 1, //
    FTInputBorderStyleCustom,          //
};

// 输入框placeholder位置样式
typedef NS_ENUM(NSInteger, FTPlaceholderStyle) {
    FTPlaceholderStyleTop = 0,        //
    FTPlaceholderStyleCenter = 1,     //
};

// 输入框自适应样式
typedef NS_ENUM(NSInteger, FTFitStyle) {
    FTFitStyleNone = 0,      // 高度保持不变，不做任何调整
    FTFitStyleUp =   1,      // 向上扩展，底部保持不变
    FTFitStyleDown = 2,      // 向下扩展，顶部左边保持不变
};

// FTBadge自适应模式
typedef NS_ENUM(NSInteger, FTBadgeAutoFit) {
    FTBadgeAutoFitLeft = 1, //向左扩充，当拉伸时，右边保持不变
    FTBadgeAutoFitRight = 2,//向右扩充，当拉伸时，左边保持不变
    FTBadgeAutoFitDefault = FTBadgeAutoFitRight,
};

// FTBadge样式
typedef NS_ENUM(NSInteger, FTBadgeStyle) {
    FTBadgeStyleNumber = 1,//显示数字类型的badge
    FTBadgeStyleDot    = 6,//显示一个点（图片/颜色），不显示数字
    
    FTBadgeStyleDefault = FTBadgeStyleNumber,
};

/*
 FTBadge常量定义
 */
#define kBadgeWidth 23.0
#define kBadgeHeight 23.0

//Color定义
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

// 获取系统版本
#define kSystemVertion [[UIDevice currentDevice] systemVersion]
// 判断系统是否低于IOS7
#define kSystemVertionLowThanIOS7 (NSOrderedAscending == [kSystemVertion compare:@"7.0" options:NSNumericSearch])?YES:NO
//加载bunder˙中的图片,name为图片全称
#define kImageNamed(name) [UIImage imageNamed:name]
//判断空字符串
#define kEmptyString(string) ([string length] <= 0)?YES:NO

//屏幕尺寸
#define KDefaultScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define kDefaultScreenHeight CGRectGetHeight([[UIScreen mainScreen] bounds])

#define FTLog(xx, ...)  NSLog(@"  %s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)



