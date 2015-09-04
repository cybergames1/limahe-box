//
//  LocationController.m
//  LimaHeBox
//
//  Created by jianting on 15/9/4.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LocationController.h"

// This is a singleton class, see below
static MyCLController *sharedCLDelegate = nil;

@implementation MyCLController

@synthesize delegate, locationManager, myCurrentLoc;

- (id) init {
    
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; // Tells the location manager to send updates to this object
        self.myCurrentLoc = [[CLLocation alloc] initWithLatitude:0 longitude:0];
        [self.locationManager startUpdatingLocation];
        
        if ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
        {
            if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                [locationManager requestWhenInUseAuthorization];
            }
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请在设置-隐私-定位服务中开启定位功能！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
            [alertView show];
            [alertView release];
        }
            break;
        case kCLAuthorizationStatusRestricted:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"定位服务无法使用！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
            [alertView show];
            [alertView release];
        }
            break;
        default:
            break;
            
    }
}

// Called when the location is updated
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    // Horizontal coordinates
    if (signbit(newLocation.horizontalAccuracy)) {
        // Negative accuracy means an invalid or unavailable measurement
        [self.delegate gpsUpdate:nil];
        return;
    }

    // Check the timestamp, see if it's an hour old or more. If so, don't send an update
    if (ABS([newLocation.timestamp timeIntervalSinceNow]) > 3600) {
        [self.delegate gpsUpdate:nil];
        return;
    }
    
    [myCurrentLoc release];
    myCurrentLoc = [newLocation copy]; // TODO: Why does this increment the retain count? We should be manually retaining
    
    // Looks like the loc is good
    [self.delegate gpsUpdate:myCurrentLoc];
    return;
}

// Called when there is an error getting the location
// TODO: Update this function to return the proper info in the proper UI fields
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    NSMutableString *errorString = [[[NSMutableString alloc] init] autorelease];
    BOOL shouldQuit;
    
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        
        switch ([error code]) {
                // This error code is usually returned whenever user taps "Don't Allow" in response to
                // being told your app wants to access the current location. Once this happens, you cannot
                // attempt to get the location again until the app has quit and relaunched.
                //
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
                //
            case kCLErrorDenied:
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationDenied", nil)];
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"AppWillQuit", nil)];
                shouldQuit = YES;
                break;
                
                // This error code is usually returned whenever the device has no data or WiFi connectivity,
                // or when the location cannot be determined for some other reason.
                //
                // CoreLocation will keep trying, so you can keep waiting, or prompt the user.
                //
            case kCLErrorLocationUnknown:
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"LocationUnknown", nil)];
                [errorString appendFormat:@"%@\n", NSLocalizedString(@"AppWillQuit", nil)];
                shouldQuit = YES;
                break;
                
                // We shouldn't ever get an unknown error code, but just in case...
                //
            default:
                [errorString appendFormat:@"%@ %ld\n", NSLocalizedString(@"GenericLocationError", nil), (long)[error code]];
                shouldQuit = NO;
                break;
        }
    } else {
        // We handle all non-CoreLocation errors here
        // (we depend on localizedDescription for localization)
        [errorString appendFormat:@"Error domain: \"%@\"  Error code: %ld\n", [error domain], (long)[error code]];
        [errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
        shouldQuit = NO;
    }
    
    // TODO: Send the delegate the alert?
    if (shouldQuit) {
        // do nothing
    }
}

+ (MyCLController *)sharedInstance {
    @synchronized(self) {
        if (sharedCLDelegate == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedCLDelegate;
}

@end