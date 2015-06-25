//
//  ExpressModel.m
//  LimaHeBox
//
//  Created by jianting on 15/6/24.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ExpressModel.h"

@implementation ExpressModel

- (void)dealloc {
    [_expressId release];_expressId = nil;
    [_expressName release];_expressName = nil;
    [super dealloc];
}

@end
