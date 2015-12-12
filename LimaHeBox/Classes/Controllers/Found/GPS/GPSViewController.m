//
//  GPSViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/9/4.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "GPSViewController.h"
#import "LocationController.h"
#import <MapKit/MapKit.h>
#import "DeviceManager.h"

@interface GPSViewController () <MKMapViewDelegate>
{
    MKMapView * _mapView;
    CLLocationManager * _locMgr;
}

@end

@implementation GPSViewController

- (void)dealloc {
    [_locMgr release];_locMgr = nil;
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    [_mapView release];_mapView = nil;
    [super dealloc];
}

- (CLLocationManager *)locMgr {
    if (_locMgr == nil) {
        _locMgr = [[CLLocationManager alloc] init];
    }
    if ([_locMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locMgr requestWhenInUseAuthorization];
    }
    return _locMgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"GPS定位"];
    [self locMgr];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsUserLocation:YES];
    [mapView setDelegate:self];
    [self.view addSubview:mapView];
    _mapView = mapView;
    
    [[DeviceManager sharedManager] startGetDeviceInfo:^(NSError *error){
        if (error == nil) {
            [self showIndicatorHUDView:@"正在获取设备信息"];
        }else {
            [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
        }
    }success:^{
        [self hideAllHUDView];
        if (![self checkDeviceIsOnline]) return;
        
        CLLocationCoordinate2D coordinate2D = [[[DeviceManager sharedManager] currentDevice] coordinate];
        NSString *title = [NSString stringWithFormat:@"%f,%f",coordinate2D.latitude,coordinate2D.longitude];
        
        //加入大头针
        MyAnnotation *anno = [[MyAnnotation alloc] initWithTitle:title SubTitle:nil Coordinate:[[[DeviceManager sharedManager] currentDevice] coordinate]];
        [mapView addAnnotation:anno];
        [anno release];
        
        MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
        MKCoordinateRegion region=MKCoordinateRegionMake([[[DeviceManager sharedManager] currentDevice] coordinate], span);
        [mapView setRegion:region animated:YES];
        
    }failure:^(NSError *error) {
        [self hideAllHUDView];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[mapView.userLocation class]]) return nil;
    
    static NSString *identifier = @"mapID";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinView == nil) {
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
    }
    
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorPurple;
    pinView.animatesDrop = YES;
    
    return pinView;
}

@end


@implementation MyAnnotation
@synthesize title2 = _title2;
@synthesize subtitle2 = _subtitle2;
@synthesize coordinate = _coordinate;

- (id)initWithTitle:(NSString*)title SubTitle:(NSString*)subtitle Coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        self.title2 = title;
        self.subtitle2 = subtitle;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title
{
    return _title2;
}
- (NSString *)subtitle
{
    return _subtitle2;
}
- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (void)dealloc
{
    self.title2 = nil;
    self.subtitle2 = nil;
    [super dealloc];
}

@end
