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
#import "WeatherAPI.h"
#import "WeatherView.h"
#import "CommonTools.h"
#import <Category/Category.h>
#import "ExpressViewController.h"

@interface MainViewController () <MainMenuViewDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"main_nav_left"]];
    [self setNavigationImage:[UIImage imageNamed:@"main_logo"]];
    
    //背景图
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    
    //菜单
    MainMenuView *menuView = [[[MainMenuView alloc] initWithFrame:self.view.bounds] autorelease];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    
    //天气
    WeatherView *weatherView = [[[WeatherView alloc] initWithFrame:CGRectMake(0, [CommonTools viewTopWithNav], self.view.frame.size.width, 60)] autorelease];
    [self.view addSubview:weatherView];
    
    WeatherAPI *api = [[WeatherAPI alloc] init];
    [api getWeatherInfo:^(BOOL finished) {
        if (finished) {
            NSDictionary *info = [api weatherInfo];
            NSLog(@"info:%@",info);
            NSLog(@"dayWeather:%d",[[info objectForKey:WeahterPropertyDayWeather] intValue]);
            [weatherView setWeatherCode:[[info objectForKey:WeahterPropertyDayWeather] integerValue]];
            [weatherView setMinTemperature:[[info objectForKey:WeatherPropertyNightTemperature] integerValue]];
            [weatherView setMaxTemperature:[[info objectForKey:WeatherPropertyDayTemperature] integerValue]];
            [weatherView setNeedsLayout];
        }
        else {
            
        }
    }];
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

#pragma mark -
#pragma mark MenuView Delegate
- (void)menuView:(MainMenuView *)menuView didSelectAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            //快递
        {
            ExpressViewController *controller = [[ExpressViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
        }
            break;
            
        default:
            break;
    }
}

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

@end
