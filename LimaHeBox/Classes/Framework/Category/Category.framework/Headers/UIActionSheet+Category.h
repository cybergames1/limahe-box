//
//  UIActionSheet+Category.h
//  Demo
//
//  Created by Sean on 14/10/20.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"
typedef void(^ActionSheetBlock)(NSString* buttonTitle);

@interface UIActionSheet (QuickShowActionSheetWithBlock)
<UIActionSheetDelegate>
/**
 @details 快捷弹出 ActionSheet 的方法
 @param title 标题，可以为 nil
 @param cancleButton 取消按钮，位于最下方
 @param otherButton 其他按钮
 @param dismissBlock sheet 消失时的响应事件
 */
+ (void) showActionSheet:(NSString*) title
            cancleButton:(NSString*) cancleButton
             otherButton:(NSString*) otherButton
            dismissBlock:(ActionSheetBlock) dismissBlock;


/**
 @details 快捷弹出 ActionSheet 的方法
 @param title 标题，可以为 nil
 @param cancleButton 取消按钮，位于最下方
 @param othersButton 其他按钮，允许放置多个按钮
 @param destructiveButton 高亮显示的按钮，比如“删除”等
 @param dismissBlock sheet 消失时的响应事件
 */
+ (void) showActionSheetWithTitle:(NSString*) title
                     cancleButton:(NSString*) cancleButtonTitle
                     othersButton:(NSArray*) othersButton
                destructiveButton:(NSString*) destructiveButton
                     dismissBlock:(ActionSheetBlock) dismissBlock;
@end


@interface UIAlertController (QuickShowActionSheet)
/**
 @details 快捷弹出 ActionSheet 的方法
 @param title 标题，可以为 nil
 @param message 弹窗内容，可以为 nil
 @param cancleButton 取消按钮，位于最下方
 @param othersButton 其他按钮，允许放置多个按钮
 @param destructiveButton 高亮显示的按钮，比如“删除”等
 @param rootController 弹出 sheet 的控制器，如果传 nil，默认使用系统的rootController
 @param dismissBlock sheet 消失时的响应事件
 */
+ (void) showActionSheetWithTitle:(NSString*) title
                          message:(NSString*) message
                     cancleButton:(NSString*) cancleButton
                     othersButton:(NSArray*) othersButton
                destructiveButton:(NSString*) destructiveButton
                   rootController:(UIViewController*) rootController
                     dismissBlock:(void (^)(UIAlertAction *action)) dismissBlock;

@end

@interface ActionSheetManager : NSObject
/**
 @details 快捷弹出 ActionSheet 的方法
 @param title 标题，可以为 nil
 @param message 弹窗内容，可以为 nil
 @param cancleButton 取消按钮，位于最下方
 @param othersButton 其他按钮，允许放置多个按钮
 @param destructiveButton 高亮显示的按钮，比如“删除”等
 @param rootController 弹出sheet的控制器，只对8.0以下的系统有效
 @param dismissBlock sheet 消失时的响应事件
 */
+ (void) showActionSheet:(NSString*) title
                 message:(NSString*) message
            cancleButton:(NSString*) cancleButton
            othersButton:(NSArray*) othersButton
       destructiveButton:(NSString*) destructiveButton
          rootController:(UIViewController*) rootController
            dismissBlock:(ActionSheetBlock) dismissBlock;

@end



