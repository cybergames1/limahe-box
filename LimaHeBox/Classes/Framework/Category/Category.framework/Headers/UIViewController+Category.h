//
//  UIViewController+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark UIViewController (AddSubview)
@interface UIViewController (UIViewControllerAddSubview)
/**
 UIController添加subview的快捷方式
 */
- (void)addSubview:(UIView *)subview;

/**
 UIController添加subview的快捷方式 @see UIView的addSubview:atLevel:注释
 */
- (void)addSubview:(UIView *)subview atLevel:(NSInteger) level;
@end

#pragma mark UIViewController （PushPop）
typedef void(^CompletionBlock) ();
@interface UIViewController (UIViewControllerPushPop)
<UINavigationControllerDelegate>
/** push 方法
 @param viewController 要push的viewController，不能为nil
 @param animated 是否需要动画
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(CompletionBlock)completion;
/**  pop 方法
 @param animated 是否需要动画
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                                     completion:(CompletionBlock)completion;

@end


#pragma mark 显示alert提醒

#import "UIAlertView+Category.h"
@interface UIViewController (UIViewControllerShowAlert)

/**
 @brief 弹出系统的alertView，并显示一段信息message，没有按钮，2秒后自动消失
 @param message 需要显示的文本
 */
- (void) showAlertView:(NSString*) message;

/**
 @brief 弹出系统的alertView，并显示一段信息message，没有按钮，2秒后自动消失
 @param message 需要显示的文本
 @param rootController alert 需要由哪个 controller 弹出。
 @note rootController仅对 IOS8及以上的系统有用。如果传 nil，默认使用keyWindow的rootViewController
 */
- (void) showAlertView:(NSString*) message
    rootViewController:(UIViewController*) rootController;

/**
 @brief 显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertView的事件通过block反馈
 
 @param title 弹窗标题，如果设置，以粗体显示。可以为nil.
 @param message 弹窗描述信息，可以为nil.
 @param cancelButtonTitle 取消弹窗按钮，如果cancelButtonTitle和otherButtonTitle
        同时存在，cancelButtonTitle会位于右边。
 @param otherButtonTitle 其他操作的按钮
 @param dismissBlock 弹窗消失时触发的block(对于 IOS8及以后的系统，buttonIndex永远返回“-1”)
 */
- (void) showAlertView:(NSString*) message
            alertTitle:(NSString*) title
           cancleTitle:(NSString*) cancleButtonTitle
      otherButtonTitle:(NSString*) otherButtonTitle
          dismissBlock:(UIAlertBlock) dismissBlock;

/**
 @brief 显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertView的事件通过block反馈
 
 @param title 弹窗标题，如果设置，以粗体显示。可以为nil.
 @param message 弹窗描述信息，可以为nil.
 @param cancelButtonTitle 取消弹窗按钮，如果cancelButtonTitle和otherButtonTitle
        同时存在，cancelButtonTitle会位于右边。
 @param otherButtonTitle 其他操作的按钮
 @param rootController 弹窗需要由哪个controller弹出(present)。
 @param dismissBlock 弹窗消失时触发的block(对于 IOS8及以后的系统，buttonIndex永远返回“-1”)
 
 @code
     [self showAlertViewWithMessage:@"Alert Message" 
           alertTitle:@"Alert Title"
           cancleTitle:@"CancleButton" 
           otherButtonTitle:@"DoneButton"
           rootViewController:self 
           dismissBlock:^(NSString *buttonTitle, NSInteger buttonIndex) {
              //Do something here.
     }];
 @endcode
 
 @note rootController仅对IOS8及以上的系统有用。如果传 nil，默认使用keyWindow的rootViewController
 */
- (void) showAlertViewWithMessage:(NSString*) message
                       alertTitle:(NSString*) title
                      cancleTitle:(NSString*) cancleButtonTitle
                 otherButtonTitle:(NSString*) otherButtonTitle
               rootViewController:(UIViewController*) rootController
                     dismissBlock:(UIAlertBlock) dismissBlock;

@end


@interface UIViewController (UIViewControllerShowActionSheet)
/**
 @brief 显示一个带有标题title，文本描述message，取消按钮cancleButton，其他按钮otherButtons
        的系统ActionSheet。该Sheet的响应事件通过block反馈
 
 @param title 标题，如果设置，以粗体显示。可以为nil.
 @param message 描述信息，可以为nil.
 @param cancelButton 取消按钮，位于最下面一行
 @param otherButtons 其他操作的按钮
 @param dismissBlock 弹窗消失时触发的block(对于 IOS8及以后的系统，buttonIndex永远返回“-1”)

 @note rootController仅对IOS8及以上的系统有用。如果传 nil，默认使用keyWindow的rootViewController
 */
- (void) showActionSheet:(NSString*) message
                   title:(NSString*) title
            cancleButton:(NSString*) cancleButton
            otherButtons:(NSArray*) otherButtons
            dismissBlock:(UIAlertBlock) dismissBlock;

/**
 @brief 显示一个带有标题title，文本描述message，取消按钮cancleButton，其他按钮otherButtons，
        高亮按钮destructiveButton的系统ActionSheet。该Sheet的响应事件通过block反馈
 
 @param title 标题，如果设置，以粗体显示。可以为nil.
 @param message 描述信息，可以为nil.
 @param cancelButton 取消按钮，位于最下面一行
 @param otherButtons 其他操作的按钮
 @param destructiveButton 高亮显示的按钮，用于提醒用户，比如“删除”按钮等
 @param rootController 弹窗需要由哪个controller弹出(present)。
 @param dismissBlock 弹窗消失时触发的block(对于 IOS8及以后的系统，buttonIndex永远返回“-1”)
 
 @code
     [self showActionSheetWithMessage:@"Sheet with message" 
           title:@"Action Sheet" 
           cancleButton:@"Dismiss" 
           otherButtons:[NSArray arrayWithObjects:@"OK",@"Comfirm", nil] 
           destructiveButton:@"Delete" 
           rootController:self 
           dismissBlock:^(NSString *buttonTitle, NSInteger buttonIndex) {
              //Do something here.
     }];
 @endcode
 
 @note rootController仅对IOS8及以上的系统有用。如果传 nil，默认使用keyWindow的rootViewController
 */
- (void) showActionSheetWithMessage:(NSString*) message
                              title:(NSString*) title
                       cancleButton:(NSString*) cancleButton
                       otherButtons:(NSArray*) otherButtons
                  destructiveButton:(NSString*) destructiveButton
                     rootController:(UIViewController*) rootController
                       dismissBlock:(UIAlertBlock) dismissBlock;

@end








