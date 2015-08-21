//
//  ComSuperViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import "PPQDataSource.h"

@interface ComSuperViewController : BoxSuperViewController <PPQDataSourceDelegate>

@property (nonatomic, retain) PPQDataSource * dataSource;

@end
