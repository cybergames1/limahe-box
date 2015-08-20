//
//  FTBadgeView.h
//  QiYIShareKit
//
//  Created by Sean on 13-1-4.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//
/*！
 @brief 显示badge的view，
        1、绿色的背景，白色的数据
        2、自动拉伸以适应数字的长度
 */
#import "FTDefine.h"

@interface FTBadgeView : UIImageView

/**
 badge value,inter value
 @details 对于FTBadgeStyleDot类型，
          设置badgeValue不会显示数字，但是会显示badge。
          而且badgeValue=0时badge消失
 */
@property (nonatomic, assign) NSInteger badgeValue;

/**
 badge限制，超过这个数显示（***+），默认99.
 仅对FTBadgeStyleNumber有效
 */
@property (nonatomic, assign) NSInteger badgeLimit;

@end

@interface FTBadgeView (BadgeBackGround)
/**
 自定义背景图片
 */
@property (nonatomic, copy) UIImage* backgroundImage;

@end

@interface FTBadgeView (BadgeFontAndColor)

/**
 字体名称,默认 Arial，仅对FTBadgeStyleNumber有效
 */
@property (nonatomic, copy) NSString* fontName;

/**
 字体字号,默认 13.0，仅对FTBadgeStyleNumber有效
 */
@property(nonatomic, assign) CGFloat fontSize;

/**
 文本左右两边预留的间隔,默认3.0，仅对FTBadgeStyleNumber有效
 */
@property (nonatomic, assign) CGFloat textLeftOriginSpace;

/**
 字体颜色,默认 whiteColor，仅对FTBadgeStyleNumber有效
 */
@property(nonatomic, retain) UIColor* textColor;

@end

@interface FTBadgeView (BadgeStyle)
/**
 自适应模式，决定文本较多时的扩展方向，默认 BadgeAutoFitRight
 */
@property(nonatomic,assign) FTBadgeAutoFit autoFit;

/**
 badge样式，默认 FTBadgeStyleNumber
 */
@property(nonatomic,assign) FTBadgeStyle badgeStyle;

/**
 badge图片在拉伸时edgeInsets,取值和customImage尺寸有关
 如果image尺寸在width，height，默认UIEdgeInsetsMake(width/4, height/4, width/4 + 1, height/4 + 1)
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 左上角的坐标，将决定badge的位置,默认 CGPointZero
 */
@property (nonatomic, assign) CGPoint leftTopPoint;

/**
 init with leftTopPoint
 */
- (id) initWithLeftTopPoint:(CGPoint) point;
/**
 init with badgeStyle
 */
- (id) initWithBadgeStyle:(FTBadgeStyle) badgeStyle;

@end
