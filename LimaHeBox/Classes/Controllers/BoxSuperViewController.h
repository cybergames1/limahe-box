//
//  BoxSuperViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxSuperViewController : UIViewController

/* 导航条的颜色 */
@property (nonatomic, retain) UIColor * navigationBarTintColor;

- (void)setNavigationItemLeftImage:(UIImage *)image;
- (void)setNavigationItemRightImage:(UIImage *)image;

@end
