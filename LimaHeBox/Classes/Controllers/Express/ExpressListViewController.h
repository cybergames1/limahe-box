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

/*
 * 查询页进来不能打电话，寄快递进来可以打电话
 * 默认是NO
 */
@property (nonatomic) BOOL canCall;

/*
 * 选择了一个快递的回调，查询页需要，寄快递页可以不需要
 */
@property (nonatomic, copy) HandleBlock handleBlock;

@end
