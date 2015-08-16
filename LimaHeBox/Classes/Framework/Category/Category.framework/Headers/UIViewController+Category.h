//
//  UIViewController+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark UIViewController (AddSubview)
@interface UIViewController (UIViewControllerAddSubview)
/**
 UIController添加subview的快捷方式
 */
- (void)addSubview:(UIView *)subview;

/**
 UIController添加subview的快捷方式 @see UIView的<a href="">addSubview:atLevel:</a>注释
 */
- (void)addSubview:(UIView *)subview atLevel:(NSInteger) level;

@end

#pragma mark - UIViewController (UINavigationBar)
@interface UIViewController (UINavigationBarColor)
/** 返回系统的 navigationBar，nil如果该 controller没有navigationController */
@property (nonatomic, readonly) UINavigationBar* navigationBar;
/**
 单独设置某个 viewController 的 navigationBar 的背景颜色
 @param backgroundColor 背景颜色，不能为 nil
 @param shadowColor 阴影的颜色，如果传 nil，则不显示阴影
 @param barMetrics bar 放置的位置
 */
- (void)setNavigationBarColor:(UIColor *)backgroundColor
                  shadowColor:(UIColor *)shadowColor
                forBarMetrics:(UIBarMetrics)barMetrics;
/**
 统一设置某个 viewController 的 navigationBar 的背景颜色
 @param backgroundColor 背景颜色，不能为 nil
 @param barMetrics bar 放置的位置
 @code
  [UIViewController setNavigationBarColor:UIColorRGB(0, 199, 134) 
                            forBarMetrics:UIBarMetricsDefault];
 @endcode
 */
+ (void)setNavigationBarColor:(UIColor *)backgroundColor
                  shadowColor:(UIColor *)shadowColor
                forBarMetrics:(UIBarMetrics)barMetrics;
/**
 单独设置某个 viewController 的 navigationBar 的背景图片
 @param backgroundImage 背景图片，不能为 nil
 @param barMetrics bar 放置的位置
 */
- (void)setNavigationBarImage:(UIImage *)backgroundImage
                  shadowImage:(UIImage *)shadowImage
                forBarMetrics:(UIBarMetrics)barMetrics;
/**
 统一设置某个 viewController 的 navigationBar 的背景图片
 @param backgroundImage 背景图片，不能为 nil
 @param barMetrics bar 放置的位置
 */
+ (void) setNavigationBarImage:(UIImage *)backgroundImage
                   shadowImage:(UIImage *)shadowImage
                 forBarMetrics:(UIBarMetrics)barMetrics;
/**
 单独设置 navigationBar 上标题的颜色、字号、阴影等效果
 @param color 标题颜色。对 ios6系统来说，标题只显示白色
 @param font 标题字体
 @param offset 阴影偏移量
 */
- (void) setNavigationBarTitleColor:(UIColor*) color
                          titleFont:(UIFont*) font
                        shadowColor:(UIColor*) shadowColor
                       shadowOffset:(UIOffset) offset;
/**
 统一设置 navigationBar 上标题的颜色、字号、阴影等效果
 @param color 标题颜色。对 ios6系统来说，标题只显示白色
 @param font 标题字体
 @param shadowColor 阴影颜色，传 nil 表示没有阴影
 @param offset 阴影偏移量
 
 @code
 [UIViewController setNavigationBarTitleColor:[UIColor redColor] 
                                    titleFont:[UIFont boldSystemFontOfSize:20] 
                                  shadowColor:[UIColor blueColor] 
                                 shadowOffset:UIOffsetZero];
 @endcode
 */
+ (void) setNavigationBarTitleColor:(UIColor*) color
                          titleFont:(UIFont*) font
                        shadowColor:(UIColor*) shadowColor
                       shadowOffset:(UIOffset) offset;
@end

#pragma mark UIViewController (NavigationControllerItemButton)
@interface UIViewController (NavigationControllerItemButton)
/** left bar button item */
@property(nonatomic, retain) UIBarButtonItem *leftBarButtonItem;
/** right bar button item */
@property(nonatomic, retain) UIBarButtonItem *rightBarButtonItem;

/** 
 通过title初始化一个系统的导航条按钮
 @note <li> 响应方法:- (void) leftBarButtonAction
       <li> 设置该返回按钮不支持系统的右滑返回功能， 要支持该功能请设置backBarButton
 */
- (void) leftBarButtonWithTitle:(NSString*) title;
/**
通过title初始化一个系统的导航条按钮
 @param title 按钮标题
 @param font 按钮字体
 @param color 按钮常规颜色
 @param highlightColor 按钮按下颜色
 

 @note <li> 响应方法:- (void) leftBarButtonAction
       <li> 设置该返回按钮不支持系统的右滑返回功能， 要支持该功能请设置backBarButton
*/
- (void) leftBarButtonWithTitle:(NSString*) title
                      titleFont:(UIFont*) font
                     titleColor:(UIColor*) color
                 highlightColor:(UIColor*) highlightColor;

/**
 通过image初始化一个系统的导航条按钮
 @note <li> 响应方法:- (void) leftBarButtonAction
       <li> 设置该返回按钮不支持系统的右滑返回功能， 要支持该功能请设置backBarButton
 */
- (void) leftBarButtonWithImage:(UIImage*) image
                 highlightImage:(UIImage*) highlightImage;
/**
 通过systemItem初始化一个系统的导航条按钮
 @note <li> 响应方法:- (void) leftBarButtonAction
       <li> 设置该返回按钮不支持系统的右滑返回功能， 要支持该功能请设置backBarButton
 */
