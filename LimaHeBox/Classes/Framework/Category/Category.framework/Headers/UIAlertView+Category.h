//
//  UIAlertView+Category.h
//  Demo
//
//  Created by Sean on 14-10-11.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

//UIAlert block
typedef void(^UIAlertBlock)(NSString* buttonTitle);

//UIAlert textField
typedef void (^UIAlertTextField) (UITextField* textField);

#pragma mark - QuickShowAlertViewWithBlock
@interface UIAlertView (QuickShowAlertViewWithBlock)

/**
 显示一个只有标题没有任何按钮的alertView,2秒后自动消失
 */
+ (void) showAlertViewWithTitle:(NSString *)title ;


/**
 @brief 创建并显示一个带有标题title，取消按钮cancleButton的系统alertView。
        该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param cancelButtonTitle 取消alertview的按钮。
 @param block alertview消失时触发的block
 
 */
+ (void) showAlertViewWithTitle:(NSString *)title
              cancelButtonTitle:(NSString *)cancelButtonTitle
                        handler:(UIAlertBlock)block;

/** 
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancelButtonTitle 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于右边或者最下边（3个以上按钮的情况下）。
 @param otherButtonTitles 其他操作的按钮
 @param block alertview消失时触发的block
 @code
     [self showActionSheetWithMessage:@"a alertView with title and buttons" 
           title:@"title" cancleButton:@"cancle" 
           otherButtons:[NSArray arrayWithObjects:@"button1",@"button2",nil] 
           destructiveButton:@"delete" rootController:self 
           dismissBlock:^(NSString *buttonTitle) {
             if ([@"delete" isEqualToString:buttonTitle]) {}
             else if ([@"cancle" isEqualToString:buttonTitle]){}
     }];
 @endcode
 */
+ (void) showAlertViewWithTitle:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
                        handler:(UIAlertBlock)block;

/**
 @brief 创建并显示一个输入框 TextField 的系统alertView，该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param textFieldHandle 返回输入框，调用者可以在定制输入框的代理等
 @param block alertview消失时触发的block
 @code
     [UIAlertView showAlertTextField:@"alertView" message:@"alertView with a textField" cancleButton:@"cancle" otherButton:@"OK" textFieldHandle:^(UITextField *textField) {
         // 可以在这里配置 textField，比如颜色、代理等等
         textField.backgroundColor = [UIColor orangeColor];
     } buttonHandle:^(NSString *buttonTitle) {
         //点中按钮后的反馈
     }];
 @endcode
 */
+ (void) showAlertTextField:(NSString*) title
                    message:(NSString*) message
               cancleButton:(NSString*) cancleButton
                otherButton:(NSString*) otherButton
            textFieldHandle:(UIAlertTextField) textFieldHandle
               buttonHandle:(UIAlertBlock) block;

/**
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
 该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param loginHandle 账号登陆框
 @param passwordHandle 密码输入框
 @param block alertview消失时触发的block
 @code
     [UIAlertView showAlertLoginTextField:@"alertView" message:@"alertView with a login textField and password textField" cancleButton:@"cancle" otherButton:@"OK" loginHandle:^(UITextField *textField) {
         //配置登陆框输入框
         textField.backgroundColor = [UIColor blueColor];
     } passwordHandle:^(UITextField *textField) {
         //配置密码输入框
         textField.backgroundColor = [UIColor cyanColor];
     } buttonHandle:^(NSString *buttonTitle) {
         //点击按钮的反馈
     }];
 @endcode */
+ (void) showAlertLoginTextField:(NSString*) title
                         message:(NSString*) message
                    cancleButton:(NSString*) cancleButton
                     otherButton:(NSString*) otherButton
                     loginHandle:(UIAlertTextField) loginHandle
                  passwordHandle:(UIAlertTextField) passwordHandle
                    buttonHandle:(UIAlertBlock) block;

/**
 dismiss 最后显示的 alertView
 @note 该API只能 dismiss 由UIAlertView (QuickShowAlertViewWithBlock)显示的 UIAlertView
 */
+ (void) dismissAlertView;

@end

#pragma mark - QuickShowAlertController
@interface UIAlertController (QuickShowAlertController)
/**
 @brief 显示一个只有标题没有任何按钮的alertView,2秒后自动消失
 @param title alert view的标题，可以为nil.
 @param rootController 弹出 alertController的rootController，不能为nil
 @note 如果 rootController 为 nil 或者该 rootController 已经present了另外一个controller，
       执行该代码将不会弹出 alert，需要调用者做好防护措施。
 */
+ (void) showAlertViewWithTitle:(NSString *)title
                 rootController:(UIViewController*) rootController;

/**
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertController的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancelButtonTitle 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于右边或者最下边（3个以上按钮的情况下）。
 @param otherButtonTitles 其他操作的按钮
 @param rootController present alertController的rootController，不能为nil
 @param block alertController消失时触发的block
 
 @note 如果 rootController 为 nil 或者该 rootController 已经 present 了另外一个 controller，
       执行该代码将不会弹出 alert，需要调用者做好防护措施。
 */
