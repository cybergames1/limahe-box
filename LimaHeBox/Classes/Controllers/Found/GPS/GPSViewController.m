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

@interface GPSViewController () <MKMapViewDelegate,MyCLControllerDelegate>
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
    
    //加入大头针
    MyAnnotation *anno = [[MyAnnotation alloc] initWithTitle:@"title" SubTitle:@"subtitle" Coordinate:[[[DeviceManager sharedManager] currentDevice] coordinate]];
    [mapView addAnnotation:anno];
    [anno release];
    
  //  [[MyCLController sharedInstance] setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gpsUpdate:(CLLocation *)aLoc {
//    MKCoordinateSpan theSpan = MKCoordinateSpanMake(0.1, 0.1);
//    MKCoordinateRegion theRegion = MKCoordinateRegionMake(aLoc.coordinate, theSpan);
//    
//    [_mapView setRegion:theRegion];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    //点击大头针，会出现以下信息
    userLocation.title=@"中国";
    userLocation.subtitle=@"四大文明古国之一";
    
    //让地图显示用户的位置（iOS8一打开地图会默认转到用户所在位置的地图），该方法不能设置地图精度
    //    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    //这个方法可以设置地图精度以及显示用户所在位置的地图
    MKCoordinateSpan span=MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region=MKCoordinateRegionMake([[[DeviceManager sharedManager] currentDevice] coordinate], span);
    [mapView setRegion:region animated:YES];
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
