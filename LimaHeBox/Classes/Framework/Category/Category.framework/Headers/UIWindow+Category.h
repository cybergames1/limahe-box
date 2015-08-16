//
//  UIWindow+Category.h
//  Demo
//
//  Created by Sean on 15/6/4.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (UIWindowShortCut)

/**
 @details 获取当前App处于最上层的window
 <li> 包括mainWindow、键盘UIKeyBoard、UIAlert、UIActionSheet，但排除UIStatusBar等高度不足100的Window
 <li> 使用场景：用于显示提示框
 */
+ (UIWindow*) visibleWindow;

@end
