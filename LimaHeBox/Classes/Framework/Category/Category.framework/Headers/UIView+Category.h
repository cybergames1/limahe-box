//
//  UIView+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"

#pragma mark UIView （Addition）view位置属性快捷访问
@interface UIView (UIViewAddition)
/** 设定Origin的Y值，不改变Size */
@property (nonatomic) CGFloat top;
/** 设置底部，相应会改变Origin的Y值，不改变Size */
@property (nonatomic) CGFloat bottom;
/** 设定Origin的X值，不改变Size */
@property (nonatomic) CGFloat left;
/** 设定右边，相应会设定Origin的X值，不改变Size */
@property (nonatomic) CGFloat right;
/** 改变Size，不改变Origin */
@property (nonatomic) CGFloat width;
/** 改变Size，不改变Origin */
@property (nonatomic) CGFloat height;

/** 改变Size，不改变Origin */
@property (nonatomic) CGSize size;
/** 设定Origin的值，不改变Size  */
@property (nonatomic) CGPoint origin;
/** 中心位置-x 坐标 */
@property (nonatomic) CGFloat centerX;
/** 中心位置-y 坐标 */
@property (nonatomic) CGFloat centerY;
@end

#pragma mark UIViewSnapshot 视图快照
@interface UIView (UIViewSnapshot)
/**
 获取view在当前屏幕显示的快照
 @note 如果要显示view所有的内容，请使用snapshotImageWithFullContent:并
       设置fullContent=YES。
 */
- (UIImage *)snapshotImage;

/**
 获取view的快照
 @param opaque 表示当前UIView是否不透明
 @param fullContent 是否是全部内容
 @note 对于UIScrollview及衍生出来的view，经常有出现在屏幕之外的部分，设置fullContent=YES
       会把屏幕之外的部分也显示出来，否则，只显示当前屏幕框定的部分
 @warning 该获取截图的方法只是截取view的全部内容，但是不会遍历它的subview，意思就是，如果某个subview
          内容很多，有些超出的view的界限，即使设置了fullContent，这部分内容也不会被截取到。
 */
- (UIImage *)snapshotImageWithOpaque:(BOOL) opaque
                         fullContent:(BOOL) fullContent;

/**
 获取view的快照
 @param opaque A Boolean flag indicating whether the bitmap is opaque
 @param fullContent 是否是全部内容
 @param afterUpdates 仅对 IOS7以后有效
 @note 对于UIScrollview及衍生出来的view，经常有出现在屏幕之外的部分，设置fullContent=YES
       会把屏幕之外的部分也显示出来，否则，只显示当前屏幕框定的部分
 @warning 该获取截图的方法只是截取view的全部内容，但是不会遍历它的subview，意思就是，如果某个subview
          内容很多，有些超出的view的界限，即使设置了fullContent，这部分内容也不会被截取到。
 */
- (UIImage *)snapshotImageWithOpaque:(BOOL) opaque
                         fullContent:(BOOL) fullContent
                  afterScreenUpdates:(BOOL) afterUpdates;
@end


/*!
 UIView的层级
 @details 引入这一概念后，所有的view再起superView中得层次关系会
 基于level的大小。默认的level=0
 */
#pragma mark UIViewLevel 试图层级
@interface UIView (UIViewLevel)
/**
 每个view的level,非负值，设置level会立即改变当前view在其supview中的层级关系。
 相同level的一组view，其层级关系由添加的先后决定，后添加的在最上层。
 
 @node level值越大，显示时越在上层。默认所有view的level值都为0
 */
@property (nonatomic, assign) NSInteger level;
/**
 以给定的level添加view.
 @details 对于某个view来说，它的level值越高，那么其在supview的层级
 结构中越处于顶部（level=2的View会盖住level=1的View）。相同
 level的view，后加入的会盖住最先加入的view。
 调用 addSubview: 默认level=0
 @param view 要添加的view，不能为nil
 @param level 指定的层级，如果传入的为负值，会置level=0.
 */
- (void) addSubview:(UIView *) view atLevel:(NSInteger) level;

/**
 当前view放到整个父视图列表的最上层
 */
- (void) beBringedToFront;

/**
 当前view放到整个父视图列表的最下层
 */
- (void) beSendedToBack;

/**
 打印 view 及其上层 view 的层及路径
 */
- (void) printViewHierarchyDescription;
/**
 按照层级关系打印view及其subview的信息
 */
