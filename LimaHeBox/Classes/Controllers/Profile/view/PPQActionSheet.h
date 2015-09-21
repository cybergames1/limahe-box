//
//  PPQActionSheet.h
//  PaPaQi
//
//  Created by Sean on 15/8/10.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPQActionSheet : UIView

@property (nonatomic, retain) UIView * contentView;

- (void)showInView:(UIView *)view;

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated
                          finishBlock:(void (^)(void)) finish;

@end
