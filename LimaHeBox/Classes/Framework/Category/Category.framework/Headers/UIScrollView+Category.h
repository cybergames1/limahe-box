//
//  UIScrollView+Category.h
//  Demo
//
//  Created by Sean on 15/6/19.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHPullToRefreshView;
@class SHPushToLoadMoreView;
@interface UIScrollView (UIScrollViewNetworkIndicator)

/**
 @details “下拉刷新”的控件，位于scrollView的上部，所有继承自的UIScrollView的控件都可以使用，比如：
           UITableView、UICollectionView、UIWebView等
 @attention 单纯的refreshHeaderView没有定制任何的显示内容，使用时我们需要自己定制一个继承自SHPullToRefreshView的 view，
            然后在里面实现<b style="color:#ff0000">-refreshUpdateState:</b>方法。
 */
@property (nonatomic, retain) SHPullToRefreshView* refreshHeaderView;

/**
 @details “上滑加载更多”的控件，位于scrollView的下部，所有继承自的UIScrollView的控件都可以使用，比如：
          UITableView、UICollectionView、UIWebView等
 @attention 单纯的loadmoreFooterView没有定制任何的显示内容，使用时我们需要自己定制一个
            继承自SHPushToLoadMoreView的view，然后在里面
            实现<b style="color:#ff0000">-loadMoreUpdateState:</b>方法。
 */
@property (nonatomic, retain) SHPushToLoadMoreView* loadmoreFooterView;

@end


typedef NS_OPTIONS(NSInteger, SHRefreshStatus) {
    SHRefreshStatusDefault = 0,    // 初始状态
    SHRefreshStatusMoving = 1,     // 中间发生变化的状态（刷新或者分页还未有触发的过程，可以通过progress值变更状态）
    
    SHRefreshStatusTriggered = 10, // 条件被触发（下一个动作为 loading）
    SHRefreshStatusLoading = 11,   // 正在加载数据
};

//block 定义
typedef void(^StatusBlock) (SHRefreshStatus status);

#pragma mark - 下拉刷新控件：SHPullToRefreshView
@interface SHPullToRefreshView : UIView
/**
 @brief 设置“下拉”控件是否有效。
 @details 此控件用来控制“下拉刷新”控件能否显示、滑动列表是否能起作用的开关。
          当设置 NO(无效)时，控件自动隐藏，并且列表滑动对控件不会起作用。默认设置为YES
 */
@property (nonatomic, assign,getter=isEnable) BOOL enable;
/**
 状态 Block
 */
@property (nonatomic, copy) StatusBlock statusBlock;

/**
 @brief 当前是否正在加载数据
 */
@property (nonatomic, readonly) BOOL isLoading;

/**
 @brief 触发刷新的滑动距离，默认值=控件高度。该值不能设置为负数
 */
@property (nonatomic, assign) CGFloat triggerOffset;

/**
 @brief 如果下拉过程中需要做细节动画，通过pullProgress获取当前下拉的幅度（0.0 ~ 1.0之间）
 */
@property (nonatomic, readonly) CGFloat pullProgress;
/**
 @brief 在没有滑动列表的情况下调用该 API，列表会自动产生一个下拉的动画，然后调用refreshUpdateState:(或者block)，
        相当于滑动列表并触发了刷新的动作。
 */
- (void)beginRefreshing;

/**
 @brief 当刷新的操作完成后(拿到新数据或者发生错误，总之，刷新结束了的时候)，需要调用该 API 恢复刷新控件的状态。
 @note <b style="color:#0000ff"> 任何情况下的恢复刷新状态都需要调用该API。</b>
 */
- (void)endRefreshing;

#pragma mark - 需要子类覆盖的方法
/**
 下拉控件的过程中时时更新控件状态
 @code
     - (void) refreshUpdateState:(SHRefreshStatus)status
     {
         switch (status) {
         case SHRefreshStatusMoving:
         {
             // 显示“上次刷新：刚刚”，也可以在这里做其他动画
             break;
         }
         case SHRefreshStatusTriggered:
         {
             // 显示“松手开始刷新”
             break;
         }
         case SHRefreshStatusLoading:
         {
             // 显示“正在刷新...”
             // 向服务器请求数据，在网络回调里调用-endRefreshing
             break;
         }
         default:
         {
             // 显示“上次刷新：刚刚”
             break;
         }
     }
 @endcode
 
 @note <b style="color:#0000ff"> 该方法需要开发者在继承子类中覆盖。</b>
 */
- (void) refreshUpdateState:(SHRefreshStatus) status;

@end

#pragma mark - 加载更多控件：SHPushToLoadMoreView
@interface SHPushToLoadMoreView : UIView
/**
 @brief 设置“加载更多”控件是否有效。
 @details 此控件用来控制“加载更多”控件能否显示、滑动列表是否能起作用的开关。
          当设置 NO(无效)时，控件自动隐藏，并且列表滑动对控件不会起作用。默认设置为YES
 */
@property (nonatomic, assign,getter=isEnable) BOOL enable;
/**
 @brief 当前是否正在加载数据
 */
@property (nonatomic, readonly) BOOL isLoading;

/**
 格式化的显示文本，比如：“正在加载...”
 */
@property (nonatomic, retain) NSAttributedString *attributedTitle;

/**
 状态 Block
 */
@property (nonatomic, copy) StatusBlock statusBlock;

/**
 @brief 在没有滑动列表的情况下调用该API，列表会自动显现，然后调用loadMoreUpdateState:(或者block)，
        相当于滑动列表并触发了刷新的动作。
 */
- (void) beginLoadMore;
/**
 @brief 当加载的操作完成后(拿到新数据或者发生错误，总之，加载结束了的时候)，需要调用该 API 恢复刷新控件的状态。
 @note <b style="color:#0000ff"> 任何情况下的恢复加载控件状态都需要调用该API。</b>
 */
- (void) endLoadMore;

#pragma mark - 需要子类覆盖的方法
/**
 加载更多控件滑动的过程中时时更新控件状态
 @code
     - (void) loadMoreUpdateState:(SHRefreshStatus)status
     {
         if (SHRefreshStatusLoading == status) 
         {
             // 显示“正在加载...”
             // 向服务器请求数据，在网络回调里调用-endLoadMore
         }
     }
 @endcode
 
 @note <b style="color:#0000ff"> 该方法需要开发者在继承子类中覆盖。</b>
 */
- (void) loadMoreUpdateState:(SHRefreshStatus) status;

@end





