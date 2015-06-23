//
//  MainMenuView.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "MainMenuView.h"
#import "QuadCurveMenu.h"

@interface MainMenuView () <QuadCurveMenuDelegate>

@end

@implementation MainMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:nil
                                                                   highlightedImage:nil
                                                                       ContentImage:[UIImage imageNamed:@"main_kuaidi"]
                                                            highlightedContentImage:[UIImage imageNamed:@"main_kuaidi"]
                                                                        ContentText:@"快递"];
        QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:nil
                                                                   highlightedImage:nil
                                                                       ContentImage:[UIImage imageNamed:@"main_xingcheng"]
                                                            highlightedContentImage:[UIImage imageNamed:@"main_xingcheng"]
                                                                        ContentText:@"行程"];
        QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:nil
                                                                   highlightedImage:nil
                                                                       ContentImage:[UIImage imageNamed:@"main_lanya"]
                                                            highlightedContentImage:[UIImage imageNamed:@"main_lanya"]
                                                                        ContentText:@"蓝牙"];
        QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:nil
                                                                   highlightedImage:nil
                                                                       ContentImage:[UIImage imageNamed:@"main_fenxiang"]
                                                            highlightedContentImage:[UIImage imageNamed:@"main_fenxiang"]
                                                                        ContentText:@"分享"];
        QuadCurveMenuItem *starMenuItem5 = [[QuadCurveMenuItem alloc] initWithImage:nil
                                                                   highlightedImage:nil
                                                                       ContentImage:[UIImage imageNamed:@"main_faxian"]
                                                            highlightedContentImage:[UIImage imageNamed:@"main_faxian"]
                                                                        ContentText:@"发现"];
        
        NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
        [starMenuItem1 release];
        [starMenuItem2 release];
        [starMenuItem3 release];
        [starMenuItem4 release];
        [starMenuItem5 release];
        
        QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.bounds menus:menus];
        
        // customize menu
        
        menu.rotateAngle = -2*M_PI/5;
        menu.menuWholeAngle = M_PI;
        //menu.timeOffset = 0.2f;
        //menu.farRadius = 180.0f;
        menu.endRadius = 100.0f;
        //menu.nearRadius = 50.0f;
        
        menu.delegate = self;
        [self addSubview:menu];
        [menu release];
    }
    return self;
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    if (_delegate && [_delegate respondsToSelector:@selector(menuView:didSelectAtIndex:)]) {
        [_delegate menuView:self didSelectAtIndex:idx];
    }
}

@end
