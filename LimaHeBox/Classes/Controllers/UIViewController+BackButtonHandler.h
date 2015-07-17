//
//  UIViewController+BackButtonHandler.h
//  LimaHeBox
//
//  Created by jianting on 15/7/6.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>

@optional

//UIViewController实现点击返回按钮的方法
- (BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end
