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

- (void)setNavigationItemLeftImage:(UIImage *)image;
- (void)setNavigationItemRightImage:(UIImage *)image;

- (void)setNavigationTitle:(NSString *)title;
- (void)setNavigationImage:(UIImage *)image;

/* 设置返回按钮的标题 */
- (void)setNavigationBackTitle:(NSString *)title;

@end
