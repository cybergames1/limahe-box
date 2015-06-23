//
//  MainMenuView.h
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 主菜单界面 
 */

@class MainMenuView;
@protocol MainMenuViewDelegate <NSObject>

- (void)menuView:(MainMenuView *)menuView didSelectAtIndex:(NSInteger)index;

@end

@interface MainMenuView : UIView

@property (nonatomic, assign) id<MainMenuViewDelegate> delegate;

@end
