//
//  RegisterButton.m
//  Papaqi
//
//  Created by jianting on 15/8/4.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import "RegisterButton.h"

#define Width_Rate (30.0/320.0)
#define Height_Rate (40.0/260.0)

#define GreenColor [UIColor colorWithRed:(56.0/255.0) green:(201.0/255.0) blue:(64.0/255.0) alpha:1.0]
#define DarkGreenColor [UIColor colorWithRed:(38.0/255.0) green:(140.0/255.0) blue:(45.0/255.0) alpha:1.0]
#define GrayColor [UIColor colorWithRed:(198.0/255.0) green:(198.0/255.0) blue:(198.0/255.0) alpha:1.0]

@interface RegisterButton ()

@property (nonatomic, retain) UIColor *normalColor;

@end

@implementation RegisterButton

- (void)dealloc {
    [_normalColor release];_normalColor = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
 * 目前只有绿色的条在setEnabled和setHighlighted有添加方法
 */
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (CGColorEqualToColor(_normalColor.CGColor, GreenColor.CGColor)) {
        self.backgroundColor = enabled ? GreenColor : GrayColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (CGColorEqualToColor(_normalColor.CGColor, GreenColor.CGColor)) {
        self.backgroundColor = highlighted ? DarkGreenColor : GreenColor;
    }
}

+ (RegisterButton *)showInView:(UIView *)view
               frame:(CGRect)frame
             title:(NSString *)title
        titleColor:(UIColor *)titleColor
   backgroundColor:(UIColor *)backgroundColor
        boardColor:(UIColor *)boardColor
            target:(id)target
            action:(SEL)action
{
    RegisterButton * button = [[RegisterButton alloc] initWithFrame:frame];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button setNormalColor:backgroundColor];
    [button setEnabled:NO];
    [button.layer setCornerRadius:frame.size.height/2.0];
    [button.layer setMasksToBounds:YES];
    [view addSubview:button];
    
    //有边框的加边框
    if (boardColor) {
        [button.layer setBorderColor:boardColor.CGColor];
        [button.layer setBorderWidth:1.0];
    }
    return [button autorelease];
}

+ (RegisterButton *)showGreenInView:(UIView *)view
                                top:(CGFloat)top
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action
{
    CGFloat width = CGRectGetWidth(view.frame)-2*Width_Rate*CGRectGetWidth(view.frame);
    CGRect rect = CGRectMake(CGRectGetWidth(view.frame)*Width_Rate, top, width, width*Height_Rate);
    return [RegisterButton showInView:view
                                frame:rect
                                title:title
                           titleColor:[UIColor whiteColor]
                      backgroundColor:GreenColor
                           boardColor:nil
                               target:target
                               action:action];
}

+ (RegisterButton *)showGreenInView:(UIView *)view
                              frame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action
{
    return [self showInView:view
                      frame:frame
                      title:title
                 titleColor:[UIColor whiteColor]
            backgroundColor:GreenColor
                 boardColor:GreenColor
                     target:target
                     action:action];
}

+ (RegisterButton *)showWhiteInView:(UIView *)view
                                top:(CGFloat)top
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action
{
    CGFloat width = CGRectGetWidth(view.frame)-2*Width_Rate*CGRectGetWidth(view.frame);
    CGRect rect = CGRectMake(CGRectGetWidth(view.frame)*Width_Rate, top, width, width*Height_Rate);
    return [RegisterButton showInView:view
                                frame:rect
                                title:title
                           titleColor:[UIColor blackColor]
                      backgroundColor:[UIColor whiteColor]
                           boardColor:nil
                               target:target
                               action:action];
}

+ (RegisterButton *)showWhiteInView:(UIView *)view
                              frame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action
{
    return [self showInView:view
                      frame:frame
                      title:title
                 titleColor:[UIColor whiteColor]
            backgroundColor:[UIColor clearColor]
                 boardColor:[UIColor whiteColor]
                     target:target
                     action:action];
}

@end
