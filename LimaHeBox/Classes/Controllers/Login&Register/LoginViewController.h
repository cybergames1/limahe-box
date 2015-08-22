//
//  LoginViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/8/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LRSuperViewController.h"

/**
 * 登录页
 */
@interface LoginViewController : LRSuperViewController

+ (void) showLogin:(UIViewController*) rootController
       finishBlock:(LoginFinish) finish;
@end
