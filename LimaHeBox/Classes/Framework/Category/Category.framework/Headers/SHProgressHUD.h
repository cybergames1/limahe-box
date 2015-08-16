//
//  SHProgressHUD.h
//  Demo
//
//  Created by Sean on 15/6/4.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "Category.h"

//progressHUD block
typedef void (^ProgressHUDBlock)(BOOL isFinish);

/** HUD样式定义 */
typedef NS_OPTIONS(NSInteger, HUDMode) {
    HUDModeTextOnly = 0,            //只显示文本，默认项
    
    HUDModeActivityIndicator = 10,  //加载状态，显示indicator + 文本(如果有)
    HUDModeActivityCircle = 11,     //加载状态，显示转动的未闭口的圆环 + 文本(如果有)
    
    HUDModeProgressRing = 20,       //进度条，环形进度 + 文本(如果有)
    HUDModeProgressBar = 21,        //进度条，条状Bar进度 + 文本(如果有)
    
    HUDModeSuccess = 50,            //状态：成功状态✅+文本(如果有)
    HUDModeFail = 51,               //状态：失败状态❎+文本(如果有)
};

/** HUD背景样式定义 */
typedef NS_OPTIONS(NSInteger, HUDBackgroundType) {
    HUDBackgroundTypeDefault,     //默认项，背景图不作任何处理
    HUDBackgroundTypeBlurred,     //高斯模糊HUD背景
};

@interface SHProgressHUD : UIView
/** 获取默认的 SHProgressHUD */
+ (SHProgressHUD*) defaultProgressHUD;

/**
 默认mode=HUDModeTextOnly
 */
@property (nonatomic, assign) HUDMode mode;

/**
  显示 ProgressHUD
 @param mode HUD类型，文本、进度、状态...
 @param backgroundType 背景样式，是否使用高斯模糊
 @param text 需要显示的文本信息，最多支持3行显示
 @param detailsText 文本的详细描述，字数不限 <i style="color:#ff0000">（仅对HUDModeTextOnly有作用）</i>
 @param progress 初始进度 <i style="color:#ff0000">(仅对HUDModeProgressRing、HUDModeProgressBar有效)</i>
 @param superView 需要加载 progressHUD 的父view，如果传 nil，则使用 keyWindow。
 @code
  [SHProgressHUD showHUD:HUDModeProgressIndicator 
          backgroundType:HUDBackgroundTypeDefault
                 text:@"显示一段文本提示"
                 detailsText:@"这里可以放置文本提示的详细描述信息"
                 progress:0 
                 onView:nil];
 @endcode
 */
+ (void) showHUD:(HUDMode) mode
  backgroundType:(HUDBackgroundType) backgroundType
            text:(NSString*) text
     detailsText:(NSString*) detailsText
        progress:(CGFloat) progress
          onView:(UIView*) superView;
/**
 隐藏正在显示的 ProgressHUD
 */
+ (void) dismissProgressHUD;

/**
 显示自定义的 HUD
 @param superView 在哪个 view 上显示该 HUD，如果传 nil，HUD 将加载到 KeyWindow
 */
- (void) showOnView:(UIView*) superView;

/**
  隐藏 HUD
 */
- (void) dismiss;

@end

#pragma mark - 设备翻转
@interface SHProgressHUD (HUDTools)

/**
 强制 HUD 跟随设备旋转，即使应用本身不支持横屏放置。默认NO，HUD显示与app界面显示保持一致
 @details 多数情况下我们的应用是支持竖屏，或者只支持横屏，这种情况下，HUD自然与app主界面保持一致。
          但是可能我们会有这种需求，当屏幕发生反转时，界面还是保持不动，但是想提示HUD随设备旋转，
          此时，只要通过 -enforceLayoutWhenDeviceOrientationChanged:设置即可。
 */
+ (void) enforceLayoutWhenDeviceOrientationChanged:(BOOL) enforce;

/**
 点击 HUD 界面自动 dismiss。如果设置了 block，该 block 会触发。
 @note 对于下列方法：
  <li> + showHUDText:
  <li> + showHUDText: detailText:
  <li> + showHUDIndicatorActivityWithText:
  <li> + showHUDCircleActivityWithText:
  <li> + showProgress: text:            <br>
  该方法只在紧跟着+ AutomaticDismissHUDWhenTap方法之后的HUD有效，该HUD被dismiss后自动失效。
  故，使用该方法需要每次在show之前调用。
 */
+ (void) automaticDismissHUDWhenTap;

/**
 @brief 是否禁止用户点击HUD下面的内容。
 @details 如果设置YES，则HUD会阻止用户的所有触摸屏幕的动作，直到HUD消失。
          如果设置为 NO，HUD及上面的所有控件都不可点击，但是HUD下面屏幕上的内容可以。
          默认禁止用户交互。
 */
