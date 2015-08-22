//
//  LRSuperViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import "PPQDataSource.h"
#import "RegisterButton.h"
#import "RLCell.h"
#import "LRTools.h"

/**
 * 登陆注册的superViewController
 * 由于登陆、注册、找回界面相似，就用superViewController完成界面布局
 */
@interface LRSuperViewController : BoxSuperViewController <PPQDataSourceDelegate>

@property (nonatomic, retain) PPQDataSource * dataSource;

- (RLCell *)topCell;
- (RLCell *)bottomCell;
- (RegisterButton *)registerButton;

//RegisterButton的点击事件
- (void)doneAction;

@end