- (void) printViewRecursiveDescription;

@end


#pragma mark UIViewController 试图控制器快捷访问
@interface UIView (UIViewController)
/**
 获取view所在的终极viewController
 @details 比如controller上的mainView添加view1，view1添加view2，
 那么mainView、view1、view2的viewController都是controller
 @note 如果当前view为UIWindow，返回nil
 */
- (UIViewController *)viewController;

/**
 获取view所在的navigationController， @see viewController
 */
- (UINavigationController *)navigationController;

/**
 获取view所在的tabBarController， @see viewController
 */
- (UITabBarController *)tabBarController;

@end

/*!
 view抖动的动画，可以用作输入框的提示抖动
 */
#pragma mark UIViewShake 视图shake

typedef NS_ENUM(NSInteger, UIShakeDirection) {
    UIShakeDirectionHorizontal = 0,  //水平晃动
    UIShakeDirectionVertical   = 1,  //竖直晃动
};

@interface UIView (UIViewShake)
/**
 以指定的参数晃动view
 @param times 晃动次数，需要大于0的值
 @param delta 晃动幅度，像素值，不能为0
 @note 默认水平晃动，每次晃动时间50ms
 */
- (void)shakeTimes:(int)times withDelta:(CGFloat)delta;

/**
 以指定的参数晃动view
 @param times 晃动次数，需要大于0的值
 @param delta 晃动幅度，像素值，不能为0
 @param shakeDirection 晃动方向
 @note 默认每次晃动时间50ms
 */
- (void)shakeTimes:(int)times
         withDelta:(CGFloat)delta
    shakeDirection:(UIShakeDirection)shakeDirection;

/**
 以指定的参数晃动view
 @param times 晃动次数，需要大于0的值
 @param delta 晃动幅度，像素值，不能为0
 @param interval 每晃动一次需要的时间
 @param shakeDirection 晃动方向
 */
- (void)shakeTimes:(int)times
         withDelta:(CGFloat)delta
          andSpeed:(NSTimeInterval)interval
    shakeDirection:(UIShakeDirection)shakeDirection;

@end

#pragma mark UIViewAminationsShortCut 快捷动画
/**
 UIView的快速动画
 */
#import "CategoryDefine.h"

typedef void (^AnimationFinish)(); //动画结束的block回调

@interface UIView (UIViewAminationsShortCut)

/**
 放大缩小的动画
 @param scaleSize 放大缩小的倍数
 @param duration 动画持续时间
 @param repeatCount 重复播放次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+ (CABasicAnimation*) scaleAnimation:(CGFloat) scaleSize
                            duration:(NSTimeInterval) duration
                         repeatCount:(NSUInteger) repeatCount
                         autoreverse:(BOOL) shouldAutoreverse;

/**
 旋转的动画
 @param angle 旋转的弧度（非角度）
 @param duration 动画持续时间
 @param direction 旋转方向，顺时针或者逆时针
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+ (CABasicAnimation*)rotateAnimation:(CGFloat) angle
                            duration:(NSTimeInterval) duration
                           direction:(TransitionType) direction
                         repeatCount:(NSUInteger) repeatCount
                         autoreverse:(BOOL) shouldAutoreverse;

/**
 翻转的动画
 @param duration 动画持续时间
 @param flipDirection 翻转方向，上、下、左、右
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+ (CATransition*)flipAnimation:(TransitionType) flipDirection
                      duration:(NSTimeInterval)duration
                   repeatCount:(NSUInteger)repeatCount
                   autoreverse:(BOOL)shouldAutoreverse;
/**
 位置移动的动画
 @param destination 目的地的位置（中心点的位置）
 @param duration 动画持续时间
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+ (CABasicAnimation *)moveAnimation:(CGPoint) destination
                           duration:(CGFloat) duration
                        repeatCount:(NSUInteger)repeatCount
                        autoreverse:(BOOL)shouldAutoreverse;

/**
 路径运动动画
 @param path 物体运动的路径，不能为nil
 @param duration 动画持续时间
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+ (CAKeyframeAnimation *)pathAnimation:(CGPathRef) path
                              duration:(CGFloat) duration
                           repeatCount:(NSUInteger)repeatCount
                           autoreverse:(BOOL)shouldAutoreverse;

/**
 明暗闪烁的动画
 @param opacity 透明度，0.0~1.0
 @param duration 动画持续时间
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用
       [self applyAnimation:yourAnimation forKey:@"yourAnimationKey" completion:{}];
 */
