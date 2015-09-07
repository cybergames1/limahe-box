//
//  TempViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TempViewController.h"
#import "TemperatureView.h"
#import "DeviceManager.h"

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"温湿度监控"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44)] autorelease];
    label.backgroundColor = UIColorRGB(60, 139, 200);
    label.textColor = [UIColor whiteColor];
    label.text = @"\t舒适程度\t\tLOW";
    [self.view addSubview:label];
    
    TemperatureView *temp1 = [[[TemperatureView alloc] initWithFrame:CGRectMake(40, label.bottom+(self.view.height-label.bottom)/2-self.view.height/4, (self.view.width-80)/2, self.view.height/2)] autorelease];
    temp1.gradutaionDirection = GraduationDirectionRight;
    temp1.maxValue = 50;
    temp1.minValue = -10;
    temp1.selectedMaxValue = 40;
    temp1.selectedMinValue = 20;
    temp1.selectedColor = UIColorRGB(241, 209, 64);
    temp1.currentValue = [[[DeviceManager sharedManager] currentDevice] temperature];
    temp1.tempImage = [UIImage imageNamed:@"f_temp"];
    [self.view addSubview:temp1];
    
    TemperatureView *temp2 = [[[TemperatureView alloc] initWithFrame:CGRectMake(temp1.right, temp1.top, (self.view.width-80)/2, self.view.height/2)] autorelease];
    temp2.gradutaionDirection = GraduationDirectionLeft;
    temp2.maxValue = 100;
    temp2.minValue = 0;
    temp2.selectedMaxValue = 70;
    temp2.selectedMinValue = 30;
    temp2.selectedColor = UIColorRGB(71, 218, 192);
    temp2.currentValue = [[[DeviceManager sharedManager] currentDevice] wet];
    temp2.tempImage = [UIImage imageNamed:@"f_dity"];
    [self.view addSubview:temp2];
}

@end
