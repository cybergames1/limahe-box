//
//  FoundViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "FoundViewController.h"
#import "AlarmClockEditViewController.h"

@interface FoundViewController ()

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"main_nav_left"]];
    [self setNavigationTitle:@"发现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarAction {
    AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
