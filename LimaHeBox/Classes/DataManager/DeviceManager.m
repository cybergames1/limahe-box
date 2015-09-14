//
//  DeviceManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "DeviceManager.h"
#import "DeviceDataSource.h"

NSString* const UserInfoWeightKey = @"userInfo_weightkey";
NSString* const UpdateUserInfoNotification = @"UpdateUserInfoNotification";

@implementation MDevice

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.deviceId = [dic objectForKey:@"toolsn"];
        
        NSDictionary *infoDic = [self dictionaryFromString:[dic objectForKey:@"tinfo"]];
        self.coordinate = CLLocationCoordinate2DMake([[infoDic objectForKey:@"s"] floatValue],[[infoDic objectForKey:@"n"] floatValue]);
        self.temperature = [[infoDic objectForKey:@"tm"] floatValue];
        self.wet = [[infoDic objectForKey:@"ph"] floatValue];
        self.weight = 0.0;
    }
    return self;
}

- (void)updateValue:(id)value forKey:(NSString *)key {
    if (value) {
        if ([key isEqualToString:UserInfoWeightKey]) {
            self.weight = [value floatValue];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:UpdateUserInfoNotification object:self];
    });
}

/**
 data =     {
 dateline = "2015-09-11 ";
 id = 1;
 status = 1;
 tinfo = 12kg;
 toolsn = 867144029586110;
 };
 **/
- (void)updateWeightWithDictionary:(NSDictionary *)dic {
    NSString *tinfo = [dic objectForKey:@"tinfo"];
    NSString *w = [tinfo substringFromIndex:[tinfo length]-2];
    if ([w isEqualToString:@"kg"]) {
        tinfo = [tinfo substringToIndex:[tinfo length]-2];
        tinfo = [NSString stringWithFormat:@"%f",[tinfo floatValue]*1000.0];
    }else {
        tinfo = [tinfo substringToIndex:[tinfo length]-1];
    }
    
    [self updateValue:tinfo forKey:UserInfoWeightKey];
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

@interface DeviceManager () <PPQDataSourceDelegate>
{
    void(^success_)();
    void(^failure_)(NSError *);
}

@property (nonatomic, retain) PPQDataSource * dataSource;
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

- (void)startGetDeviceInfo:(void(^)())success failure:(void(^)(NSError*))failure {
    if (success) success_ = [success copy];
    if (failure) failure_ = [failure copy];
    
    if (self.dataSource) {
        [_dataSource cancelAllRequest];
        [_dataSource setDelegate:nil];
        self.dataSource = nil;
    }
    
    DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource getDeviceInfo:@"867144029586110"];
    self.dataSource = dataSource;
}

#pragma mark -
#pragma mark DataSource Delegate

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    if (source.networkType == EPPQNetGetDeviceInfo) {
        [[DeviceManager sharedManager] setCurrentDevice:[[[MDevice alloc] initWithDictionary:[source.data objectForKey:@"data"]] autorelease]];
        
        DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
        [dataSource startWeight:@"867144029586110"];
        self.dataSource = dataSource;
        
        if (success_) {
            success_();
            [success_ release];
            success_ = nil;
        }
    }else if (source.networkType == EPPQNetStartWeight) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
            [dataSource getWeight:@"867144029586110"];
            self.dataSource = dataSource;
        });
    }else if (source.networkType == EPPQNetGetWeight) {
        [[[DeviceManager sharedManager] currentDevice] updateWeightWithDictionary:[source.data objectForKey:@"data"]];
    }
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    if (failure_) {
        failure_(error);
        [failure_ release];
        failure_ = nil;
    }
}

@end
