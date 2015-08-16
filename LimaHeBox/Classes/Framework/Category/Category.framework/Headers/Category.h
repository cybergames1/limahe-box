//
//  Category.h
//  ActionLabel
//
//  Created by Sean on 14-3-24.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

/*!
 @Node
 1、支持armv7、armv7s、armv64.
 2、请在IOS6及以上的系统中使用
 3、支持ARC
 */

// Foundation
#import "NSArray+Category.h"
#import "NSData+Category.h"
#import "NSDate+Category.h"
#import "NSDictionary+Category.h"
#import "NSNumber+Category.h"
#import "NSObject+Category.h"
#import "NSString+Category.h"
#import "NSURL+Category.h"

// UIKit
#import "UIApplication+Category.h"
#import "UIAlertView+Category.h"
#import "UIActionSheet+Category.h"
#import "UIButton+Category.h"
#import "UIColor+Category.h"
#import "UIDevice+Category.h"
#import "UIImage+Category.h"
#import "UIImageView+Category.h"
#import "UILabel+Category.h"
#import "UIScreen+Category.h"
#import "UIScrollView+Category.h"
#import "UITableViewCell+Category.h"
#import "UIView+Category.h"
#import "UIViewController+Category.h"
#import "UIWindow+Category.h"


// tools
#import "CategoryDefine.h"
#import "CategoryTools.h"
#import "SHProgressHUD.h"

/**
             iphone5（s）   iphone6   iPhone Plus
像素分辨率      640*1136     750*1334  1080*1920
逻辑分辨率      320*568      375*667   414*736
PPI             326          326        401
DPI             163          163        154 
 */

/**
 注释说明
 
 @abstract
 @attention 给出适当的注意事项
 @brief 简要说明
 @code, @endcode 若希望在帮助中引用代码，可以将代码插入以上两个tag之间（多行）
 @details 详细说明
 @discussion 详细讨论细节
 <li> 给内容的前面加一个强调的黑圆点“•”
 @method
 @param 函数参数
 @post 后置条件
 @pre 前置条件
 @return 函数返回值，可多次使用
 @see 引用
 @warning 给出适当的警告
 
 */


/**
 制作统一framework库
 
 lipo -create /Users/yourPC/Desktop/Release-iphoneos/FTUIKit.framework/FTUIKit /Users/yourPC/Desktop/Release-iphonesimulator/FTUIKit.framework/FTUIKit -output /Users/yourPC/Desktop/FTUIKit
 
 然后替换用新的FTUIKit替换Release-iphoneos/FTUIKit.framework/FTUIKit即可
 */

/**
 在编写子类的时候要重载父类的方法，不然将无法完成操作，我们可以通过把这段代码写到父类里面提醒添加
 
 [NSException raise:NSInternalInconsistencyException format:@"It's an exception", NSStringFromSelector(_cmd)];
 */


