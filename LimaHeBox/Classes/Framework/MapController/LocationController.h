//
//  LocationController.h
//  LimaHeBox
//
//  Created by jianting on 15/9/4.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/SCNetworkConnection.h>
#import <UIKit/UIKit.h>

// This protocol is used to send the info for location updates back to another view controller
@protocol MyCLControllerDelegate <NSObject>
@required
-(void)gpsUpdate:(CLLocation *)aLoc;
@end


// Class definition
@interface MyCLController : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *myCurrentLoc;
    BOOL findShouldStop;
    id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id <MyCLControllerDelegate> delegate;
@property (nonatomic, assign) CLLocation *myCurrentLoc;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

+ (MyCLController *)sharedInstance;

@end
