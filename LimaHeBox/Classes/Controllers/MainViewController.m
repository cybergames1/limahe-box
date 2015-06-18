//
//  MainViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "MainViewController.h"
#import "MainMenuView.h"
#import "MessageViewController.h"
#import "LRSuperViewController.h"
#import "WeatherProvince.h"

@interface MainViewController () <PPQDataSourceDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"bg-addbutton"]];
    [self setNavigationItemRightImage:[UIImage imageNamed:@"icon-plus-highlighted"]];
    [self setNavigationTitle:@"首页"];
    
    MainMenuView *menuView = [[[MainMenuView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:menuView];
    
    WeatherProvince *pp = [[WeatherProvince alloc] initWithDelegate:self];
    [pp getProvinceList];
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

- (void)leftBarAction {
    LRSuperViewController *controller = [[LRSuperViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    [controller release];
    [nav release];
}

- (void)rightBarAction {
    MessageViewController *controller = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


///////

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    NSLog(@"source finish");
    NSLog(@"data:%@",source.data);
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

@end
