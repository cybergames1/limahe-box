//
//  WeatherAPI.m
//  LimaHeBox
//
//  Created by jianting on 15/6/18.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeatherAPI.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSString+base64.h"
#import "WeatherSource.h"

#define Weather_APPID       @"8d22e6e51fef0147"
#define Weather_PrivateKey  @"0331bc_SmartWeatherAPI_cecbe12"

NSString *const WeahterPropertyDayWeather = @"DayWeather";
NSString *const WeatherPropertyNightWeather = @"NightWeather";
NSString *const WeatherPropertyDayTemperature = @"DayTemperature";
NSString *const WeatherPropertyNightTemperature = @"NightTemperature";
NSString *const WeatherPropertyDayWindDirection = @"DayWindDirection";
NSString *const WeatherPropertyNightWindDirection = @"NightWindDirection";
NSString *const WeatherPropertyDayWindForce = @"DayWindForce";
NSString *const WeatherPropertyNightWindForce = @"NightWindForce";

typedef void(^Complation)(BOOL finished);

@interface WeatherAPI () <PPQDataSourceDelegate>
{
    NSString * _type;
    NSString * _dateString;
    NSString * _api;
    NSString * _key;
    
    WeatherSource * _source;
    Complation _complation;
}

@end

@implementation WeatherAPI

- (void)dealloc {
    [_type release];_type = nil;
    [_dateString release];_dateString = nil;
    [_api release];_api = nil;
    [_key release];_key = nil;
    if (_source) {
        _source.delegate = nil;
        [_source release];_source = nil;
    }
    [_weatherInfo release];_weatherInfo = nil;
    if (_complation) {
        [_complation release];_complation = nil;
    }
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _weatherInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        /**
         * 官方文档更新的数据类型号
         * 指数:index_f(基础接口),index_v(常规接口)
         * 3天预报:forecast_f(基础接口),forecast_v(常规接口)
         */
        _type = [[NSString alloc] initWithString:@"forecast_f"];
        
        NSDate *date_ = [NSDate date];
        NSDateFormatter *dateFormatter_ = [[NSDateFormatter alloc] init];
        [dateFormatter_ setDateFormat:@"yyyyMMddHHmmss"];
        
        //精确到分
        _dateString = [[[dateFormatter_ stringFromDate:date_] substringToIndex:12] retain];
        
    }
    return self;
}

- (NSString *)apiURLString:(NSString *)areaId {
    NSString *publickey_ = [self getPublicKey:areaId type:_type date:_dateString appid:Weather_APPID];
    NSString *key_ = [self hmacSha1:publickey_ privatekey:Weather_PrivateKey];
    key_ = [self stringByEncodingURLFormat:key_];
    
    [_key release];
    _key = [key_ retain];
    
    [_api release];
    NSString *weatherAPI_ = [[self getAPI:areaId type:_type date:_dateString appid:Weather_APPID key:_key] retain];
    _api = [weatherAPI_ retain];
    
    return _api;
}

//获得public key
- (NSString *)getPublicKey:(NSString *)areaid
                      type:(NSString *)type
                      date:(NSString *)date
                     appid:(NSString *)appid
{
    NSString *key = [[NSString alloc]
                     initWithFormat:@"http://open.weather.com.cn/data/?areaid=%@&type=%@&date=%@&appid=%@",
                     areaid, type, [date substringToIndex:12], appid];
    return [key autorelease];
}

//获得完整的API
- (NSString*)getAPI:(NSString*)areaid
               type:(NSString*)type
               date:(NSString*)date
              appid:(NSString*)appid
                key:(NSString*)key
{
    NSString *api = [[NSString alloc]
                     initWithFormat:@"http://open.weather.com.cn/data/?areaid=%@&type=%@&date=%@&appid=%@&key=%@",
                     areaid, type, [date substringToIndex:12], [appid substringToIndex:6],key];
    //这里需要主要的是只需要appid的前6位！！！
    
    return [api autorelease];
}

//对publickey和privatekey进行加密
- (NSString *)hmacSha1:(NSString*)public_key
            privatekey:(NSString*)private_key
{
    NSData *secretData = [private_key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *stringData = [public_key dataUsingEncoding:NSUTF8StringEncoding];
    
    const void *keyBytes = [secretData bytes];
    const void *dataBytes = [stringData bytes];
    
    ///#define CC_SHA1_DIGEST_LENGTH   20
    /* digestlength in bytes */
    void *outs = malloc(CC_SHA1_DIGEST_LENGTH);
    
    CCHmac(kCCHmacAlgSHA1, keyBytes,[secretData length], dataBytes, [stringData length], outs);
    
    //Soluion 1
    NSData* signatureData = [NSData dataWithBytesNoCopy:outs
                                                 length:CC_SHA1_DIGEST_LENGTH freeWhenDone:YES];
    
    return [NSString encodeBase64Data:signatureData];
}

//将获得的key进性urlencode操作
- (NSString *)stringByEncodingURLFormat:(NSString*)__key {
    NSString *encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)__key,nil, (CFStringRef) @"!$&'()*+,-./:;=?@_~%#[]",kCFStringEncodingUTF8);
    return [encodedString autorelease];
}

- (void)getWeatherInfoAreaId:(NSString *)areaId completion:(void (^)(BOOL))completion {
    if (completion) {
        _complation = [completion copy];
    }
    
    WeatherSource *source = [[WeatherSource alloc] initWithDelegate:self];
    [source getWeatherInfo:[self apiURLString:areaId]];
    _source = source;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    NSArray *f1 = [[source.data valueForKey:@"f"] valueForKey:@"f1"];
    NSDictionary *d1 = f1[0];
    
    [_weatherInfo setValue:[d1 objectForKey:@"fa"] forKey:WeahterPropertyDayWeather];
    [_weatherInfo setValue:[d1 objectForKey:@"fb"] forKey:WeatherPropertyNightWeather];
    [_weatherInfo setValue:[d1 objectForKey:@"fc"] forKey:WeatherPropertyDayTemperature];
    [_weatherInfo setValue:[d1 objectForKey:@"fd"] forKey:WeatherPropertyNightTemperature];
    [_weatherInfo setValue:[d1 objectForKey:@"fe"] forKey:WeatherPropertyDayWindDirection];
    [_weatherInfo setValue:[d1 objectForKey:@"ff"] forKey:WeatherPropertyNightWindDirection];
    [_weatherInfo setValue:[d1 objectForKey:@"fg"] forKey:WeatherPropertyDayWindForce];
    [_weatherInfo setValue:[d1 objectForKey:@"fh"] forKey:WeatherPropertyNightWindForce];
    
    if (_complation) {
        _complation(YES);
        [_complation release];
        _complation = nil;
    }
    
    [source release];source = nil;
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    if (_complation) {
        _complation(NO);
        [_complation release];
        _complation = nil;
    }
    
    [source release];source = nil;
}

@end
