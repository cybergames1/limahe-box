//
//  UIImage+Category.h
//  Demo
//
//  Created by Sean on 14-3-25.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark UIImage (UIImageDecode) 图片解析
@interface UIImage (UIImageDecode)

/**
 @details 解析图片
 @param image 需要处理的图片
 @return 返回新图片。nil如果image 无效或者为空。如果 image 是一系列的动画，则返回原始 image。
 */
+ (UIImage *)decodedImageWithImage:(UIImage *)image;

/**
 @details 解析图片
 @param image 需要处理的图片
 @param size 新图片要求的最大尺寸。如果原始图片超过该尺寸，则按照稍小的边【按比例】缩放
 @return 返回新图片。nil如果image 无效或者为空。如果 image 是一系列的动画，则返回原始 image。
 */
+ (UIImage *)decodedImageWithImage:(UIImage *)image maximumSize:(CGSize)size;

/**
 @details 解析图片
 @param imageRef 需要处理的图片
 @return 返回新图片。NULL如果imageRef为空。
 */
+ (UIImage *)decodedImageWithImageRef:(CGImageRef)imageRef;

/**
 @details 解析图片
 @param imageRef 需要处理的图片
 @param size 目标图片的最大尺寸。如果原始图片超过该尺寸，则按照稍小的边【按比例】缩放
 @param scale 解析图像数据时要使用的缩放比例，0代表系统自动适配。
 @param imageOrientation 图片方向
 @return 返回新图片。NULL如果imageRef为空。
 */
+ (UIImage *)decodedImageWithImageRef:(CGImageRef)imageRef
                          maximumSize:(CGSize)size
                                scale:(CGFloat) scale
                     imageOrientation:(UIImageOrientation) imageOrientation;
@end

#pragma mark UIImage (UIImageGif)
@interface UIImage (UIImageGif)
/**
 用gif文件初始化一个可以动态播放的 image
 @param gifData gif元数据，不能为 nil
 @details 该 UIImage 可以直接付给 UIImageView 并调用 startAnimation 播放
 @note 由于该方法是把gif中所有图片解析，所以内存占用较多，但是播放中性能较好，cpu 使用量低。
 
 @code
 
 UIImageView* _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 300, 200)];
 _gifImageView.image = [UIImage imageWithGifData:yourGifData];
 [self.view addSubview:_gifImageView];
 [_gifImageView startAnimating];
 
 @endcode
 */
+ (UIImage*) imageWithGifData:(NSData*) gifData;

@end

#pragma mark UIImage (BundleImage) bundle图片

@interface UIImage (BundleImage)
/** 
 @brief 从mainBundle获取指定名字的图片
 @details 指定的名字可以带后缀，也可以不带后缀。如果不带，默认类型为“png”。
 @note 系统不会自动缓存该图片，如果要缓存图片，请自己管理缓存策略
 @param name 图片的名字(比如"imageName.png")，可以不带后缀(比如"imageName")
 @return 返回找到的图片，nil如果没有找到该图片
 */
+ (UIImage*) bundleImageNamed:(NSString*)name;

/**
 @brief 从mainBundle获取指定名字的图片，默认类型为“png”。在该方法中，自动寻找名称为“name@2x.type"
        资源，如果没找到，则尝试寻找名称为“name.type"的资源并返回。如果name本身就包含“@2x”标示，那么直接
        返回名称为“name@2x.type"的资源
 @note 系统不会自动缓存该图片，如果要缓存图片，请自己管理缓存策略
 @param name 图片的名字，名字不能带后缀
 @param type 图片的格式类型，“png”、“jpg”等
 @return 返回找到的图片，nil如果没有找到该图片
 */
+ (UIImage*) bundleImageWithName:(NSString*)name ofType:(NSString*) type;

@end

#pragma mark UIImage (UIImageCacheManager) 图片缓存及管理
@interface UIImage (UIImageCacheManager)
/**
 @brief 设置默认的缓存地址。如果不设置，默认~Library/CachedImages
 @param defaultPath 默认缓存地址
 */
+ (void) ImageCacheSetDefaultCacheDirectoryPath:(NSString*) defaultPath;

/**
 @brief 清空所有缓存的图片
 @param alsoMemory 是否连缓存在内存中的也清除。YES表示清除内存缓存
 */
