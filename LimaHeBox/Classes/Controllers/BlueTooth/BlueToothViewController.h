//
//  BlueToothViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/7/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothViewController : BoxSuperViewController

@end

@interface BLEInfo : NSObject

@property (nonatomic, retain) CBPeripheral * discoveredPeripheral;
@property (nonatomic, retain) NSNumber * rssi;

@end
