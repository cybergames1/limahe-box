//
//  UIImageLoaderView.m
//  Papaqi
//
//  Created by Sean on 15/7/30.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import "UIImageLoaderView.h"
#import "SDWebImageCompat.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "CommonTools.h"

@interface UIImageLoaderView ()
<SDWebImageManagerDelegate>
{
    NSString                       *_urlString;
    id<UIImageLoaderViewDelegate>   _delegate;
    id<UIImageActionDelegate>       _actionDelegate;
    
    UIControl   *_tapControl;
}
@end


@implementation UIImageLoaderView
- (void)dealloc
{
    [self cancelLoad];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_urlString release];
    [_placeHoderImageURLString release];
    [_placeHoderImage release];
    _delegate = nil;
    _actionDelegate = nil;
    [_tapControl release];
    self.userInfo = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.options = SDWebImageRetryFailed|SDWebImageContinueInBackground;
    }
    return self;
}

- (void)taped:(id)sender
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(_performTapAction) withObject:nil afterDelay:0.2];
}

- (void)_performTapAction
{
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(imageActionDidTouch:)]) {
        [self.actionDelegate imageActionDidTouch:self];
    }
}

#pragma mark - start / cancle
- (void) startLoad
{
    [self _startLoadImageWithURL:self.urlString];
}

- (void) _startLoadImageWithURL:(NSString*) urlString
{
    [self cancelLoad];
    if (_placeHoderImage) {
        //如果有 placeHolder，首先把 placeHoldre 显示出来
        self.image = _placeHoderImage;
    }
    if ([CommonTools isEmptyString:urlString]) {
        return;
    }
    if ([self.urlString hasPrefix:@"http"]) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlString]
                                                        options:self.options
                                                       progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                           if (image) {
                                                               if (image.size.width <= 0 || image.size.height <= 0) {
                                                                   [self _updateImageWhenFail:self.placeHoderImage url:[imageURL absoluteString] error:nil];
                                                               }
                                                               else{
                                                                   [self _updateImageWhenFinish:image needNoti:YES];
                                                               }
                                                           }
                                                           else {
                                                               [self _updateImageWhenFail:self.placeHoderImage url:[imageURL absoluteString] error:error];
                                                           }
                                                       }];
    }
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img = [UIImage imageWithContentsOfFile:self.urlString];
            if (img == nil) {
                [self _updateImageWhenFinish:self.placeHoderImage needNoti:NO];
            }
            else {
                [self _updateImageWhenFinish:img needNoti:YES];
            }
        });
    }
}

- (void) cancelLoad
{ }

#pragma mark - SET
- (void) setUrlString:(NSString *)urlString
{
    [_urlString release];
    _urlString = [urlString retain];
}

- (void)setPlaceHoderImage:(UIImage *)placeHoderImage
{
    if (nil == placeHoderImage && nil == _placeHoderImage) {
        //从未设置过 placeHolder，后面代码也没有执行的必要了
        return;
    }
    [_placeHoderImage release];
    _placeHoderImage = [placeHoderImage retain];
    [self _updateImageWhenFinish:_placeHoderImage needNoti:NO];
}

#pragma mark ---
#pragma mark WebImageManagerDelegate
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    if (image.size.width <= 0 || image.size.height <= 0) {
        [self _updateImageWhenFail:self.placeHoderImage url:self.placeHoderImageURLString error:nil];
    }
    else{
        [self _updateImageWhenFinish:image needNoti:YES];
    }
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error forURL:(NSURL *)url userInfo:(NSDictionary *)info
{
    [self _updateImageWhenFail:self.placeHoderImage url:[url absoluteString] error:error];
}

#pragma mark - update image when finish
- (void) _updateImageWhenFinish:(UIImage*) img needNoti:(BOOL) noti
{
    if (img == self.image) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = img;
        if (noti) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(imageLoaderDidFinishLoad:)]) {
                [self.delegate imageLoaderDidFinishLoad:self];
            }
        }
    });
}

- (void) _updateImageWhenFail:(UIImage*) img url:(NSString*) url error:(NSError*) error
{
    if (self.placeHoderImageURLString && NO == [self.placeHoderImageURLString isEqualToString:url]) {
        [self _startLoadImageWithURL:self.placeHoderImageURLString];
        return;
    }
    if (img == self.image) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = img;
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageLoader:hasError:)]) {
            [self.delegate imageLoader:self hasError:error];
        }
    });
}

@end

@implementation UIImageLoaderView (ImageViewAction)
- (void)setActionDelegate:(id<UIImageActionDelegate>)actionDelegate
{
    _actionDelegate = actionDelegate;
    if (_actionDelegate) {
        self.userInteractionEnabled = YES;
        if (nil == _tapControl) {
            _tapControl = [[UIControl alloc] initWithFrame:self.bounds];
            _tapControl.exclusiveTouch = YES;
            _tapControl.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin  | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
            [_tapControl addTarget:self action:@selector(taped:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_tapControl];
        }
    }
    else{
        [_tapControl removeFromSuperview];
        [_tapControl release];
        _tapControl = nil;
        self.userInteractionEnabled = NO;
    }
}

- (id<UIImageActionDelegate>)actionDelegate {return _actionDelegate;}

@end


