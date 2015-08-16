//
//  UIScreen+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark UIScreen (ShortCut)
@interface UIScreen (UIScreenShortCut)
/**
 整个屏幕的宽
 @details 这个API得到的是整个屏幕的尺寸
 @note <b style="color:#ff0000"> 屏幕宽度不会随设备的翻转发生改变，在任何情况下都是固定值 </b>
 */
+ (CGFloat) mainScreenWidth;
/**
 整个屏幕的高
 @details 这个API得到的是整个屏幕的尺寸
 @note <b style="color:#ff0000"> 屏幕高度不会随设备的翻转发生改变，在任何情况下都是固定值 </b>
 */
+ (CGFloat) mainScreenHeight;

/**
 应用展示屏幕的宽，固定值
 @details 应用窗口实际的宽。如果导航条隐藏，那么返回值与 mainScreenWidth 相同
 */
+ (CGFloat) applicationScreenWidth;
/**
 应用展示屏幕的高，固定值
 @details 应用窗口实际的高。如果导航条隐藏，那么返回值与 mainScreenHeight 相同
 */
+ (CGFloat) applicationScreenHeight;
@end



