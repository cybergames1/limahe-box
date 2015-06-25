//
//  ExpressResultViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/6/25.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

/*
 * 快递查询结果页
 */
@interface ExpressResultViewController : BoxSuperViewController

/* 快递公司Id */
@property (nonatomic, copy) NSString * comId;
/* 单号 */
@property (nonatomic, copy) NSString * postId;

@end
