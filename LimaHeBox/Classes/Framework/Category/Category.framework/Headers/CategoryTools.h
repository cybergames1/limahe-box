//
//  CategoryTools.h
//  Demo
//
//  Created by SEAN on 14-8-16.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark UIGifImageParser 解析Gif图片的引擎

// 解析错误码说明
#define kGifParserErrorCodeDataNull      10010  //数据为空
#define kGifParserErrorCodeDataTypeError 10020  //数据类型错误
#define kGifParserErrorCodeDataReadError 10030  //数据读取错误
#define kGifParserErrorCodeCancled       10040  //操作被取消

/*!
 
 UIGifImage是为了解析gif图片而设计的引擎。可以选择同步解析和异步解析两种方式操作。
 配合UIImageView的category(UIImageViewGIF)使用可以完美展示gif图片
 
 */
@class UIGifImageFrame;
typedef void (^ParserBeginBlock) (UIImage* thumbImage, CGSize gifFrameSize);
typedef void (^ParserFinishBlock) (NSInteger framesCount, NSError * error);

@interface UIGifImageParser : NSObject
/**
 首图、预览图、封面图
 */
@property (nonatomic,retain,readonly) UIImage* thumbImage;

/**
 gif播放重复次数，0代表次数不限制，一直播放。
 */
@property (nonatomic,assign,readonly) NSUInteger loopCount;

/** 当前播放的帧序号。该属性只在播放时有效 */
@property (nonatomic, assign, readonly) NSInteger currentFrameIndex;

/** gif图片总帧数 */
@property (nonatomic, assign, readonly) NSInteger framesCount;

/** gif图片的宽高 */
@property (nonatomic, assign, readonly) CGSize frameSize;

/**
 用gifData初始化UIGifImageParser，调用该方法后，如果data非空，会立即解析gif文件
 */
- (instancetype)initWithGIFData:(NSData *)data;

/**
 异步解析gif文件，解析完成后通过block回调
 @param gifData gif文件
 @param beginBlock 解析正式开始后，会反馈 gif 封面信息
 @param finishBlock 解析完成后的回调block，
        framesCount：帧数 error：如果发生错误，错误信息会通过error回传
 @code
 
 @endcode
 @note 如果需要取消 parser，调用 cancleParser
 */
- (void) parserGIFData:(NSData*) gifData
            beginBlock:(ParserBeginBlock) beginBlock
           finishBlock:(ParserFinishBlock) finishBlock;

/**
 取消解析操作。
 @note 如果设置 block，会通知 block，code=kGifParserErrorCodeCancled
 */
- (void) cancleParser;

/**
 获取指定位置的gif帧
 @return 获取指定位置的gif帧，nil如果帧不存在或者index非法
 */
- (UIGifImageFrame *)cachedFrameAtIndex:(NSInteger)index;

@end

#pragma mark UIGifGenerater gif文件生成引擎
/*！
 Gif文件生成器
 */
@class UIGifImageFrame;
@interface UIGifGenerater : NSObject
/**
 根据制定的保存路径和图片信息创建Gif文件，并保存到相应磁盘位置
 @param framesArray gif帧的集合，里面存放的是UIGifImageFrame类型的结构
 @param saveFilePath 生成的gif需要保存的位置，不能为nil
 @param finishBlock 解析完成后的回调block
 
 @note block参数说明。filePath：gif保存的路径 error：如果发生错误，错误信息会通过error回传
 */
+ (void)generateGifFrames:(NSArray *)framesArray
                 filePath:(NSString *)saveFilePath
              finishBlock:(void (^)(NSString *, NSError *))finishBlock;
@end

#pragma mark UIGifImageFrame gif帧结构
@interface UIGifImageFrame : NSObject
/**
 init方法
 @param image 帧图片，不能为nil
 @param delayTime 帧持续时间，需要大于0的非负数。
 @return 返回初始化好的UIGifImageFrame，nil如果传入的数据不合法
 */
- (instancetype) initWithImageRef:(CGImageRef)imageRef frameDelayTime:(NSTimeInterval)delayTime;

/**
 update image
 */
- (void) updateImageRef:(CGImageRef) newImageRef;
/**
 当前帧对应的图片
 */
@property (nonatomic, readonly) CGImageRef imageRef;

/**
 当前帧播放delay时间
 */
@property (nonatomic, readonly) NSTimeInterval delayTime;

@end




/** 打印log的方法 */
void CategoryToolsLog(const char *functionName, int lineNumber,NSString *fmt, ...);