+(CABasicAnimation *)opacityAnimation:(CGFloat) opacity
                             duration:(CGFloat) dutation
                          repeatCount:(NSUInteger) repeatCount
                          autoreverse:(BOOL) shouldAutoreverse;
/**
 动画组
 @param animationArray 有效的动画（CAAnimation类型）的array
 @param duration 动画持续时间
 @param repeatCount 重复次数
 @param shouldAutoreverse 是否自动反方向动画
 @note 动画不会立即执行，需要手动调用 
       [self applyAnimation:yourAnimationGroup forKey:@"yourAnimationKey" completion:{}];
 */
+(CAAnimationGroup*)groupAnimation:(NSArray*) animationArray
                          duration:(NSTimeInterval) duration
                       repeatCount:(NSUInteger) repeatCount
                       autoreverse:(BOOL) shouldAutoreverse;

/**
 启动动画的播放
 @param animation 必须是有效的CAAnimation类型
 @param animationKey 动画的key，可以为nil
 @param completion 动画完成后的block
 @note 每次调用 applyAnimation:forKey:completion: 会覆盖掉之前的block回调。
       如果需要一次执行多个动画，请先初始化一个CAAnimationGroup，然后执行group动画。
 */
- (void) applyAnimation:(CAAnimation*) animation
                 forKey:(NSString*) animationKey
             completion:(AnimationFinish)completion;

/**
 停止指定key对应的动画
 @note 该方法只能停止基于CAAnimation启动的动画
 */
- (BOOL) stopAnimationForKey:(NSString*) key;

/**
 停止所有正在进行的动画
 @note 该方法只能停止基于CAAnimation启动的动画
 */
- (BOOL) stopAllAnimations;
@end


#pragma mark UIViewAlignment 视图对齐模式
typedef NS_ENUM(NSInteger, UIViewAlignment){
	UIViewAlignmentTop                  = 1 << 0,
	UIViewAlignmentBottom               = 1 << 1,
	UIViewAlignmentLeft                 = 1 << 2,
	UIViewAlignmentRight                = 1 << 3,
	UIViewAlignmentCenterHorizontal     = 1 << 4,
	UIViewAlignmentCenterVertical       = 1 << 5,
    
	UIViewAlignmentCenter               = UIViewAlignmentCenterHorizontal |
                                          UIViewAlignmentCenterVertical
};

@interface UIView (UIViewAlignment)

/**
 以指定的对齐模式显示view
 @param align 对齐模式
 */
- (void) alignment:(UIViewAlignment)align;

/**
 以指定的对齐模式显示view
 @param align 对齐模式
 @param edge 偏移量
 
 @note 需要在调用addSubview：之后设置
 */
- (void) alignment:(UIViewAlignment)align margins:(UIEdgeInsets)edge;

/**
 以指定的对齐模式显示view
 @param align 对齐模式
 @param rect 当前view所在supview的区域
 
 @note 需要在调用addSubview：之后设置
 */
- (void) alignment:(UIViewAlignment)align ofRect:(CGRect)rect;

/**
 以指定的对齐模式显示view
 @param align 对齐模式
 @param edge 偏移量
 @param rect 当前view所在supview的区域
 */
- (void) alignment:(UIViewAlignment)align ofRect:(CGRect)rect margins:(UIEdgeInsets)edge;

@end


#pragma mark UIViewBorderMasks 视图边框
typedef NS_ENUM(NSInteger, UIViewBorderMask) {
    UIViewBorderMaskNone = 0,
    
    UIViewBorderMaskTopOnly = 1,           //上边
    UIViewBorderMaskBottomOnly = 2,        //下面
    UIViewBorderMaskTopBottom = 5,         //上、下边
    
    UIViewBorderMaskLeftOnly = 10,         //左边
    UIViewBorderMaskRightOnly = 11,        //右边
    UIViewBorderMaskLeftRight = 15,        //左右两边
    
    UIViewBorderMaskRoundrect = 20141220,  //圆角矩形
    UIViewBorderMaskCircle  = 20141221,    //圆形
};

/*!
 @note 该方法需要<QuartzCore/QuartzCore.h>支持
 */
@interface UIView (UIViewBorderMasks)
/**
 给UIView设置边框
 @param corners 圆角样式
 @param radius 圆角半径
 @note 默认边框宽度为1像素，颜色为白色
 */