+ (void) ClearAllCachedImages:(BOOL) alsoMemory;

/**
 @brief 缓存图片到文件，同时缓存到内存中（依据alsoMemory选项）
 @param url 图片的url，不能为nil
 @param inMemory 是否同时在内存中缓存
 */
- (void) storeImageWithUrl:(NSString*) url alsoInMemory:(BOOL) alsoMemory;
/**
 @brief 缓存图片到文件，同时缓存到内存中（依据alsoMemory选项）
 @param key 图片的url的 md5值，不能为nil
 @param inMemory 是否同时在内存中缓存
 */
- (void) storeImageForKey:(NSString*) key alsoInMemory:(BOOL) alsoMemory;

/**
 只在内存缓存图片
 @note 由于内存有限，太大尺寸的图片不能缓存在内存里。
 */
- (void) memoryStoreImageForKey:(NSString*) key;

/**
 @brief 缓存图片到文件，同时缓存到内存中（依据alsoMemory选项）
 @param image 要保存的图片信息
 @param url 图片的url，不能为nil
 @param inMemory 是否同时在内存中缓存
 */
+ (void) storeImage:(UIImage*) image withUrl:(NSString*) url alsoInMemory:(BOOL) alsoMemory;

/**
 @brief 缓存图片到文件，同时缓存到内存中（依据alsoMemory选项）
 @param image 要保存的图片信息
 @param key 图片的url的 md5值，不能为nil
 @param inMemory 是否同时在内存中缓存
 */
+ (void) storeImage:(UIImage*) image forKey:(NSString*) key alsoInMemory:(BOOL) alsoMemory;

/**
 @brief 获取之前缓存的图片资源
 @param url 图片的url地址
 @details 首先会从内存缓存中查找，如果在内存中没有缓存，那么从本地磁盘查找。
 @note 由于可能会读取磁盘，故，为了不堵塞主线程，最好在子线程中调用。
 */
+ (UIImage*) cachedImageWithUrl:(NSString*) url;

/**
 @brief 获取之前缓存的图片资源
 @param key 图片的url得 md5
 @details 首先会从内存缓存中查找，如果在内存中没有缓存，那么从本地磁盘查找。
 @note 由于可能会读取磁盘，故，为了不堵塞主线程，最好在子线程中调用。
 */
+ (UIImage*) cachedImageForKey:(NSString*) key;
/**
 @brief 获取在内存中缓存的图片资源，不会读取磁盘
 @param key 图片的url得 md5
 */
+ (UIImage*) memoryCachedImageForKey:(NSString*) key;

@end

#pragma mark UIImage (ResizeMagick) 裁剪图片
@interface UIImage (UIImageScaleCrop)
/** 按照指定的尺寸缩放图片（如果需要，可能会有拉伸）
 *
 * @param newSize      指定的目标尺寸
 * @param contentMode  缩放模式，目前只支持`UIViewContentModeScaleToFill`, 
                       `UIViewContentModeScaleAspectFill`, 或者
 *                     `UIViewContentModeScaleAspectFit`.
 */
- (UIImage*)imageByScalingToSize:(CGSize)newSize
                     contentMode:(UIViewContentMode)contentMode;


/** 按照指定的尺寸缩放图片（如果需要，可能会有拉伸）
 *
 * @param newSize 指定的目标尺寸
 */

- (UIImage*)imageByScalingToFillSize:(CGSize)newSize;

/** 按照指定的尺寸缩放图片（如果需要，会裁剪）
 *
 * @param newSize 指定的目标尺寸
 */

- (UIImage*)imageByScalingAspectFillSize:(CGSize)newSize;

/** 按照指定的尺寸缩放图片（如果需要，会有拉伸）
 *
 * @param newSize 指定的目标尺寸
 */

- (UIImage*)imageByScalingAspectFitSize:(CGSize)newSize;

@end

#pragma mark UIImage (ColorImage) 获取纯色图片
@interface UIImage ( UIImageFromColor)
/**
 根据指定的颜色和大小生成纯色图片
 @param color 纯色图片的颜色，如果传nil，则用默认颜色grayColor
 @param size 图片尺寸
 */
+ (UIImage *) imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 根据指定的颜色、大小和模糊级别生成纯色的模糊图片
 @param color 纯色图片的颜色，如果传nil，则用默认颜色whiteColor
 @param size 图片尺寸
 @param level 模糊级别，0.0~1.0之间，该值越大，图像越模糊
 */
