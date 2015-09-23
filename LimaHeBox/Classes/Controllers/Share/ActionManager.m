//
//  ActionManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/23.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "ActionManager.h"
#import <Category/Category.h>
#import "CommonTools.h"

@interface ActionManager () <UIActionSheetDelegate>

@end

@implementation ActionManager

/** 最上层ViewController的根 **/
+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/**
 最上层viewController的Class名
 虽然崩溃的具体原因不一定是最上层的viewController引起的
 但知道跟这个viewController有关也是极好的
 **/
+ (UIViewController *)topViewController
{
    UIViewController *rootViewController = [[self class] appRootViewController];
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        rootViewController = [(UITabBarController *)rootViewController selectedViewController];
    }
    
    while ([rootViewController isKindOfClass:[UINavigationController class]]) {
        rootViewController = [(UINavigationController *)rootViewController topViewController];
    }
    
    return rootViewController;
}

+ (ActionManager *)sharedManager
{
    static ActionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ActionManager alloc] init];
    });
    return instance;
}

- (void)showActionViewWithItems:(NSArray *)items
                          title:(NSString *)title
                       delegate:(id<ActionManagerDelegate>)delegate
                       userInfo:(NSDictionary *)userInfo
{
    self.delegate = delegate;
    
    if ([UIDevice SystemLowThanIOS8]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微博",@"微信",@"微信朋友圈", nil];
        [actionSheet showInView:[CommonTools keyWindow]];
        [actionSheet release];
    }else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self postDelegateWithTitle:action.title];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self postDelegateWithTitle:action.title];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self postDelegateWithTitle:action.title];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        }];
        
        [alertController addAction:action1];
        [alertController addAction:action2];
        [alertController addAction:action3];
        [alertController addAction:cancleAction];
        
        [[[self class] topViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self postDelegateWithTitle:@"微博"];
    }else if (buttonIndex == 1) {
        [self postDelegateWithTitle:@"微信"];
    }else if (buttonIndex == 2) {
        [self postDelegateWithTitle:@"微信朋友圈"];
    }else {
        //
    }
}

- (void)postDelegateWithTitle:(NSString *)title {
    if (_delegate && [_delegate respondsToSelector:@selector(actionViewClickWithTitle:)]) {
        [_delegate actionViewClickWithTitle:title];
    }
}

@end