- (void) leftBarButtonWithSystemItem:(UIBarButtonSystemItem)systemItem;
/**
 自定义导航条左侧按钮
 @note <li> 响应方法:- (void) leftBarButtonAction
       <li> 设置该返回按钮不支持系统的右滑返回功能， 要支持该功能请设置backBarButton
 */
- (void) leftBarButtonWithCustomView:(UIView*) customView;

#pragma mark - back bar button item
/**
 设置返回按钮的标题。这里设置的按钮支持左滑屏幕返回上一层。
 */
- (void) backBarButtonItemWithTitle:(NSString*) title;

/**
 通过image初始化一个系统的导航条按钮 <br> <b style="font-size:20px;color:#ff0000">该方法暂时还没有实现，SORRY！</b>
 @note <li> 响应方法:- (void) leftBarButtonAction
 */
- (void) backBarButtonWithImage:(UIImage*) image
                 highlightImage:(UIImage*) highlightImage NS_DEPRECATED_IOS(3_0,5_0);

#pragma mark - right bar button item
/**
 通过title初始化一个系统的导航条按钮
 @note 响应方法:- rightBarButtonAction
 */
- (void) rightBarButtonWithTitle:(NSString*) title;
/**
 通过title初始化一个系统的导航条按钮
 @param title 按钮标题
 @param font 按钮字体
 @param color 按钮常规颜色
 @param highlightColor 按钮按下颜色
 
 @note 响应方法:- rightBarButtonAction
 */
- (void) rightBarButtonWithTitle:(NSString*) title
                       titleFont:(UIFont*) font
                      titleColor:(UIColor*) color
                  highlightColor:(UIColor*) highlightColor;
/**
 通过image初始化一个系统的导航条按钮
 @note 响应方法:- rightBarButtonAction
 */
- (void) rightBarButtonWithImage:(UIImage*) image
                  highlightImage:(UIImage*) highlightImage;
/**
 通过systemItem初始化一个系统的导航条按钮
 @note 响应方法:- rightBarButtonAction
 */
- (void) rightBarButtonWithSystemItem:(UIBarButtonSystemItem)systemItem;
/**
 自定义导航条右侧按钮
 */
- (void) rightBarButtonWithCustomView:(UIView*) customView;

#pragma mark - button action
/** 
 左导航条按钮的响应方法，默认什么都不实现
 */
- (void)leftBarButtonAction;
/** 
 右导航条按钮的响应方法，默认什么都不实现
 */
- (void)rightBarButtonAction;

@end

#pragma mark - NavigationController block
//navigationController 的 block 事件
typedef void(^CompletionBlock) ();
@interface UINavigationController (PushPopWithBlock)
/** push 方法
 @param viewController 要push的viewController，不能为nil
 @param animated 是否需要动画
 @param completion viewController完全显示后的block，调用者可以在这里处理相关事件
 @code
     UIViewController* controller = [[UIViewController alloc] init];
     [self pushViewController:controller animated:YES completion:^{
         // do something here
     }];
 [controller release];
 @endcode
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                completion:(CompletionBlock)completion;
/**  pop 方法
 @param animated 是否需要动画
 @param completion pop完成后的 block，调用者可以在这里处理相关事件
 @details 如果调用者已处于栈顶位置，操作不做任何处理，但是block会回调
 @code
     [self popViewControllerAnimated:YES completion:^{
         // do something here
     }];
 @endcode
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
                                     completion:(CompletionBlock)completion;

/** 获取 UINavigationController 的 rootViewController */
- (UIViewController*) rootViewController;

@end

#pragma mark - visible viewController
@interface UIViewController (ToppestViewController)
/**
 获取任何指定viewController为起点的的顶层viewController。
 @details 顶层viewController的定义
    <li>对于UINavigationController，处于栈顶的为toppestViewController
    <li>对于tabbarViewController，当前选中的tab可能有toppestViewController
    <li>对于普通viewController，需要判断它是否有presentedViewController
 @note toppestViewController<b style="color:#ff0000">并非一定为可见</b>的viewController，它只表示了从当前控制器
       开始处于最顶端的viewController为哪个。
 */
- (UIViewController*) toppestViewController;

/** 
 当前界面的前一个界面 
 */
- (UIViewController*) previousViewController;

@end

@interface UIViewController (ViewControllerDebug)
/**
 打印自当前viewController开始一直到keyWindow的rootController的控制器调用关系
 */
- (void) printViewControllerTrackList;

@end

#pragma mark - 显示加载提示、加载进度
@interface UIViewController (ProgressHUD)
/**
 只显示一段文本的提示框，2s 自动消失
 */
- (void) showHUDWithText:(NSString*) text;
/**
 显示一段标题和内容描述的提示框，2s 自动消失
 */
- (void) showHUDWithText:(NSString*) text detailsText:(NSString*) details;
/**
 显示带有 activityIndicator 和描述信息的加载框，隐藏请使用dismissHUD。
 */
- (void) showHUDLoadingIndicator:(NSString*) loadingInfo;
/**
 显示带有进度和描述信息的加载框
 <li>更新进度，请使用updateHUDProgress:description:
 <li>隐藏提示框，请使用 dismissHUD
 */
- (void) showHUDLoadingProgress:(NSString*) loadingInfo;
/**
  更新带有进度的加载提示框的进度和描述信息
 */
- (void) updateHUDProgress:(CGFloat) progress description:(NSString*) description;
/**
 显示带有“√”状态和描述文本的提示框，3s 自动消失
 */
- (void) showHUDSuccess:(NSString*) successInfo;
/**
 显示带有“×”状态和描述文本的提示框，2s 自动消失
 */
- (void) showHUDFail:(NSString*) failInfo;
/**
 隐藏最后显示的提示框
 */
- (void) dismissHUD;

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

#pragma mark - 显示 ActionSheet
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









