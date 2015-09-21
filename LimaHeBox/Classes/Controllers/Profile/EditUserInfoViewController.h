//
//  EditUserInfoViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

/**
 * 编辑个人信息
 */

typedef NS_OPTIONS(NSInteger, ProfileEditOption) {
    ProfileEditOptionAge,          //年龄
    ProfileEditOptionAddress,      //常用地址
    ProfileEditOptionDeviceId,     //设备号
};

@interface EditUserInfoViewController : BoxSuperViewController

- (instancetype) initWithOption:(ProfileEditOption) option
                    profileInfo:(NSString*) userInfo;

@end
