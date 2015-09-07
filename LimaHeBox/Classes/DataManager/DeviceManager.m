//
//  DeviceManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "DeviceManager.h"

@implementation MDevice

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.deviceId = [dic objectForKey:@"toolsn"];
        
        NSDictionary *infoDic = [self dictionaryFromString:[dic objectForKey:@"tinfo"]];
        self.coordinate = CLLocationCoordinate2DMake([[infoDic objectForKey:@"n"] floatValue], [[infoDic objectForKey:@"s"] floatValue]);
        self.temperature = [[infoDic objectForKey:@"tm"] floatValue];
        self.wet = [[infoDic objectForKey:@"ph"] floatValue];
        
    }
    return self;
}

/**
 tinfo = "N=22.574780;S=113.873900;TM:194310;TR30.C;PH42.%,#";
 **/
- (NSDictionary *)dictionaryFromString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@";"];
    NSString *n = [array[0] substringFromIndex:2];
    NSString *s = [array[1] substringFromIndex:2];
    NSString *tm = [array[3] substringFromIndex:2];
    tm = [tm substringToIndex:[tm length]-1];
    NSString *ph = [array[4] substringFromIndex:2];
    ph = [ph substringToIndex:[ph length]-3];
    
    return  @{@"n":n,
              @"s":s,
              @"tm":tm,
              @"ph":ph};
}

@end

@implementation DeviceManager

+ (DeviceManager *)sharedManager
{
    static DeviceManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DeviceManager alloc] init];
    });
    return instance;
}

@end
