//
//  GuideViewController.h
//  LimaHeBox
//
//  Created by jianting on 16/3/12.
//  Copyright © 2016年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

@interface GuideViewController : BoxSuperViewController

- (instancetype)initWithCompletionHandle:(void(^)(void))completionHandle;

+ (BOOL)showGudieViewControllerWithCompletionHandle:(void(^)(void))completionHandle;

@end
