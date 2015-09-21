//
//  PFPickerSheet.h
//  PaPaQi
//
//  Created by jianting on 13-12-4.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "PPQActionSheet.h"

typedef NS_OPTIONS(NSInteger, PFPickerOption) {
    PFPickerOptionGender,    // gender
    PFPickerOptionBirthday,  // birthday
    PFPickerOptionAddress,   // 地址
};
// block
typedef void (^PFPickerBlock) (PFPickerOption option, id data);

@interface PFPickerSheet : PPQActionSheet

/**
 show picker sheet
 */
+ (void) showPickerSheet:(PFPickerOption) option
             previewData:(id) data
             finishBlock:(PFPickerBlock) block;

@end

//选城市的key值
extern NSString *const cityKey;
extern NSString *const provinceKey;
