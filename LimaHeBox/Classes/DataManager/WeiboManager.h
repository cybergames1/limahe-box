//
//  WeiboManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/22.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface WeiboManager : NSObject <WeiboSDKDelegate>

+ (WeiboManager *) sharedInstance;

@end
