//
//  TeleControlView.h
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    TeleControlNone,
    TeleControlOK,
    TeleControlTop,
    TeleControlLeft,
    TeleControlBottom,
    TeleControlRight,
};
typedef NSInteger TeleControl;

@interface TeleControlView : UIControl

@property (nonatomic, assign, readonly) TeleControl control;

@end
