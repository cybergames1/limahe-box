//
//  UIImageView+Category.h
//  Demo
//
//  Created by Sean on 14-3-25.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import "CategoryDefine.h"
//#import "UIImage+Category.h"

#pragma mark UIImageView (UIImageViewAction) 响应点击事件
@interface UIImageView (UIImageViewAction)
/**
 @brief 给UIImageView增加点击方法，target和action需要配对才有效
 @note    target不会被retain，多次调用会覆盖前面的设置，只有最后一对有效
 @param target 相应的target，不能为nil
 @param action action方法，最多可带一个参数
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 @brief 移除UIImageView的所有Action方法。移除后，该 UIImageView 将不能再接受点击事件
 */
- (void)removeAllActions;

@end

/*!
 @brief 当UIImageView在调用setImage：方法时，我们可以给setImage添加一些动画，以实现完美过渡。
 UIImageView (ImageTransition)既是在做这个事情，它定义了transitionType和transitionDuration
 两个属性，可以指定动画的type和duration，默认动画功能是关闭的。
 */
#pragma mark UIImageView (ImageShowAnimation) 展示动画集成

@interface UIImageView (ImageTransition)
/**
 @brief 当给UIImageView赋image时的动画效果，默认TransitionTypeNone没有任何动画
 @Node 该方法需要在setImage:之前调用。动画的效果 @see TransitionType定义
 */
@property (nonatomic, assign) TransitionType transitionType;

/**
 @brief 展示SetImage：动画的时间，默认1.0
 @details 如果transitionType=TransitionTypeNone，设置该项无效。
 @Node 注意该属性与@see animationDuration的区别。
 */
@property (nonatomic, assign) CGFloat transitionDuration;

@end

// 网络图片加载策略
typedef NS_ENUM(NSInteger, UIImageViewCachePolicy) {
    UIImageViewCachePolicyDefault = 0,       //优先读取缓存，没有缓存再加载网络。该属性为默认项。
    UIImageViewCachePolicyNetwork = 10,      //不读缓存，只加载网络数据
    UIImageViewCachePolicyCache = 20,        //只读取本地缓存（包括内存缓存），从不加载网络
};

#if NS_BLOCKS_AVAILABLE
// image download progress block
typedef void(^ImageDownloadProgressBlock)(long long receivedData, long long expectedData);

// image download result block
typedef void(^ImageDownloadFinishBlock)(UIImage* image, NSError* error);

// image download result block
typedef void(^ImageDataBlock)(NSData* imageData, NSError* error);
#endif

#pragma mark UIImageView (UINetworkImageView) 网络图片加载
@interface UIImageView (UINetworkImageView)
/**
 @brief 图片加载策略，默认为UIImageViewCachePolicyDefault，优先加载缓存，缓存不存在再加载网络
 */
@property (nonatomic, assign) UIImageViewCachePolicy cachePolicy;

/**
 @brief 占位图，默认nil
 @note 如果设置placeholderImage，在下载网络图片之前或者下载失败后，自动显示placeholderImage占位图。
 */
@property (nonatomic, retain) UIImage* placeholderImage;

/**
 @brief 图片的url，默认情况下为nil
 @note 设置图片imageUrl并不会立马下载图片，需要手动调用startLoadNetworkImage:completion:开始下载
 */
@property (nonatomic, retain) NSString* imageURL;

/**
 开始下载图片，下载完自动替换为新图片
 */
- (void) startDownload;

/**
 @brief 从网上下载图片，使用的url为属性imageURL提供的url
 
 @param imageURLString 图片的网络 url 地址
 @param progressBlock 如果能检测到下载得进度信息，可以通过设置该block获得进度。如果不需要进度，可以设为nil
 @param finishBlock 下载完成后回调block，下载的数据存放在image中。
                    如果下载过程中发生错误，错误信息将放在error中，此时image=nil
 @see 如果不需要回调，请使用[imageView startDownload]
 
 @note 由于并不是所有得服务端都支持在网络的response中返回expectedContentLength，意味着expectedData可能为0。
       如果要计算实时进度，需要外部提供图片的总大小，但是receivedData是有效的数据。
 @attention 适用于iOS 5.0及之后版本.
 */
- (void) downloadImageWithProgressBlock:(ImageDownloadProgressBlock) progressBlock
                            finishBlock:(ImageDownloadFinishBlock) finishBlock;

/**
 @brief 从网上下载图片
 
 @param imageURLString 图片的网络 url 地址
 @param progressBlock 如果能检测到下载得进度信息，可以通过设置该block获得进度。如果不需要进度，可以设为nil
 @param finishBlock 下载完成后回调block，下载的数据存放在image中。
                    如果下载过程中发生错误，错误信息将放在error中，此时image=nil
 @see 如果不需要回调，请使用[imageView startDownload]
 
 @note 由于并不是所有得服务端都支持在网络的response中返回expectedContentLength，意味着expectedData可能为0。
       如果要计算实时进度，需要外部提供图片的总大小，但是receivedData是有效的数据。
 @code
     [_imageView downloadImage:_your_image_url_string
     progressBlock:^(long long receivedData, long long expectedData) {
         // you can update progress here.
     }finishBlock:^(UIImage *image, NSError *error) {
         if (image) {
             // your image is here,if you update UI,please on main theard
         }
         if (error) {
            // something is wrone
         } 
      }];
 @endcode
 @attention 适用于iOS 5.0及之后版本.
 */
- (void) downloadImage:(NSString*) imageURLString
         progressBlock:(ImageDownloadProgressBlock) progressBlock
           finishBlock:(ImageDownloadFinishBlock) finishBlock;

/**
 @brief 取消图片下载,销毁block等。
 @note 在UIImageView销毁之前，需要调用该接口
 */
- (void) cancleDownload;

@end

#pragma mark UIImageView (UIImageViewGIF) 展示GIF图片
/**
 @brief 播放Gif图片
 */
typedef void(^UIGifPlayBlock)(CGSize gifSize, NSError* error);

@interface UIImageView (UIImageViewGIF)
/** gif是否正在播放 */
@property (nonatomic, assign, readonly) BOOL isGifPlaying;

/**
 @brief 从网络加载网络gif数据、解析并播放gif
 @param finishBlock 结果回调
        gifSize：下载并成功解析，gifSize会包含gif图片的尺寸
        error：如果中间某个环节发生错误而造成失败，error标明失败原因。
 */
- (void) playRemoteGIFWithPath:(NSString*) url finishBlock:(UIGifPlayBlock) finishBlock;
/**
 @brief 解析并播放本地gif
 */
- (void) playGIFWithData:(NSData*) gifData finishBlock:(UIGifPlayBlock) finishBlock;

/**
 @brief 停止播放gif动画
 @note 如果
 */
- (void) stopGifAnimating;

/**
 取消 Gif 的下载和播放
 */
- (void) cancleLoadAndPlay;
@end









