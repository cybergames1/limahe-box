//
//  RLCell.h
//  Papaqi
//
//  Created by jianting on 15/8/9.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RLCell : UIView

@property (nonatomic, retain) UILabel * titleLabel;
@property (nonatomic, retain) UITextField * textField;
@property (nonatomic, retain) UIView * rightView;

/*
 * 在Cell上添加点击事件，此时textField只做显示，无法输入
 */
- (void)addTarget:(id)target action:(SEL)action;

@end
