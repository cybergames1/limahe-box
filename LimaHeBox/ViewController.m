//
//  ViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ViewController.h"
#import "WeatherProvince.h"

@interface ViewController () <PPQDataSourceDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WeatherProvince *province = [[WeatherProvince alloc] initWithDelegate:self];
    [province getProvinceList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source
{
    NSLog(@"finished");
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error
{
    NSLog(@"failed");
}

@end
