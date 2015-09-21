//
//  BoxStorageModel.h
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "JSONModel.h"

@interface BoxStorageModel : JSONModel

/** 由storage直接初始化对应的Model,如果无存储则返回一个初始化Model **/
+ (instancetype)storageModel;

/** 获取存储路径 **/
+ (NSString *)storagePath;

/** 删除存储文件 **/
- (void)deleteStorage;

/** 主动存储Model数据至文件 **/
- (BOOL)saveStorage;

@end
