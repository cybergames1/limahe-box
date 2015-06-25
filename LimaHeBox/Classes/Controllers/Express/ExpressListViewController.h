//
//  ExpressListViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/6/24.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import "ExpressModel.h"

/**
 * 快递列表页
 */

typedef void(^HandleBlock)(ExpressModel* expressmodel);

@interface ExpressListViewController : BoxSuperViewController

@property (nonatomic, copy) HandleBlock handleBlock;

@end
