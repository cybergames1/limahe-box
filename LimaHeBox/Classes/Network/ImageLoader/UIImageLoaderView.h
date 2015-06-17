//
//  UIImageLoaderView.h
//  QiYiShare
//
//  Created by fangyuxi on 12-12-13.
//  Copyright (c) 2012年 iQiYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"
#import "UIImageViewWebCacheDelegate.h"
#import "SDWebImageManager.h"

/**
 @brief 带有网络功能的UIImageView
 
 **/

@class UIImageLoaderView;

@protocol UIImageLoaderViewDelegate <NSObject>

@optional

- (void) imageLoaderDidStartLoad:(UIImageLoaderView *)view;
- (void) imageLoaderDidFinishLoad:(UIImageLoaderView *)view;
- (void) imageLoader:(UIImageLoaderView *)view hasError:(NSError *)error;

@end

@protocol UIImageActionDelegate <NSObject>

@optional

- (void) imageActionDidTouch:(UIImageLoaderView *)view;

@end

@interface UIImageLoaderView : UIImageView<SDWebImageManagerDelegate>
{
    NSString *_urlString;
    id<UIImageLoaderViewDelegate> _delegate;
    id<UIImageActionDelegate> _actionDelegate;
    UITapGestureRecognizer* _gestureRecognizer;
}

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, assign) SDWebImageOptions options;
@property (nonatomic, assign) id<UIImageLoaderViewDelegate> delegate;
@property (nonatomic, assign) id<UIImageActionDelegate> actionDelegate;
@property (nonatomic, retain) UIImage *placeHoderImage;
@property (nonatomic, retain) NSDictionary *userInfo;
- (id) initWithURLString:(NSString *)urlString;

- (void) startLoad;
- (void) cancelLoad;

@end
