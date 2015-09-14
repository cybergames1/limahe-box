//
//  GPSViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/9/4.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

@interface GPSViewController : BoxSuperViewController

@end



#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic,retain)NSString *title2;
@property (nonatomic,retain)NSString *subtitle2;
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString*)title SubTitle:(NSString*)subtitle Coordinate:(CLLocationCoordinate2D)coordinate;

@end
