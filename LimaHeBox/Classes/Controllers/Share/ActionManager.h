//
//  ActionManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/23.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActionSheetManager;
@protocol ActionManagerDelegate <NSObject>

- (void)actionViewClickWithTitle:(NSString *)title;

@end

@interface ActionManager : NSObject

@property (nonatomic, assign) id<ActionManagerDelegate> delegate;

+ (ActionManager *)sharedManager;

- (void)showActionViewWithItems:(NSArray *)items
                          title:(NSString *)title
                       delegate:(id<ActionManagerDelegate>)delegate
                       userInfo:(NSDictionary *)userInfo;

@end