+ (UIImage*) bluredImageWithColor:(UIColor*) color
                        imageSize:(CGSize) size
                        blurLevel:(CGFloat) level;

/**
 Return if this image has alpha channel.
 */
- (BOOL)hasAlphaChannel;

@end

#pragma mark UIImage (SnapshotImage) 屏幕截图
@interface UIImage (SnapshotImage)
/**
 @details 获取指定UIView的屏幕截图
 @param view 指定的view
 @param opaque 透明度
 @param fullContent 截图是否包括超出屏幕的部分
 
 @note 该获取截图的方法只是截取view的全部内容，但是不会遍历它的subview，意思就是，如果某个subview
       内容很多，有些超出的view的界限，即使设置了fullContent，这部分内容也不会被截取到。
 @return 返回生成的截图，nil如果获取失败。
 */
+ (UIImage*) snapshotImageForView:(UIView*)view
                           opaque:(BOOL) opaque
                      fullContent:(BOOL) fullContent;

/**
 获取当前界面的截图（UIKit类型）
 @details 获取当前显示的屏幕截图，如果当前界面有多层Window，那么会按照window
          的层级显示生成一张图。
 @note    由于AppleAPI的更改，在IOS7以后的系统上再无法获取UIAlertView、UIStatusBarWindow等
          Window,所以返回的截图可能比实际显示的要少内容
 @return  返回生成的截图，nil如果获取失败。
 */
+ (UIImage*) snapshotImage;

/**
 获取当前界面的全图（UIKit类型）
 @details 获取手机界面的全图，如果当前界面有多层Window，那么会按照window
          的层级显示生成一张图。
 @note    由于AppleAPI的更改，在IOS7以后的系统上再无法获取UIAlertView、UIStatusBarWindow等
          Window,所以返回的截图可能比实际显示的要少内容
 @return  返回生成的截图，nil如果获取失败。
 */
+ (UIImage*) fullContentSnapshotImage;

/**
 获取当前界面的截图（OpenGL类型），如果当前界面有openGL绘制的内容，
 那么snapshotImage方法是得不到截图的，此时需要调用glSnapshotImage
 @node 该方法获取的指示openGL部分的图像，UIKit部分的得不到。如果要获取两部分的全图，需要
       手动生成，可以使用@see +(UIImage *)mergerImage:(UIImage *)image toImage:(UIImage *)originImage
 @return 返回生成的截图，nil如果获取失败。
 */
+ (UIImage*) glSnapshotImage;

@end

#pragma mark UIImage (ImageMerger) 图片合并
@interface UIImage (ImageMerger)
/**
 合并两张图片为一张新图片，新图片的尺寸与originImage的相同
 @node 如果image为空，则返回originImage。相同，originImage为空则返回image
 
 @param image 合并时处于上面的那张图片
 @param originImage 处于下面的那张图片
 @return 返回合并后的图片，nil如果失败
 */
+(UIImage *)mergerImage:(UIImage *)image toImage:(UIImage *)originImage;

@end

#pragma mark UIImage (SubImage) 图片分割裁切
@interface UIImage (SubImage)
/**
 获取一张图片的部分图片
 @param subRect 需要截取部分的区域
 */
- (UIImage *)subImageWithRect:(CGRect)subRect;

@end

/*!
 
 */
#pragma mark UIImage (ImageMerger) 图片模糊
@interface UIImage (ImageEffects)
/**
 @param color 着色颜色
 @note 饱和度1.8
 */
- (UIImage* )applyColorEffect:(UIColor*) color;
/**
 @param tintColor 着色颜色
 @note 饱和度默认为1.8
 */
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
/**
 @param blurRadius 模糊半径，该参数值越大，处理后的效果越模糊
 @param tintColor 着色颜色
 @param saturationDeltaFactor 饱和度，0代表黑色，值越大饱和度越高。
 @param maskImage mask图片
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

/**
 一种快捷简单的获取模糊图片的方法
 @param level 模糊级别，0.0~1.0之间，该值越大，图像越模糊
 @note 需要系统框架Accelerate.h的支持
 */
- (UIImage *)applyBlurWithLevel:(CGFloat)level;

@end






