//
//  TeleControlViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TeleControlViewController.h"
#import "TeleControlView.h"
#import "TeleBar.h"

#define Left_Rate (34.0/270.0) //中间的操控区域离编辑的距离

@implementation TeleControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"遥控"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UIButton *device = [[[UIButton alloc] initWithFrame:CGRectMake(0, 64, self.view.width/2, 44)] autorelease];
    [device setTitle:@"选择设备" forState:UIControlStateNormal];
    [device setImage:[UIImage imageNamed:@"f_device"] forState:UIControlStateNormal];
    [device setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
    [device setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [device setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [device addTarget:self action:@selector(selectDeviceAction) forControlEvents:UIControlEventTouchUpInside];
    [device setBackgroundColor:UIColorRGB(60, 139, 200)];
    [self.view addSubview:device];
    
    UIButton *service = [[[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2, device.top, self.view.width/2, 44)] autorelease];
    [service setTitle:@"选择服务" forState:UIControlStateNormal];
    [service setImage:[UIImage imageNamed:@"f_service"] forState:UIControlStateNormal];
    [service setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
    [service setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [service setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [service addTarget:self action:@selector(selectServiceAction) forControlEvents:UIControlEventTouchUpInside];
    [service setBackgroundColor:UIColorRGB(60, 139, 200)];
    [self.view addSubview:service];
    
    CGFloat edge = self.view.width*Left_Rate;
    TeleControlView *controlView = [[[TeleControlView alloc] initWithFrame:CGRectMake(edge, service.bottom+edge, self.view.width-2*edge, self.view.width-2*edge)] autorelease];
    [controlView addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:controlView];
    
    TeleBar *bar = [[[TeleBar alloc] initWithFrame:CGRectMake(0, controlView.bottom+edge, self.view.width, 60)] autorelease];
    [self.view addSubview:bar];
}

- (void)selectDeviceAction {
    
}

- (void)selectServiceAction {
    
}

- (void)controlAction:(TeleControlView *)sender {
    NSLog(@"senderControl:%ld",(long)sender.control);
}

@end
