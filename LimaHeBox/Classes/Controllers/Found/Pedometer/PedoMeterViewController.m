//
//  PedoMeterViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PedoMeterViewController.h"
#import "PedoMeterView.h"

@interface PedoMeterViewController ()

@end

@implementation PedoMeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationTitle:@"计步器"];
    
    PedoMeterView *meterView = [[[PedoMeterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2)] autorelease];
    meterView.backgroundColor = [UIColor colorWithRed:(3.0/255.0) green:(104.0/255.0) blue:(183.0/255.0) alpha:1.0];
    [self.view addSubview:meterView];
    [meterView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
