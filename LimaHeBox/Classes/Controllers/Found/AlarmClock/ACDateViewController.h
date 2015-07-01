//
//  ACDateViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/7/1.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

typedef void(^HandleBlock)(NSArray *dateIndexList);

@interface ACDateViewController : BoxSuperViewController

@property (nonatomic,copy) HandleBlock handleBlock;
@property (nonatomic, retain) NSMutableArray * selectedIndexList;

@end
