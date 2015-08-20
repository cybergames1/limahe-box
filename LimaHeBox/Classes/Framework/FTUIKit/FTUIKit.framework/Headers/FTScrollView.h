//
//  FTScrollView.h
//  FTDemo
//
//  Created by Sean on 13-11-12.
//  Copyright (c) 2013年 FTDemo. All rights reserved.

/**
 该scrollview具有UIScrollView的所有功能，同时做了适当扩充：
 1、支持循环滚动
 2、使用复用机制，占用内存小
 3、方便定制，可以通过delegate方法任意定制数据
 
 todo:后期会加上纵向滚动模式
 */

#import "FTDefine.h"

/*!
 item，如果要使用FTScrollView，你必须继承FTScrollItem
 */

@interface FTScrollItem : UIView
/** 
 data
 */
@property (nonatomic, retain) id data;

- (void) updateItem;

@end



@protocol FTScrollViewDelegate;

@class FTPageControl;
@interface FTScrollView : UIView

/**
 delegate
 */
@property (nonatomic, assign) id<FTScrollViewDelegate> delegate;

/**
 @briefs 是否支持循环模式，默认为YES。
 @details 如果YES，当滑到最后一张(向前滑到第一张)时再次滑动，会显示第一张(最后一张)。
 */
@property (nonatomic, assign) BOOL supportCirculation;

/**
 滚动方向，仅支持横向FTScrollDirectionLandscape
 */
@property (nonatomic, assign) FTScrollDirection scrollDirection;

/**
 是否显示页码指示，默认NO
 */
@property (nonatomic, assign) BOOL showPageIndicator;

/**
 页码指示的中心位置，只对showPageIndicator=YES有效
 */
@property (nonatomic, assign) CGPoint indicatorPosition;

/**
 返回默认的pageControl，调用者可以通过FTPageControl的属性定制不同样式。如果showPageIndicator=NO,则返回nil
 */
@property (nonatomic, readonly) FTPageControl* pageControl;

/**
 scrollview加载数据，重绘所有的界面
*/
- (void) scrollViewReloadData;
/**
 scrollView重新加载某个界面
 @details 该API首先会通过scrollView:itemAtIndex:更新item对应的数据然后重绘界面
*/
- (void) scrollViewReloadWithIndex:(NSInteger) index;

/**
 重用机制
 */
- (FTScrollItem*)dequeueReusableScrollItem;

@end

@interface FTScrollView(AutoScroll)
/**
 自动滚动到某一页
 @param index 指定的页。如果index非法，则什么都不做
 @param animated 是否动画展现
 */
- (void)autoScrollToIndex:(NSInteger)index animated:(BOOL)animated;

@end

/**
 delegate + dataSource
 */
@protocol FTScrollViewDelegate <NSObject>
@required
/**
  获取 scrollView 的总数量，当调用该 API 时，需要开发者告诉 scrollView 总共有多少个 items
 */
- (NSInteger) numberOfObjectsInScrollView:(FTScrollView*)scrollView;

/** 
 获取 index 位置的 item，调用者需要在这里配置 item 数据，调用结束后，系统自动展示该 item
*/
- (FTScrollItem*) scrollView:(FTScrollView *)scrollView itemAtIndex:(NSInteger)index;

@optional
/** 
 @briefs 滑动到某页时的回调，调用者可以在这里处理显示相关的事务
*/
- (void) scrollView:(FTScrollView*)scrollView didScrollToIndex:(NSInteger) index;

@end
