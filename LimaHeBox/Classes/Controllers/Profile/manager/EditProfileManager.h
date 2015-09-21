//
//  EditProfileManager.h
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UploadProfileBlock) (NSError* error, id info);

@interface EditProfileManager : NSObject

//上传性别
+ (void) uploadUserGender:(NSString*) gender
                    block:(UploadProfileBlock) block;
//上传年龄
+ (void) uploadUserAge:(NSString*) age
                 block:(UploadProfileBlock) block;
//上传城市
+ (void) uploadUserCity:(NSString*) city
                  block:(UploadProfileBlock) block;

//上传居住地
+ (void) uploadUserAddress:(NSString*) address
                     block:(UploadProfileBlock) block;

//上传设备号
+ (void) uploadUserDevice:(NSString *) device
                    block:(UploadProfileBlock) block;

@end
