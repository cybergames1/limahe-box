//
//  WeiXinManager.m
//  Papaqi
//
//  Created by jianting on 15/8/7.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import "WeiXinManager.h"
#import "WXApiObject.h"
#import "CommonTools.h"
#import <Category/Category.h>

#define KAlertTitle @"提示"

@implementation WeiXinManager

- (id) init
{
    self = [super init];
    if (self)
    {
        self.responseDelegate = nil;
        return self;
    }
    return nil;
}

- (void) dealloc
{
    self.responseDelegate = nil;
    [super dealloc];
}

+ (WeiXinManager *) sharedInstance
{
    static dispatch_once_t pred;
    static WeiXinManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[WeiXinManager alloc] init];
    });
    return manager;
}

+ (BOOL) openWxApp
{
    return [WXApi openWXApp];
}

+ (BOOL) isWeixinInstalled
{
    return [WXApi isWXAppInstalled];
}

#pragma mark WxAPIDelegate
#pragma mark ---

- (void) onReq:(BaseReq*)req
{
    //微信终端向我们请求数据
    if ([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        
    }
}

- (void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[BaseResp class]])
    {
        if(resp.errCode == 0)
        {
            if (_responseDelegate)
            {
                [self notifySuccuessRsp:resp];
                self.responseDelegate = nil;
                return;
            }
        }
        else
        {
            if (_responseDelegate)
            {
                [self notifyErrorRsp:resp];
                self.responseDelegate = nil;
                return;
            }
        }
    }
}

#pragma mark Public Method
#pragma mark ---

- (void) weixinLogin
{
    if (![WXApi isWXAppInstalled])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAlertTitle
                                                            message:@"请先安装微信"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    SendAuthReq* req =[[[SendAuthReq alloc ] init ] autorelease];
    req.scope = @"snsapi_userinfo" ;
    [WXApi sendReq:req];
}
- (void) shareVideoToWeixinFriendWithTitle:(NSString *)title
                              desctription:(NSString *)desctription
                                       url:(NSString *)url
                                thumbImage:(UIImage *)thumb
{
    
    if (![WXApi isWXAppInstalled])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAlertTitle
                                                            message:@"请先安装微信"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ([CommonTools isEmptyString:title])
    {
        title = @"我的视频";
    }
    [self shareVideoToWeixinWithTitle:title
                         desctription:desctription
                                  url:url
                           thumbImage:thumb
                                scene:WXSceneSession];
}

- (void) shareVideoToWeixinTimelineWithTitle:(NSString *)title
                                desctription:(NSString *)desctription
                                         url:(NSString *)url
                                  thumbImage:(UIImage *)thumb
{
    if (![WXApi isWXAppInstalled])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAlertTitle
                                                            message:@"请先安装微信"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
        return;
    }
    
    if ([CommonTools isEmptyString:title])
    {
        title = @"我的视频";
    }
    
    [self shareVideoToWeixinWithTitle:title
                         desctription:desctription
                                  url:url
                           thumbImage:thumb
                                scene:WXSceneTimeline];
}

- (void) shareVideoRespToWeixinWithTitle:(NSString *)title
                            desctription:(NSString *)desctription
                                     url:(NSString *)url
                          thumbImagePath:(NSString *)path
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desctription;
    message.thumbData = [self imageCompressWithData:path];
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = url;
    message.mediaObject = ext;
    
    GetMessageFromWXResp *resp = [[[GetMessageFromWXResp alloc] init] autorelease];
    resp.bText = NO;
    resp.message = message;
    
    if (![WXApi sendResp:resp])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAlertTitle
                                                            message:@"分享微信失败"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark Private Method
#pragma mark ---


