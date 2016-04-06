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
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)] autorelease];
    imageView.image = [UIImage imageNamed:@"f_control"];
    [self.view addSubview:imageView];
}

- (void)selectDeviceAction {
    
}

- (void)selectServiceAction {
    
}

- (void)controlAction:(TeleControlView *)sender {
    NSLog(@"senderControl:%ld",(long)sender.control);
}

@end
