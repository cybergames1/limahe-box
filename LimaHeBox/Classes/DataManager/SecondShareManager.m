//
//  SecondShareManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/5.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "SecondShareManager.h"

#import <UIKit/UIKit.h>
#import <Category/Category.h>
#import "WeiXinManager.h"
#import "SDImageCache.h"
#import "PPQNetWorkURLs.h"
#import "WeiboSDK.h"
#import "CommonTools.h"
#import <TencentOpenAPI/QQApiInterface.h>

#define KWeixinDefaultDesc @"liemoch分享"

@interface SecondShareManager()
+ (SecondShareManager*) sharedShareManager;
@end

static SecondShareBlock defaultShareBlock = nil;
static NSDictionary* defaultVideoInfo = nil;

@implementation SecondShareManager
+ (SecondShareManager*) sharedShareManager
{
    static dispatch_once_t pred;
    static SecondShareManager *manager = nil;
    dispatch_once(&pred, ^{
        manager = [[SecondShareManager alloc] init];
    });
    return manager;
}


+ (void)shareVideo:(NSDictionary*) videoInfo
      platformType:(SharePlatformType) type
       finishBlock:(SecondShareBlock) block
{
    [defaultShareBlock release];
    defaultShareBlock = nil;
    if (block) {
        defaultShareBlock = [block copy];
    }
    [defaultVideoInfo release];
    defaultVideoInfo = [videoInfo copy];
//    if ([NSDictionary isEmptyDictionary:defaultVideoInfo]) {
//        [self _notifyShareFinish:@"视频信息为空！" error:[NSError errorWithDomain:@"PPQ" code:0 userInfo:@{NSLocalizedDescriptionKey:@"视频信息为空！"}]];
//        return;
//    }
//    NSDictionary *videoDic = [videoInfo objectForKey:@"video"];
//    
//    NSString *fileId = [videoDic objectForKey:@"fileid"];
//    if ([CommonTools isEmptyString:fileId]) {
//        [self _notifyShareFinish:@"视频信息缺少fileid！" error:[NSError errorWithDomain:@"PPQ" code:0 userInfo:@{NSLocalizedDescriptionKey:@"视频信息缺少fileid！"}]];
//        return;
//    }
//    NSURL *sharedUrl = [PPQNetWorkURLs sharedHtml5UrlWithFileId:fileId];
//    NSString *sharedUrlString = [PPQNetWorkURLs sharedHtml5UrlWithFileId:fileId].absoluteString;
//    NSString *videoTitle = [[defaultVideoInfo objectForKey:@"video"] objectForKey:@"tv_title"];
//    NSString *imgUrl = [CommonTools videoThumbPath:[videoDic objectForKey:@"img"] resolution:[videoDic objectForKey:@"resolution"]];
    
    NSString *videoTitle = @"分享";
    //UIImage *thumb = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
    UIImage *thumb = [UIImage imageNamed:@"main_bg"];
    NSString *sharedUrlString = @"http://www.liemoch.com";
    NSURL *sharedUrl = [NSURL URLWithString:sharedUrlString];
    
    switch (type) {
        case SharePlatformTypeWeibo:
        {
            WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
            authRequest.redirectURI = nil; // @"http://passport.iqiyi.com/sns/oauthcallback.php";
            authRequest.scope = @"all";
            
            WBMessageObject *message = [WBMessageObject message];
            WBWebpageObject *webpage = [WBWebpageObject object];
            webpage.objectID = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
            webpage.title = videoTitle;
            webpage.description = KWeixinDefaultDesc;
            webpage.thumbnailData = [self _imageDataCompress32KWithImage:thumb];
            webpage.webpageUrl = sharedUrlString;
            message.mediaObject = webpage;
            message.text = [videoInfo objectForKey:@"title"];
            
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
            [WeiboSDK sendRequest:request];
        }
            break;
        case SharePlatformTypeWeixin:
        {
            //微信好友
            [[WeiXinManager sharedInstance] shareVideoToWeixinFriendWithTitle:[videoInfo objectForKey:@"title"]
                                                                 desctription:KWeixinDefaultDesc
                                                                          url:sharedUrlString
                                                                   thumbImage:thumb];
        }
            break;
        case SharePlatformTypeWeixinZone:
        {
            //微信好友
            [[WeiXinManager sharedInstance] shareVideoToWeixinTimelineWithTitle:videoTitle
                                                                   desctription:KWeixinDefaultDesc
                                                                            url:sharedUrlString
                                                                     thumbImage:thumb];
        }
            break;
        case SharePlatformTypeQQZone:
        {
            //qq空间
            if (!([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi])) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请安装新版手机QQ " delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
            
            NSData *selectedImgData = [self _imageDataCompress32KWithImage:thumb];
            QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:sharedUrl
                                                                   title:videoTitle
                                                             description:KWeixinDefaultDesc
                                                        previewImageData:selectedImgData];
            
            [videoObj setFlashURL:sharedUrl];
            
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
            //将内容分享到qq
            [QQApiInterface SendReqToQZone:req];
        }
            break;
        case SharePlatformTypeCopy:
        {
//            if (fileId) {
//                [[UIPasteboard generalPasteboard] setString:sharedUrlString];
//            }
//            [self _notifyShareFinish:@"已经复制到剪切板" error:nil];
        }
            break;
        default:
            break;
    }
    
}


+ (void)_notifyShareFinish:(NSString*)tips error:(NSError*) error
{
    if (defaultShareBlock) {
        defaultShareBlock(tips,error);
    }
    [defaultShareBlock release];
    defaultShareBlock = nil;
}

+ (NSData *)_imageDataCompress32KWithImage:(UIImage *)original
{
    UIImage *image = [self _imageCompressWithImage:original];
    return UIImageJPEGRepresentation(image, 0.5);
}

+ (UIImage *)_imageCompressWithImage:(UIImage *)original
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

@end
