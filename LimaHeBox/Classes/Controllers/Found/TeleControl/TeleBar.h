//
//  TeleBar.h
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeleBar;
@protocol TeleBarDelegate <NSObject>

- (void)bar:(TeleBar *)bar didActionAtIndex:(NSInteger)index;

@end

@interface TeleBar : UIView

@property (nonatomic, assign) id<TeleBarDelegate> delegate;

@end
