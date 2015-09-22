//
//  WeiboManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/22.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "WeiboManager.h"

@implementation WeiboManager

+ (WeiboManager *) sharedInstance
{
    static dispatch_once_t pred;
    static WeiboManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[WeiboManager alloc] init];
    });
    return manager;
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
    }
    else if([response isKindOfClass:WBSDKAppRecommendResponse.class])
    {
    }
}


@end