+ (void) markDisablUserInteraction:(BOOL) disable;

@end

#pragma mark - 背景 blur
@interface SHProgressHUD (HUDBackground)
/** 背景样式，默认固定样式：白色，0.96透明度 */
@property (nonatomic,assign) HUDBackgroundType backgroundType;

/** 自定义背景图片 */
@property (nonatomic, retain) UIImage* customBackgroundImage;
/** 自定义背景颜色 */
@property (nonatomic, retain) UIColor* customBackgroundColor;

/**
 使用自定义背景图片
 */
+ (void) applyCustomBackgroundImage:(UIImage*) customImage;

/**
 使用自定义背景图片
 */
+ (void) applyCustomBackgroundColor:(UIColor*) customColor;

@end

#pragma mark - 快捷显示入口
@interface SHProgressHUD (HUDQuickShow)
/**
 只显示一条文本，2s自动消失
 */
+ (void) showHUDText:(NSString*) text;

/**
 显示标题+内容，2s自动消失
 */
+ (void) showHUDText:(NSString *)text detailText:(NSString*) detailText;

/**
 网络加载状态，没有进度
 @note 一个转动的Indicator+文本，不会自动消失
 */
+ (void) showHUDIndicatorActivityWithText:(NSString*) text;

/**
 网络加载状态，没有进度
 @note 一个转动的开口圆环+文本，不会自动消失
 */
+ (void) showHUDCircleActivityWithText:(NSString*) text;

/**
 网络加载进度
 @note 显示进度+文本
 */
+ (void) showProgress:(HUDMode) mode text:(NSString*) text;

/**
 更新进度（文本不变）
 */
+ (void) updateProgress:(CGFloat) progress animated:(BOOL) animated;
/**
 更新进度+文本
 */
+ (void) updateProgress:(CGFloat) progress textInfo:(NSString*) info animated:(BOOL) animated;

/**
 显示成功+文本，3s自动消失
 */
+ (void) showHUDSuccess:(NSString*) text;
/**
 显示失败+文本，2s自动消失
 */
+ (void) showHUDFail:(NSString*) text;

/**
 显示 HUD
 @param mode HUD样式：text or progress
 @param text 文本内容
 */
+ (void) showHUD:(HUDMode) mode text:(NSString*) text;

/**
 显示 HUD
 @param mode HUD样式：text or progress
 @param text 文本内容
 @param backgroundType 背景类型
 */
+ (void) showHUD:(HUDMode) mode
            text:(NSString*) text
  backgroundType:(HUDBackgroundType) backgroundType;

@end


#pragma mark - 文本字体属性设置
@interface SHProgressHUD (HUDTextProperty)
/** 设置文本内容，默认 nil*/
@property (nonatomic, Category_STRONG) NSString* text;
/** 设置文本字体，默认系统字体，16号，粗体*/
@property (nonatomic, Category_STRONG) UIFont* textFont;
/** 设置文本颜色，默认[UIColor blackColor] */
@property (nonatomic, Category_STRONG) UIColor* textColor;


/** 设置文本详情内容，默认 nil */
@property (nonatomic, Category_STRONG) NSString* detailsText;
/** 设置文本详情字体，默认系统字体，12号，粗体 */
@property (nonatomic, Category_STRONG) UIFont* detailsTextFont;
/** 设置文本详情颜色，默认[UIColor blackColor] */
@property (nonatomic, Category_STRONG) UIColor* detailsTextColor;

@end

#pragma mark - 进度属性设置
@interface SHProgressHUD (HUDProgressProperty)
/** 设置进度，动画展示进度变化 */
@property (nonatomic, assign) CGFloat progress;

/** 
 @details 进度条（环）的宽度
 <li> 对于mode=HUDModeProgressBar，默认宽度4.0
 <li> 对于 mode=HUDModeProgressRing，默认1.0
 */
@property (nonatomic, assign) CGFloat lineWidth;

/** 进度条的颜色，默认 <b style="color:#ff0000">[UIColor blackColor]</b> */
@property (nonatomic, Category_STRONG) UIColor* progressColor;

/** 进度条背景颜色，默认<b style="color:#ff0000">[UIColor colorWithWhite:0 alpha:0.2]</b> */
@property (nonatomic, Category_STRONG) UIColor* progressBackgroundColor;

/** 默认 <b style="color:#ff0000">[UIColor grayColor]</b> */
@property (nonatomic, Category_STRONG) UIColor* statusColor;

/**
 如果是HUDModeProgressRing模式，是否在 ring 中间显示进度百分比，默认 NO
 @note <b style="color:#ff0000"> 这是一个全局属性，设置后对所有SHProgressHUD有效 </b>
 */
+ (void) enableProgressIndicator:(BOOL) enable;

@end