- (void) shareVideoToWeixinWithTitle:(NSString *)title
                        desctription:(NSString *)desctription
                                 url:(NSString *)url
                          thumbImage:(UIImage *)thumb
                               scene:(NSInteger)scene
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desctription;
    
    if (!thumb) {
        thumb = [UIImage imageNamed:@"icon152"];
    }
    if (scene == WXSceneSession) {
        UIImage *thumbLikeVideo = [WeiXinManager thumbImageWithPlayIcon:thumb];
        [message setThumbImage:[self imageCompressWithImage:thumbLikeVideo]];
    } else {
        [message setThumbImage:[self imageCompressFitWithImage:thumb]];
    }
    
    if (scene == WXSceneTimeline) {
        WXVideoObject *ext = [WXVideoObject object];
        ext.videoUrl = url;
        message.mediaObject = ext;
    } else if (scene == WXSceneSession) {
        WXImageObject *img = [WXImageObject object];
        img.imageUrl = url;
        message.mediaObject = img;
    }
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    if (![WXApi sendReq:req])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KAlertTitle
                                                            message:@"分享微信失败"
                                                           delegate:nil
                                                  cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
}

- (NSData *) imageCompressWithData:(NSString *)path
{
    NSData *sourceData = [NSData dataWithContentsOfFile:path];
    NSUInteger dataLen = [sourceData length];
    long long maxSize = 32 * 1024;
    
    if (dataLen > maxSize)
    {
        CGFloat ratio = maxSize / dataLen * 0.95;
        UIImage *image = [UIImage imageWithData:sourceData];
        UIImage *scaledImage = nil;
        {
            CGSize newSize = CGSizeMake(114, 114);
            UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
            
            [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        return UIImageJPEGRepresentation(scaledImage, ratio);
    }
    return sourceData;
}

- (UIImage *) imageCompressFitWithImage:(UIImage *)original
{
    if (original == nil)
    {
        original = [CommonTools imageNamed:@"icon58"];
    }
    
    CGSize imageSize = original.size;
    NSUInteger dataLen = imageSize.width * imageSize.height;
    long long maxSize = 31 * 1024;
    
    if (dataLen > maxSize){
        CGSize newSize = CGSizeMake(157, 157);
        UIImage *scaledImage =[CommonTools createResizeImage:original aspectFitSize:newSize];
        return [UIImage imageWithData:UIImageJPEGRepresentation(scaledImage, 0.5)];
    }
    return original;
}

- (UIImage *)imageCompressWithImage:(UIImage *)original
{
    if (original == nil)
    {
        original = [CommonTools imageNamed:@"icon58"];
    }
    CGSize imageSize = original.size;
    NSUInteger dataLen = imageSize.width * imageSize.height;
    long long maxSize = 31 * 1024;
    
    if (dataLen > maxSize){
        CGSize newSize = CGSizeMake(157, 157);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);

        [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return[UIImage imageWithData:UIImageJPEGRepresentation(scaledImage, 0.5)];
    }
    return original;
}

- (NSData *) imageDataAsSceneThumbImage:(id)thumb
{
    //UIImage *image = [VideoTools thumbImageWithPlayIcon:thumb];
    //return UIImageJPEGRepresentation(image, 0.8f);
    return nil;
}


#pragma mark -处理视频封面（带有播放按钮）
+ (UIImage *)thumbImageWithPlayIcon:(UIImage *)thumb
{
    CGFloat min = MIN(thumb.size.height, thumb.size.width);
    CGRect rect = CGRectMake(0, 0, min, min);
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:rect] autorelease];
    imageView.image = thumb;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImageView *playIcon = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"videoPlayer_play"]] autorelease];
    if (playIcon.size.width > min/2) {
        playIcon.frame = CGRectMake(0, 0, min/2, min/2);
    }
    [imageView addSubview:playIcon];
    playIcon.center = imageView.center;
    
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 0.0);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void) notifySuccuessRsp:(BaseResp *)resp
{
    if ([self.responseDelegate respondsToSelector:@selector(weixinShareFinishSuccessWithRsp:)])
    {
        [self.responseDelegate weixinShareFinishSuccessWithRsp:resp];
    }
}

- (void) notifyErrorRsp:(BaseResp *)resp
{
    if ([self.responseDelegate respondsToSelector:@selector(weixinShareFInishErrorWithRsp:)])
    {
        [self.responseDelegate weixinShareFInishErrorWithRsp:resp];
    }
}

@end
