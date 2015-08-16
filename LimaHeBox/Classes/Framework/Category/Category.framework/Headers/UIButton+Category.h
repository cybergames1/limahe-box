//
//  UIButton+Category.h
//  Demo
//
//  Created by Sean on 15/6/4.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButtonShortCut)
/**
 根据 title 名字和颜色快捷初始化一个 UIButton
 */
+ (UIButton*) buttonWithTitle:(NSString*) title color:(UIColor*) color;

/**
 根据按钮图片image和高亮图片highlightImage快捷初始化一个 UIButton
 */
+ (UIButton*) buttonWithImage:(UIImage*) image highlightImage:(UIImage*) highlightImage;

/**
 根据按钮事件 target 和 seletor快捷初始化一个 UIButton
 */
+ (UIButton*) buttonWithTarget:(id) target actionSeletor:(SEL) seletor;

@end

#pragma mark - UIBarButtonItem
@interface UIBarButtonItem (BackBarButtonItem)
/**
 
 */
+ (UIBarButtonItem*) backBarButtonItemWithTitle:(NSString*) title
                                         target:(id) target
                                         action:(SEL)action;

/**
 
 */
+ (UIBarButtonItem*) backBarButtonItemWithTitle:(NSString*) title
                                      iconImage:(UIImage*) image
                                 highlightImage:(UIImage*) highlightImage
                                         target:(id) target
                                         action:(SEL)action;

/**
 
 */
+ (UIBarButtonItem*) backBarButtonItemWithTitle:(NSString*) title
                                      titleFont:(UIFont*) titleFont
                                     titleColor:(UIColor*) titleColor
                            highlightTitleColor:(UIColor*) highlightColor
                                      iconImage:(UIImage*) image
                                 highlightImage:(UIImage*) highlightImage
                                         target:(id) target
                                         action:(SEL)action;

+ (UIFont*)  customBarButtonItemFont;
+ (UIColor*) customBarButtonItemColor;
+ (UIColor*) customBarButtonItemHighlightColor;
@end










