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
        UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
        UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
        
        UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
        
        QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"main_kuaidi"]
                                                                   highlightedImage:[UIImage imageNamed:@"main_kuaidi"]
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
        QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"main_xingcheng"]
                                                                   highlightedImage:[UIImage imageNamed:@"main_xingcheng"]
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
        QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"main_lanya"]
                                                                   highlightedImage:[UIImage imageNamed:@"main_lanya"]
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
        QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"main_fenxiang"]
                                                                   highlightedImage:[UIImage imageNamed:@"main_fenxiang"]
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
        QuadCurveMenuItem *starMenuItem5 = [[QuadCurveMenuItem alloc] initWithImage:[UIImage imageNamed:@"main_faxian"]
                                                                   highlightedImage:[UIImage imageNamed:@"main_faxian"]
                                                                       ContentImage:nil
                                                            highlightedContentImage:nil];
        
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
    NSLog(@"Select the index : %ld",(long)idx);
}

@end
