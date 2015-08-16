//
//  CategoryDefine.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSString+Category.h"
#import "UIScreen+Category.h"
#import "UIColor+Category.h"
#import "UIDevice+Category.h"
#import "CategoryTools.h"

#pragma mark TransitionType
typedef NS_ENUM(NSInteger, TransitionType)
{
    TransitionTypeNone = UIViewAnimationOptionTransitionNone, //没有任何特效
    
    TransitionTypeFlipFromLeft = UIViewAnimationOptionTransitionFlipFromLeft ,//从左向右翻转
    TransitionTypeFlipFromRight = UIViewAnimationOptionTransitionFlipFromRight,//从右向左翻转
    TransitionTypeFlipFromTop = UIViewAnimationOptionTransitionFlipFromTop ,//从上向下翻转
    TransitionTypeFlipFromBottom = UIViewAnimationOptionTransitionFlipFromBottom ,//从下向上翻转
    
    TransitionTypeCurlUp = UIViewAnimationOptionTransitionCurlUp , //
    TransitionTypeCurlDown = UIViewAnimationOptionTransitionCurlDown ,//
    
    TransitionTypeCrossDissolve = UIViewAnimationOptionTransitionCrossDissolve ,//
    
    TransitionTypeRotationFromLeft = 10010,
    TransitionTypeRotationFromRight = 10086,
    
    TransitionTypeFadeOut ,//渐隐渐现
};

#pragma mark number 2 Emoji
/** 将数字转为Emoji
 <code>
     int sym = EMOJI_CODE_TO_SYMBOL(0x1F600);
     NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
     NSLog(@"emoT=%@",emoT);
 </code>
 */
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

#pragma mark ARC
/** 对ARC与非ARC编译的支持 */
#ifndef APP_SUPPORT_ARC
#define APP_SUPPORT_ARC

//是否开启 ARC 的判断
#ifndef OBJC_ARC_ENABLED
    #ifdef __has_feature
        #define OBJC_ARC_ENABLED __has_feature(objc_arc)
    #else
        #define OBJC_ARC_ENABLED 0
    #endif
#endif

// property retain
#ifndef Category_STRONG
    #if __has_feature(objc_arc)
        #define Category_STRONG strong
    #else
        #define Category_STRONG retain
    #endif
#endif

// property assign
#ifndef Category_WEAK
    #if __has_feature(objc_arc_weak)
        #define Category_WEAK weak
    #elif __has_feature(objc_arc)
        #define Category_WEAK unsafe_unretained
    #else
        #define Category_WEAK assign
    #endif
#endif

// retain/release
#if __has_feature(objc_arc)
    #define OBJECT_AUTORELEASE(expression) expression
    #define OBJECT_RELEASE(expression) expression
    #define OBJECT_RETAIN(expression) expression
#else
    #define OBJECT_AUTORELEASE(expression) [expression autorelease]
    #define OBJECT_RELEASE(expression) [expression release]
    #define OBJECT_RETAIN(expression) [expression retain]
#endif

#endif // end for APP_SUPPORT_ARC

#pragma mark UILabel
extern CGFloat const MAX_LINE_HEIGHT;

#pragma mark GCD
/** GCD */
// background queue
#define Dispatch_Asy_Back(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
// main queue
#define Dispatch_Asy_Main(block) if([NSThread isMainThread]){block;}else{dispatch_async(dispatch_get_main_queue(),block);}

#pragma mark 由角度与弧度换算
//由角度与弧度换算
#define DegreesToRadian(x) ((M_PI*(x))/180.0)
#define RadianToDegrees(radian) ((radian)*(180.0/M_PI))

#pragma mark 系统剪贴板
//系统粘贴：文字、图片、URL
#define PasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define PasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];
#define PasteURL(url)         [[UIPasteboard generalPasteboard] setURL:url];

#pragma mark - 屏幕尺寸
//屏幕尺寸
#define kScreenWidth [UIScreen mainScreenWidth]
#define kScreenHeight [UIScreen mainScreenHeight]

#pragma mark 时间单元
/* 时间单元的定义 */
#define CG_MINUTE    60.0        //1分钟
#define CG_HOUR      3600.0      //1小时
#define CG_DAY       86400.0     //1天
#define CG_WORKDAY   432000.0    //5天
#define CG_WEEK      604800.0    //1个周
#define CG_MONTH     2635200.0   //1个月
#define CG_YEAR      31556926.0  //1年
#define CG_NSEC_PER_SEC 1000000000ull

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

// safe release
#define Safe_Release_Object(_object_) if(_object_) {[_object_ release]; _object_ = nil;}

// 16进制Color
#pragma mark UIColor （16进制Color）
/**
 16进制的color初始化，比如UIColorFrom16RGB(0xDDEEFF)
 */
#define UIColorFrom16RGB(rgbValue) [UIColor colorWithHex:rgbValue alpha:1.0]

/**
 10进制的color初始化
 */
#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]


#pragma mark 操作系统版本判断
// 判断是否IOS9
#define IOS9 [UIDevice IOS9System]

// 判断是否IOS8
#define IOS8 [UIDevice IOS8System]

// 判断是否IOS7
#define IOS7 [UIDevice IOS7System]

// 判断是否IOS6
#define IOS6 [UIDevice IOS6System]

// 判断是否低于IOS6
#define SystemLowerThanIOS6 [UIDevice SystemLowThanIOS6]

// 判断是否低于IOS7
#define SystemLowerThanIOS7 [UIDevice SystemLowThanIOS7]

// 判断是否低于IOS8
#define SystemLowerThanIOS8 [UIDevice SystemLowThanIOS8]

// 判断是否低于IOS9
#define SystemLowerThanIOS9 [UIDevice SystemLowThanIOS9]

#pragma mark Random
//返回NSString类型的结果
#define StringValue(object) [NSString stringValue:object]

//返回特定的随机数
#define RandomString(length) [NSString randomString:length]
#define RandomNumberString(length) [NSString randomNumberString:length]


#pragma mark Print debug
//打印Log
#ifdef DEBUG
#define DebugLog(fmt...) CategoryToolsLog(__FUNCTION__,__LINE__,fmt)
#else
#define DebugLog(fmt...) 
#endif

//打印 Log 信息
#define PrintDebugLog(fmt...) CategoryToolsLog(__FUNCTION__,__LINE__,fmt)

