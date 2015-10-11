//
//  EditProfileManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "EditProfileManager.h"
#import "LRDataSource.h"

@interface EditProfileManager () <PPQDataSourceDelegate>

+ (EditProfileManager *)sharedManager;

@end

static UploadProfileBlock uploadFinishBlock = nil;
static LRDataSource * _dataSource = nil;

@implementation EditProfileManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [[LRDataSource alloc] initWithDelegate:self];
    }
    return self;
}
+ (EditProfileManager *)sharedManager
{
    static dispatch_once_t pred;
    static EditProfileManager *manager = nil;
    
    dispatch_once(&pred, ^{
        manager = [[EditProfileManager alloc] init];
    });
    return manager;
}

- (void) uploadgender:(NSString*) gender
                  age:(NSString*) age
                 city:(NSString*) city
              address:(NSString*) address
             deviceId:(NSString *) deviceId
{
    [self uploadgender:gender age:age city:city address:address deviceId:deviceId phone:nil authCode:nil];
}

- (void) uploadgender:(NSString*) gender
                  age:(NSString*) age
                 city:(NSString*) city
              address:(NSString*) address
             deviceId:(NSString *) deviceId
                phone:(NSString *) phone
             authCode:(NSString *) authCode
{
    _dataSource.delegate = self;
    [_dataSource updateInfoWithGender:gender age:age address:address city:city deviceId:deviceId phone:phone authCode:authCode];
}

#pragma mark - class

+ (void) uploadUserGender:(NSString*) gender
                    block:(UploadProfileBlock) block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:gender age:nil city:nil address:nil deviceId:nil];
}
+ (void) uploadUserAge:(NSString*) age
                      block:(UploadProfileBlock) block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:nil age:age city:nil address:nil deviceId:nil];
}
+ (void) uploadUserCity:(NSString*) city
                      block:(UploadProfileBlock) block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:nil age:nil city:city address:nil deviceId:nil];
}

+ (void) uploadUserAddress:(NSString*) address
                          block:(UploadProfileBlock) block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:nil age:nil city:nil address:address deviceId:nil];
}

+ (void) uploadUserDevice:(NSString *)device block:(UploadProfileBlock)block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:nil age:nil city:nil address:nil deviceId:device];
}

+ (void) uploadUserPhone:(NSString *)phone authcode:(NSString *)authCode block:(UploadProfileBlock)block
{
    if (block) {
        [uploadFinishBlock release];
        uploadFinishBlock = [block copy];
    }
    EditProfileManager* manager = [EditProfileManager sharedManager];
    [manager uploadgender:nil age:nil city:nil address:nil deviceId:nil phone:phone authCode:authCode];
}

#pragma mark - dataSource delegate
- (void)dataSourceFinishLoad:(PPQDataSource *)source
{
    if (uploadFinishBlock) {
        uploadFinishBlock(nil,nil);
    }
    _dataSource.delegate = nil;
    [uploadFinishBlock release]; uploadFinishBlock = nil;
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error
{
    if (uploadFinishBlock){
        uploadFinishBlock(error,nil);
    }
    _dataSource.delegate = nil;
    [uploadFinishBlock release]; uploadFinishBlock = nil;
}

@end
