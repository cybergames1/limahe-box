//
//  QYSegmentControl.h
//  QiYIShareKit
//
//  Created by jianting on 13-8-23.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    QYSegmentControlItemStyleDefault,     //默认风格，只有图片或标题，并且居中
    QYSegmentControlItemStyleHorizontal,  //图片和标题并存，且位横向的左右风格，图片左，标题右
    QYSegmentControlItemStyleVertical,    //竖向的上下风格，图片上，标题下
} QYSegmentControlItemStyle;

@interface QYSegmentControl : UIControl

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, assign) QYSegmentControlItemStyle itemStyle;

/**
 @description 以标题或图片初始化
 @param items 是标题或图片数组
 */
- (id)initWithItems:(NSArray *)items;

/**
 @description 如果是以标题初始化的，可以设置图片
 @param images 是图片数组，如果该数组小于初始化的数组，则不够的图片置空；相反，则截去多余的图片
 */
- (void)setImages:(NSArray *)images;

/**
 @description 设置某一item的图片
 @param image 要设置的图片
 @param index 要设置的item在control中的位置
 @param state 对应UIControlState的状态
 */
- (void)setImage:(UIImage *)image atIndex:(NSInteger)index forState:(UIControlState)state;

/**
 @description 以图片初始化的，可以设置标题
 @param titles 标题数组，原理同setImages:
 */
- (void)setTitles:(NSArray *)titles;

/**
 @description 设置某一item的标题，state状态默认为UIControlStateNormal
 */
- (void)setTitle:(NSString *)title atIndex:(NSInteger)index;

/**
 @description 设置某一item的标题，原理同setImage:atIndex:
 */
- (void)setTitle:(NSString *)title atIndex:(NSInteger)index forState:(UIControlState)state;

/**
 @description 设置标题颜色,默认未选中是灰色，选中是绿色
 */
- (void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state;

/**
 @description 设置标题行数，默认是一行
 */
- (void)setTitleLine:(NSInteger)line;

/**
 @description 设置标题字体,默认14号字体
 */
- (void)setTitleFont:(UIFont *)font;

/**
 @description 自定义背景图片，有默认背景图，在没有自定义背景时显示默认背景
 @param backgroundImages 背景图片组，最多为三个，即左中右
 @param state 对应UIControlState的几个状态
 */
- (void)setBackgroundImages:(NSArray *)backgroundImages forState:(UIControlState)state;

@end
