//
//  CategoryDefine.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

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
    
    TransitionTypeRotationFromLeft = 10086,
    TransitionTypeRotationFromRight,
    
    TransitionTypeFadeOut ,//渐隐渐现
};

/* 时间单元的定义 */
#define CG_MINUTE    60.0        //1分钟
#define CG_HOUR      3600.0      //1小时
#define CG_DAY       86400.0     //1天
#define CG_WORKDAY   432000.0    //5天
#define CG_WEEK      604800.0    //1个周
#define CG_MONTH     2635200.0   //1个月
#define CG_YEAR      31556926.0  //1年
#define CG_NSEC_PER_SEC 1000000000ull

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
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

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

//返回NSString类型的结果
#define StringValue(object) [NSString stringValue:object]

//返回特定的随机数
#define RandomString(length) [NSString randomString:length]
#define RandomNumberString(length) [NSString randomNumberString:length]

//打印Log
#ifdef DEBUG
#define DebugLog(fmt...) CategoryToolsLog(__FUNCTION__,__LINE__,fmt)
#else
#define DebugLog(fmt...) 
#endif

//打印 Log 信息
#define PrintDebugLog(fmt...) CategoryToolsLog(__FUNCTION__,__LINE__,fmt)