+ (void) showAlertViewWithTitle:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
                 rootController:(UIViewController*) rootController
                        handler:(void (^)(UIAlertAction *action))handler;
/**
 @brief 创建并显示一个输入框 TextField 的系统alertView，该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param rootController present alertController的rootController，不能为nil
 @param textFieldHandle 返回输入框，调用者可以在定制输入框的代理等
 @param block alertview消失时触发的block
 @note 如果 rootController 为 nil 或者该 rootController 已经 present 了另外一个 controller，
 执行该代码将不会弹出 alert，需要调用者做好防护措施。
 */
+ (void) showAlertTextField:(NSString*) title
                    message:(NSString*) message
               cancleButton:(NSString*) cancleButton
                otherButton:(NSString*) otherButton
             rootController:(UIViewController*) rootController
            textFieldHandle:(UIAlertTextField) textFieldHandle
               buttonHandle:(void (^)(UIAlertAction *action))handler;

/**
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
 该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param rootController present alertController的rootController，不能为nil
 @param loginHandle 账号登陆框textField
 @param passwordHandle 密码输入框textField
 @param block alertview消失时触发的block
 @note 如果 rootController 为 nil 或者该 rootController 已经 present 了另外一个 controller，
 执行该代码将不会弹出 alert，需要调用者做好防护措施。
 */

+ (void) showAlertLoginTextField:(NSString*) title
                         message:(NSString*) message
                    cancleButton:(NSString*) cancleButton
                     otherButton:(NSString*) otherButton
                  rootController:(UIViewController*) rootController
                     loginHandle:(UIAlertTextField) loginHandle
                  passwordHandle:(UIAlertTextField) passwordHandle
                    buttonHandle:(void (^)(UIAlertAction *action))handler;

/**
 dismiss 最后显示的 alertView
 @note 该API只能 dismiss 由UIAlertController (QuickShowAlertController)显示的 AlertController
 */
+ (void) dismissAlertController;

@end

#pragma mark - AlertViewManager
@interface AlertViewManager : NSObject
/**
 dismiss 最后显示的 alertView
 @note 该API只能 dismiss 由AlertViewManager显示的 AlertView
 */
+ (void) dismissAlertView;

/**
 @brief 显示一个只有标题没有任何按钮的alertView,2秒后自动消失
 @param title alert view的标题，可以为nil.
 @param rootController 弹出 alertController的rootController，不能为nil
 @note 此处需要调用者做好空rootController的防范，如果 rootController 为 nil，
       默认使用keyWindow的rootController 。
       rootController仅对 IOS8 以上的系统有效。
 */
+ (void) showAlertViewWithTitle:(NSString *)title
                 rootController:(UIViewController*) rootController;

/**
 @brief 创建并显示一个带有标题title，文本描述message，
        取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertController的事件通过block反馈
 
 @param title alertView的标题，可以为nil.
 @param message alertView 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancleButton和otherButton
        同时存在，cancleButton会位于右边。
 @param otherButton 其他操作的按钮
 @param rootController present alertController的rootController，不能为nil
 @param handle alertController消失时触发的block
 
 @note 此处需要调用者做好空 root 得防范，如果 rootController 为 nil，默认使用keyWindow的rootController 。
       rootController仅对 IOS8 以上的系统有效。
 
 */
+ (void) showAlertWithTitle:(NSString*) title
                    message:(NSString*) message
               cancleButton:(NSString*) cancleButton
                otherButton:(NSString*) otherButton
             rootController:(UIViewController*) rootController
                     handle:(UIAlertBlock) handle;

/**
 @brief 创建并显示一个输入框 TextField 的系统alertView，该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param textFieldHandle 返回输入框，调用者可以在定制输入框的代理等
 @param block alertview消失时触发的block
 */
+ (void) showAlertTextField:(NSString*) title
                    message:(NSString*) message
               cancleButton:(NSString*) cancleButton
                otherButton:(NSString*) otherButton
             rootController:(UIViewController*) rootController
            textFieldHandle:(UIAlertTextField) textFieldHandle
               buttonHandle:(UIAlertBlock) block;

/**
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancleButton 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
         同时存在，cancelButtonTitle会位于左边或者最下边（3个以上按钮的情况下）。
 @param otherButton 其他操作的按钮
 @param loginHandle 账号登陆框textField
 @param passwordHandle 密码输入框textField
 @param block alertview消失时触发的block
 */
+ (void) showAlertLoginTextField:(NSString*) title
                         message:(NSString*) message
                    cancleButton:(NSString*) cancleButton
                     otherButton:(NSString*) otherButton
                  rootController:(UIViewController*) rootController
                     loginHandle:(UIAlertTextField) loginHandle
                  passwordHandle:(UIAlertTextField) passwordHandle
                    buttonHandle:(UIAlertBlock) block;


@end













