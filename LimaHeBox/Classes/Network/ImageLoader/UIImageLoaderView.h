//
//  UIImageLoaderView.h
//  Papaqi
//
//  Created by Sean on 15/7/30.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//
/**
 带有网络功能的UIImageView
 */
#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@protocol UIImageLoaderViewDelegate;

@interface UIImageLoaderView : UIImageView
/** 图片资源的链接地址或者本地的完整存储地址 */
@property (nonatomic, retain) NSString *urlString;
/** 
 我们设置的urlString可能取不到图片资源，这时候可以通过设置placeHoderImageURLString
 加载备用图片。如果该地址也没有图片或者没有设置，那么使用placeHoderImage显示。默认 nil */
@property (nonatomic, retain) NSString *placeHoderImageURLString;

/** 图片加载策略，默认SDWebImageLowPriority */
@property (nonatomic, assign) SDWebImageOptions options;

/** 代理 */
@property (nonatomic, assign) id<UIImageLoaderViewDelegate> delegate;

/** 展位图，未加载图片或者加载失败时显示 */
@property (nonatomic, retain) UIImage *placeHoderImage;
/** 其他格外信息 */
@property (nonatomic, retain) NSDictionary *userInfo;

/** 开始下载图片资源 */
- (void) startLoad;
/** 取消尚未完成的下载任务 */
- (void) cancelLoad;

@end

@protocol UIImageActionDelegate;
@interface UIImageLoaderView (ImageViewAction)
/** 图片点击的delegate */
@property (nonatomic, assign) id<UIImageActionDelegate> actionDelegate;

@end

//图片下载代理
@protocol UIImageLoaderViewDelegate <NSObject>
@optional
/** 图片下载刚开始后的回调 */
- (void) imageLoaderDidStartLoad:(UIImageLoaderView *)view;
/** 图片下载完成的回调 */
- (void) imageLoaderDidFinishLoad:(UIImageLoaderView *)view;
/** 图片下载失败的回调 */
- (void) imageLoader:(UIImageLoaderView *)view hasError:(NSError *)error;

@end

@protocol UIImageActionDelegate <NSObject>

@optional
/** 如果设置图片可点，点击后的回调 */
- (void) imageActionDidTouch:(UIImageLoaderView *)view;

@end
