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
 tinfo = "GPS:113.881248,22.571365;TR30C,PH36%;";
 **/
- (NSDictionary *)dictionaryFromString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@";"];
    //gps
    NSArray *gps = [array[0] componentsSeparatedByString:@","];
    NSString *n = [gps[0] substringFromIndex:4];
    NSString *s = gps[1];
    
    //温湿度
    NSArray *tp = [array[1] componentsSeparatedByString:@","];
    NSString *tm = [tp[0] substringFromIndex:2];
    tm = [tm substringToIndex:[tm length]-1];
    NSString *ph = [tp[1] substringFromIndex:2];
    ph = [ph substringToIndex:[ph length]-1];
    
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
