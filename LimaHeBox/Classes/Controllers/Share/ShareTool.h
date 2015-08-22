//
//  ShareTool.h
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareTool : NSObject

/** 保存的草稿箱分享内容 **/
@property (nonatomic,copy) NSString * shareText;

+ (ShareTool *)sharedTools;

@end
