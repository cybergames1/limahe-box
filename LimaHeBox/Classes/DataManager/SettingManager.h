//
//  SettingManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/22.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kSinaWeiboSSO           @"sinaweibosso"
#define kSinaAppKey             @"848666639"
#define kSinaAppSecret          @"63ea68ca622e9296d13c95d2f76e977f"

#define kWeiboSDKSSO            @"wb848666639"

#define kWXSSO                  @"wx9f089ae5ee83f0d2"
#define KWXSecret               @"16cabc9b04980de7be5aecd79d9b647e"

@interface SettingManager : NSObject

+ (SettingManager *)sharedManager;

+ (BOOL)handleOpenURL:(NSURL *)openURL;

@end

@interface SettingManager (PrepareAppData)

+ (void) prepareApplication;

@end

@interface SettingManager (Bluetooth)

/** 铃声文件名 **/
@property (nonatomic,copy) NSString * bthWarningFileName;
/** 是否开启震动 **/
@property (nonatomic) BOOL openVibration;

@end
