//
//  UIScreen+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark UIScreen (ShortCut)
@interface UIScreen (UIScreenShortCut)
/**
 整个屏幕的宽
 @details 这个API得到的是整个屏幕的尺寸
 */
+ (CGFloat) mainScreenWidth;
/**
 整个屏幕的高
 @details 这个API得到的是整个屏幕的尺寸
 */
+ (CGFloat) mainScreenHeight;

/**
 应用展示屏幕的宽
 @details 应用窗口实际的宽。如果导航条隐藏，那么
 返回值与 mainScreenWidth 相同
 */
+ (CGFloat) applicationScreenWidth;
/**
 应用展示屏幕的高
 @details 应用窗口实际的高。如果导航条隐藏，那么
 返回值与 mainScreenHeight 相同
 */
+ (CGFloat) applicationScreenHeight;
@end



