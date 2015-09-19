//
//  UIImageViewWebCacheDelegate.h
//  QiYiShare
//
//  Created by fangyuxi on 12-12-13.
//  Copyright (c) 2012年 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"


@protocol UIImageViewWebCacheDelegate <NSObject>

- (void) imageView:(UIImageView *)view downloadURLFinishWithManager:(SDWebImageManager *)loader;
- (void) imageView:(UIImageView *)view downloadURLWithError:(NSError *)error;

@end
