//
//  FTKit.h
//  ActionLabel
//
//  Created by Sean on 13-11-16.
//  Copyright (c) 2013年 Sean. All rights reserved.
//
/*!
 @details 该框架实现了以下功能：
         1、解析各种连接（支持自定义），文本支持可点（带超链接的UILabel）
         2、pageControl支持自定义颜色、大小的dot，并且dot可以是图片（对照UIPageControl）
         3、带placeholder，并且高度自动调整的textField（对照UITextField）
         4、样式可以自定义的BadgeView
         5、可以自定义样式的progressView
         6、支持循环滚动的scrollView（内存复用）
 
 @Node 1、需要引入框架<CoreText/CoreText.h>
       2、支持armv7、armv7s、armv64.
       3、请在IOS6及以上的系统中使用
 */
#import "FTActionLabel.h"
#import "FTParser.h"
#import "FTBadgeView.h"
#import "FTPageControl.h"
#import "FTProgressView.h"
#import "FTScrollView.h"
#import "FTInputView.h"
#import "FTHyperLink.h"