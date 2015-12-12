//
//  DeviceManager.m
//  LimaHeBox
//
//  Created by jianting on 15/9/7.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "DeviceManager.h"
#import "DeviceDataSource.h"
#import "AccountManager.h"
#import "CommonTools.h"

NSString* const DeviceInfoIsOnlineKey = @"deviceInfo_IsOnlineKey";
NSString* const DeviceInfoWeightKey = @"deviceInfo_weightkey";
NSString* const UpdateDeviceInfoNotification = @"UpdateDeviceInfoNotification";

@implementation MDevice

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.deviceId = [dic objectForKey:@"toolsn"];
        
        NSDictionary *infoDic = [self dictionaryFromString:[dic objectForKey:@"tinfo"]];
        if (infoDic) {
            self.isOnline = [[infoDic objectForKey:@"isonline"] boolValue];
            self.coordinate = CLLocationCoordinate2DMake([[infoDic objectForKey:@"s"] floatValue],[[infoDic objectForKey:@"n"] floatValue]);
            self.temperature = [[infoDic objectForKey:@"tm"] floatValue];
            self.wet = [[infoDic objectForKey:@"ph"] floatValue];
            self.weight = 0.0;
        }
    }
    return self;
}

- (void)updateValue:(id)value forKey:(NSString *)key {
    if (value) {
        if ([key isEqualToString:DeviceInfoWeightKey]) {
            self.weight = [value floatValue];
        }else if ([key isEqualToString:DeviceInfoIsOnlineKey]) {
            self.isOnline = [value boolValue];
        }else {
            //
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:UpdateDeviceInfoNotification object:self];
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
    
    [self updateValue:tinfo forKey:DeviceInfoWeightKey];
    [self updateValue:[dic objectForKey:@"isonline"] forKey:DeviceInfoIsOnlineKey];
}

/**
 tinfo = "GPS:113.881248,22.571365;TR30C,PH36%;";
 **/
- (NSDictionary *)dictionaryFromString:(NSString *)string {
    if ([CommonTools isEmptyString:string]) return nil;
    
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
    
    BOOL _isStartWeight;
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

- (void)startGetDeviceInfo:(void(^)(NSError *))start success:(void (^)())success failure:(void(^)(NSError*))failure {
    if (![AccountManager isLogin]) {
        if (start) {
            start ([NSError errorWithDomain:@"ErrorDomain" code:101 userInfo:@{NSLocalizedDescriptionKey:@"您还没有登录"}]);
        }
        return;
    }
    
    NSString *deviceId = [[[AccountManager sharedManager] loginUser] userDeviceId];
    if ([CommonTools isEmptyString:deviceId]) {
        if (start) {
            start ([NSError errorWithDomain:@"ErrorDomain" code:102 userInfo:@{NSLocalizedDescriptionKey:@"您还未绑定设备"}]);
        }
        return;
    };
    
    if (start) {
        start (nil);
    }
    
    if (success) success_ = [success copy];
    else return;
    
    if (failure) failure_ = [failure copy];
    
    if (self.dataSource) {
        [_dataSource cancelAllRequest];
        [_dataSource setDelegate:nil];
        self.dataSource = nil;
    }
    
    _isStartWeight = NO;
    
    DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource getDeviceInfo:deviceId];
    self.dataSource = dataSource;
}

- (void)uploadDeviceToken:(NSString *)deviceToken {
    _isStartWeight = NO;
    
    DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource uploadDeviceToken:deviceToken];
    self.dataSource = dataSource;
}

@end


@implementation DeviceManager (Weight)

- (void)setWeightStep:(WeightStep)step
                start:(void(^)(NSError *))start
              success:(void (^)())success
              failure:(void (^)(NSError *))failure
{
    if (![AccountManager isLogin]) {
        if (start) {
            start ([NSError errorWithDomain:@"ErrorDomain" code:101 userInfo:@{NSLocalizedDescriptionKey:@"您还没有登录"}]);
        }
        return;
    }
    
    NSString *deviceId = [[[AccountManager sharedManager] loginUser] userDeviceId];
    if ([CommonTools isEmptyString:deviceId]) {
        if (start) {
            start ([NSError errorWithDomain:@"ErrorDomain" code:102 userInfo:@{NSLocalizedDescriptionKey:@"您还未绑定设备"}]);
        }
        return;
    };
    
    if (start) {
        start (nil);
    }
    
    if (success) success_ = [success copy];
    if (failure) failure_ = [failure copy];
    
    if (self.dataSource) {
        [_dataSource cancelAllRequest];
        [_dataSource setDelegate:nil];
        self.dataSource = nil;
    }
    
    _isStartWeight = YES;
    
    [self getDataSourceForStep:step];
}

- (void)getDataSourceForStep:(WeightStep)step {
    NSString *deviceId = [[[AccountManager sharedManager] loginUser] userDeviceId];
    
    DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
    self.dataSource = dataSource;
    
    switch (step) {
        case WeightStepStartModle:
            [dataSource getDeviceInfo:deviceId];
            break;
        case WeightStepStartWeight:
            [dataSource startWeight:deviceId];
            break;
        case WeightStepSendInstruction:
            [dataSource sendInstruction:deviceId];
            break;
        case WeightStepGETWeight:
            [dataSource getWeight:deviceId];
            break;
        case WeightStepStopModle:
            [dataSource stopWeight:deviceId];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark DataSource Delegate

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    /**
     1,获取设备信息
     2,开启称重模式
     3,发送称重指令
     4,获取称重数据
     5,停止称重模式
     **/
    if (source.networkType == EPPQNetGetDeviceInfo) {
        [[DeviceManager sharedManager] setCurrentDevice:[[[MDevice alloc] initWithDictionary:[source.data objectForKey:@"data"]] autorelease]];
        
        //如果只是单纯获取设备信息，则直接结束
        if (!_isStartWeight) {
            [self doSuccess];
        }else {
            [self getDataSourceForStep:WeightStepStartWeight];
        }
    }else if (source.networkType == EPPQNetSendInstruction) {
        //发送称重指令后6秒获取称重数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self getDataSourceForStep:WeightStepGETWeight];
        });
    }else if (source.networkType == EPPQNetGetWeight) {
        [[[DeviceManager sharedManager] currentDevice] updateWeightWithDictionary:[source.data objectForKey:@"data"]];
        [self doSuccess];
    }else {
        [self doSuccess];
    }
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [self doFailure:error];
}

- (void)doSuccess {
    if (success_) {
        success_();
        [success_ release];
        success_ = nil;
    }
}

- (void)doFailure:(NSError *)error {
    if (failure_) {
        failure_(error);
        [failure_ release];
        failure_ = nil;
    }
}

@end