- (void)applyBoardMasks:(UIViewBorderMask)corners
                 radius:(CGFloat) radius;

/**
 只在 view 的底部加一条分割线，比如 cell 的分割线
 @param lineWidth 分割线宽度
 @param lineColor 分割线颜色
 */
- (void) applyBottonLine:(CGFloat) lineWidth
               lineColor:(UIColor*) lineColor;

/**
 只在 view 的顶部加一条分割线
 @param lineWidth 分割线宽度
 @param lineColor 分割线颜色
 */
- (void) applyTopLine:(CGFloat) lineWidth
            lineColor:(UIColor*) lineColor;

/**
 在 view 的顶部和底部各加一条分割线
 @param lineWidth 分割线宽度
 @param lineColor 分割线颜色
 */
- (void) applyTopBottomLine:(CGFloat) lineWidth
                  lineColor:(UIColor*) lineColor;

/**
 给UIView设置边框，边框样式、宽度、颜色等由外部指定
 @param corners 边框样式.
 @param borderWidth 边框宽度，如果传0，边框不会被绘制
 @param borderColor 边框颜色，如果传 nil，边框不会被绘制
 @param lineDash 边框线间断模式(“- - -”还是“—————”)。
                 0（NO）代表是实线“—————”，没有间隔.1（YES）代表虚线“- - -”。
                 该值只在borderWidth>0或者borderColor有值的情况下有效
 @param radius 圆角半径，需要非负数
 @note radius参数仅对UIViewBorderMaskRoundrect有效，对于UIViewBorderMaskTop、
        UIViewBorderMaskLeft、UIViewBorderMaskBottom、UIViewBorderMaskRight四中类型来说，radius 永远是0.
        而对于UIViewBorderMaskCircle类型，redius自动以较长边的一半为半径。
 */
- (void)applyBoardMasks:(UIViewBorderMask) corners
            borderWidth:(CGFloat) borderWidth
            borderColor:(UIColor*) borderColor
          lineDashWidth:(CGFloat) lineDash
                 radius:(CGFloat) radius;

/**
 给UIView设置圆角边框，宽度和颜色由外部指定
 @param borderWidth 边框宽度，如果传0，边框不会被绘制
 @param borderColor 边框颜色，如果传 nil，边框不会被绘制
 @param radius 圆角半径，需要非负数
 */
- (void) applyRoundRectMask:(CGFloat) borderWidth
                borderColor:(UIColor*) borderColor
                     radius:(CGFloat) radius;
/**
 给UIView设置圆形边框,边框颜色为白色，边框宽度borderWidth=1px,lineDash=0
 */
- (void)applyCircleMasks;

/**
 给UIView设置圆形边框
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)applyCircleMasks:(CGFloat) borderWidth
             borderColor:(UIColor*) borderColor;

/**
 给UIView设置圆形边框,边框宽度、颜色由外部指定
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param lineDash 边框线间断间隔(比如：- - -)。0代表是实线，没有间隔.
                 该值只在borderWidth>0或者borderColor有值的情况下有效
 */
- (void)applyCircleMasks:(CGFloat) borderWidth
             borderColor:(UIColor*) borderColor
           lineDashWidth:(CGFloat) lineDash;

/**
 去掉之前设置的 boardMask
 */
- (void) removeAllBoardMasks;

@end


#pragma mark UIViewRemoveSubview清除所有子view
@interface UIView (UIViewRemoveSubview)

/**
 清除所有类型的subview
 */
- (void) removeAllSubviews;

/**
 清除特定类型的subview
 @param theClass 需要清除的子view的class类型
 @note 如果传入的theClass为nil，则清除所有subview
 */
- (void) removeSubviewsForClass:(Class) theClass;

/**
 清除特定类型以外的所有subview
 @param theClass 不能清除的子view的class类型
 @note 如果传入的theClass为nil，则清除所有subview
 */
- (void) removeSubviewsExceptClass:(Class) theClass;

@end

#pragma mark UIViewRemoveSubview清除所有Gesture
@interface UIView (UIViewRemoveGesture)

/**
 清除所有类型的gesture
 @note 对于继承自UIScrollView的view，谨慎使用，因为可能会把系统创建的gesture清理掉
 */
- (void) removeAllGestures;

/**
 清除特定类型的gesture
 @param theClass 需要清除的gesture的class类型
 @note 如果传入的theClass为nil，则清除所有gesture
 */
- (void) removeGesturesForClass:(Class) theClass;

@end










