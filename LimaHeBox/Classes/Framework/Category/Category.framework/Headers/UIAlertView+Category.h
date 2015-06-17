//
//  UIAlertView+Category.h
//  Demo
//
//  Created by Sean on 14-10-11.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewBlock)(NSString* buttonTitle, NSInteger buttonIndex);

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
                        handler:(void (^)(NSString* buttonTitle, NSInteger buttonIndex))block;

/** 
 @brief 创建并显示一个带有标题title，文本描述message，取消按钮cancleButton，确定按钮otherButton的系统alertView。
        该alertView的事件通过block反馈
 
 @param title alert view的标题，可以为nil.
 @param message alert view 的描述信息，可以为nil.
 @param cancelButtonTitle 取消alertview的按钮，如果cancelButtonTitle和otherButtonTitles
        同时存在，cancelButtonTitle会位于右边或者最下边（3个以上按钮的情况下）。
 @param otherButtonTitles 其他操作的按钮
 @param block alertview消失时触发的block
 */
+ (void) showAlertViewWithTitle:(NSString *)title
                        message:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitles:(NSArray *)otherButtonTitles
                        handler:(void (^)(NSString* buttonTitle, NSInteger buttonIndex))block;

@end

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
@end

// buttonTitle:被按下的按钮的title
// buttonIndex:被按下按钮的index，该值仅在ios7及以下的系统有意义
typedef void(^UIAlertBlock)(NSString* buttonTitle, NSInteger buttonIndex);

@interface AlertViewManager : NSObject

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
@end













