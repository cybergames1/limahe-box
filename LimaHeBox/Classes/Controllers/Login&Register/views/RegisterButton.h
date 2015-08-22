//
//  RegisterButton.h
//  Papaqi
//
//  Created by jianting on 15/8/4.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterButton : UIButton

/* 固定宽度的长绿色条
 * 只需要传相对于view所在frame的top即可
 */
+ (RegisterButton *)showGreenInView:(UIView *)view
                                top:(CGFloat)top
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

/* 自定义frame的绿色条 */
+ (RegisterButton *)showGreenInView:(UIView *)view
                              frame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

//白色同理
+ (RegisterButton *)showWhiteInView:(UIView *)view
                                top:(CGFloat)top
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

+ (RegisterButton *)showWhiteInView:(UIView *)view
                              frame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

//蓝色
+ (RegisterButton *)showBlueInView:(UIView *)view
                             frame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

@end
