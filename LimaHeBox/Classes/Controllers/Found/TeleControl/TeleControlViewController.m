//
//  TeleControlViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TeleControlViewController.h"
#import "TeleControlView.h"
#

@implementation TeleControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"遥控"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    TeleControlView *controlView = [[[TeleControlView alloc] initWithFrame:CGRectMake(10, 64+60, self.view.width-20, self.view.width-20)] autorelease];
    [controlView addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:controlView];
}

- (void)controlAction:(TeleControlView *)sender {
    NSLog(@"senderControl:%ld",(long)sender.control);
}

@end
