//
//  NSString+base64.h
//  LimaHeBox
//
//  Created by jianting on 15/6/18.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (base64)

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

@end
