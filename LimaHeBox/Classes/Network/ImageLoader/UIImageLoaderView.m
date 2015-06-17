//
//  UIImageLoaderView.m
//  QiYiShare
//
//  Created by fangyuxi on 12-12-13.
//  Copyright (c) 2012年 iQiYi. All rights reserved.
//

#import "UIImageLoaderView.h"
#import "CommonTools.h"

@implementation UIImageLoaderView

#pragma mark Init & Dealloc
#pragma mark --- 

- (void) dealloc
{
    [self cancelLoad];
    self.urlString = nil;
    self.delegate = nil;
    self.placeHoderImage = nil;
    self.userInfo = nil;
    _actionDelegate = nil;
    [self removeGestureRecognizer:_gestureRecognizer];
    [_gestureRecognizer removeTarget:self action:@selector(tapViewAction:)];
    [_gestureRecognizer release],_gestureRecognizer = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.urlString = nil;
        self.delegate = nil;
        _actionDelegate = nil;
        self.options = SDWebImageLowPriority;
    }
    return self;
}

- (id) initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self)
    {
        self.urlString = nil;
        self.delegate = nil;
        _actionDelegate = nil;
        _options = SDWebImageLowPriority;
        return self;
    }
    return nil;
}

- (id) initWithURLString:(NSString *)urlString
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.delegate = nil;
        _actionDelegate = nil;
        self.urlString = urlString;
        self.options = SDWebImageLowPriority;
        return self;
    }
    return nil;
}

#pragma mark Init & Dealloc
#pragma mark ---

- (void) startLoad
{
    [self cancelLoad];
    
    if ([CommonTools isEmptyString:self.urlString])
    {
        return;
    }
    if ([self.urlString hasPrefix:@"http"])
    {
        [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.urlString] delegate:self options:self.options];
    }
    else
    {
        UIImage *img = [UIImage imageWithContentsOfFile:self.urlString];
        if (img == nil)
        {
            self.image = self.placeHoderImage;
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(imageLoaderDidFinishLoad:)])
            {
                [self.delegate imageLoaderDidFinishLoad:self];
            }
            
            self.image = img;
        }
    }
}

- (void) cancelLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void) setUrlString:(NSString *)urlString
{
    [_urlString release];
    _urlString = [urlString retain];
    if ([CommonTools isEmptyString:_urlString])
    {
        self.image = _placeHoderImage;
    }
}

#pragma mark- set
- (void) setActionDelegate:(id<UIImageActionDelegate>)actionDelegate
{
    if (actionDelegate != nil) {
        self.userInteractionEnabled = YES;
        _actionDelegate = actionDelegate;
        if (_gestureRecognizer == nil) {
            _gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:)];
            [self addGestureRecognizer:_gestureRecognizer];
        }
    }
    else{
        self.userInteractionEnabled = NO;
        [_gestureRecognizer removeTarget:self action:@selector(tapViewAction:)];
        [self removeGestureRecognizer:_gestureRecognizer];
        [_gestureRecognizer release],_gestureRecognizer = nil;
    }
}

- (void)setPlaceHoderImage:(UIImage *)placeHoderImage
{
    [_placeHoderImage release];
    _placeHoderImage = [placeHoderImage retain];
    self.image = _placeHoderImage;
}
#pragma mark- action
- (void) tapViewAction:(UIGestureRecognizer*) gestureRecognizer
{
    if (self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(imageActionDidTouch:)]) {
        [self.actionDelegate performSelector:@selector(imageActionDidTouch:) withObject:self];
    }
}

#pragma mark ---
#pragma mark WebImageManagerDelegate

- (void)webImageManager:(SDWebImageManager *)imageManager didProgressWithPartialImage:(UIImage *)image forURL:(NSURL *)url
{
    self.image = image;
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageLoaderDidFinishLoad:)])
    {
        [self.delegate imageLoaderDidFinishLoad:self];
    }
    if (image.size.width == 0 || image.size.height == 0)
    {
        self.image = self.placeHoderImage;
        return;
    }
    
    self.image = image;
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error forURL:(NSURL *)url userInfo:(NSDictionary *)info
{
    self.image = self.placeHoderImage;
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageLoader:hasError:)])
    {
        [self.delegate imageLoader:self hasError:error];
    }
}

@end
