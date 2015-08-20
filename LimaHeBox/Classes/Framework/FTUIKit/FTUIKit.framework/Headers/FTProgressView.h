//
//  FTProgressView.h
//  QiYIShareKit
//
//  Created by Sean on 12-12-27.
//  Copyright (c) 2012年 iQiYi. All rights reserved.
//

/*!
 自定义样式的进度条，支持自定义样式和经典样式
 
 todo:支持分段进度
*/

#import "FTDefine.h"

@interface FTProgressView : UIView
/**
 @details 填充主体颜色(进度条的颜色),default=[UIColor blueColor]
 */
@property (nonatomic, retain) UIColor* progressColor;

/**
 @details 未填充部分的颜色,如果不设置，默认[UIColor grayColor]
 */
@property (nonatomic, retain) UIColor* trackColor;

 /**
  @details 边线宽度（进度条的宽度）
  @note 对于FTProgressViewStyleBar，默认0.0。该值的2倍不能多于本身的高度。
  @note 对于FTProgressViewStyleCircle，默认0.0
  @note 对于FTProgressViewStylePieChart，默认0.0
  @note 对于FTProgressViewStyleBar不起作用
  */
@property (nonatomic, assign) CGFloat borderWidth;

 /**
  @details 进度类型,默认圆柱状横条样式FTProgressViewStyleBar
  */
@property (nonatomic, assign) FTProgressViewStyle progressViewStyle;

/**
 进度条两端样式：圆角、平齐，默认FTProgressViewLineCapTypeRound
 @note 该参数仅对FTProgressViewStyleBar和FTProgressViewStyleCircle有效
 */
@property (nonatomic, assign) FTProgressViewLineCapType lineCap;

 /**
  @details 设置进度，没有动画
  */
@property (nonatomic, assign) CGFloat progress;

/**
 @details 更新时时进度
 @param progress 时时进度
 @param animated 是否需要动画
 */
- (void) updateProgress:(CGFloat) progress animated:(BOOL) animated;

 /**
  @details 未开始隐藏进度条,default=YES
  */
@property (nonatomic, assign) BOOL hidesUntilStart;

/**
 @details init
 */
- (id) initWithFrame:(CGRect)frame progressStyle:(FTProgressViewStyle) style;

@end

@interface FTProgressView (FTProgressViewCircle)
/**
 @details 环形进度条的宽度，默认2.0
 @note 该属性仅对FTProgressViewStyleCircle有效
 */
@property (nonatomic, assign) CGFloat circleWidth;

@end

@interface FTProgressView (FTProgressViewImage)
/**
 @details 自定义背景图片，仅对FTProgressViewStyleImage有效
 */
@property (nonatomic, retain) UIImage* backgroundImage;

/**
 @details 自定义进度图片，仅对FTProgressViewStyleImage有效
 */
@property (nonatomic, retain) UIImage* progressImage;

@end


