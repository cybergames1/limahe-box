//
//  BoxStorageModel.m
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "BoxStorageModel.h"
#import "CommonTools.h"

@interface BoxStorageModel()
@end

@implementation BoxStorageModel

- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (instancetype)storageModel
{
    NSString *jsonPath = [[self class] storagePath];
    if (![CommonTools isEmptyString:jsonPath]) {
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        if (jsonData) {
            NSError *error = nil;
            id objModel = [[[[self class] alloc] initWithData:jsonData error:&error] autorelease];
            if (objModel && error == nil) {
                return objModel;
            }
        }
    }
    return [[[[self class] alloc] init] autorelease];
    
}

+ (NSString *)storagePath
{
    NSString *class_name = NSStringFromClass([self class]);
    return [[CommonTools pathForStorageClass] stringByAppendingPathComponent:class_name];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (void)deleteStorage
{
    [CommonTools removePathAt:[[self class] storagePath]];
}

- (BOOL)saveStorage
{
    NSData *data = [self toJSONData];
    NSString *savePath = [[self class] storagePath];
    BOOL suc = [data writeToFile:savePath atomically:YES];
    return suc;
}


@end
