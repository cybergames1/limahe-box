//
//  BoxSuperViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BackButtonHandler.h"
#import <Category/Category.h>
#import "CommonTools.h"

/**
 * 所有ViewController的super
 * 完成一些基本的架构，如navigationbar的控制等
 */

@interface BoxSuperViewController : UIViewController

/* 导航条的颜色 */
@property (nonatomic, retain) UIColor * navigationBarTintColor;

/**
 设置navigationBar的左右itemView
 */
- (void)setNavigationItemLeftImage:(UIImage *)image;
- (void)setNavigationItemRightImage:(UIImage *)image;
- (void)setNavigationItemRightTitle:(NSString *)title;

/**
 设置navigationBar的titleView
 */
- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationImage:(UIImage *)image;

/* 设置返回按钮的标题 */
- (void)setNavigationBackTitle:(NSString *)title;

- (void)leftBarAction;
- (void)rightBarAction;

@end

@interface BoxSuperViewController (BadgeNumber)

- (void)setShowBadgeView:(BOOL)isShow;
- (void)setBadgeNumber:(NSInteger)badgeNumber;

@end

@interface BoxSuperViewController (ShowHud)

/**
 显示Indicator(菊花)提示，不是自动消失，show和hide配对出现
 */
- (void) showIndicatorHUDView:(NSString *) message;
/**
 隐藏Indicator(菊花)提示
 */
- (void) hideIndicatorHUDView;

/**
 隐藏所有的 HUD
 */
- (void) hideAllHUDView;

@end

@interface BoxSuperViewController (Device)

- (BOOL)checkDeviceIsOnline;

@end
