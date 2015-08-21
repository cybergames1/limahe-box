//
//  ComSuperViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ComSuperViewController.h"

@implementation ComSuperViewController

- (void)dealloc {
    [_dataSource setDelegate:nil];
    [_dataSource release];_dataSource = nil;
    [super dealloc];
}

@end
