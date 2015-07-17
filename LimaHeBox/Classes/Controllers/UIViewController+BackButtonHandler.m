//
//  UIViewController+BackButtonHandler.m
//  LimaHeBox
//
//  Created by jianting on 15/7/6.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "UIViewController+BackButtonHandler.h"

@implementation UIViewController (BackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

//UINavigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem*)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // Workaround for iOS7.1
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.0) {
                [UIView animateWithDuration:0.25 animations:^{
                    subview.alpha = 1.0;
                }];
            }
        }
    }
    
    return NO;
}

@end
