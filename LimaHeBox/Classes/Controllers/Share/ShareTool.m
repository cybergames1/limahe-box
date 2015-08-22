//
//  ShareTool.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ShareTool.h"

@implementation ShareTool

- (void)dealloc {
    [_shareText release];_shareText = nil;
    [super dealloc];
}

+ (ShareTool *)sharedTools
{
    static ShareTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ShareTool alloc] init];
    });
    return instance;
}

@end
