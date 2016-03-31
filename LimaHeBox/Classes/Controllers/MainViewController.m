//
//  MainViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "MainViewController.h"
#import "MainMenuView.h"
#import "WeatherAPI.h"
#import "WeatherView.h"
#import "AccountManager.h"
#import "TimePickerView.h"
#import "MessageViewController.h"
#import "DeviceManager.h"

#define Cell_Label_Tag 13232

//对应tabbarController的相应顺序
static int menuIndex[10] = {7,8,1,9,10,5,11,3,2,4};

@interface MainViewController () <MainMenuViewDelegate,TimePickerViewDelegate>
{
    WeatherView * _weatherView;
    WeatherAPI * _weatherAPI;
    
    UIImageView * _backgroundView;
}

@end

@implementation MainViewController

- (void)dealloc {
    [_weatherAPI release];_weatherAPI = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _weatherAPI = [[WeatherAPI alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"main_nav_left"]];
    [self setNavigationImage:[UIImage imageNamed:@"main_logo"]];
    [self setNavigationItemRightImage:[UIImage imageNamed:@"main_nav_message"]];
    [self setShowBadgeView:NO];
    
    //背景图
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    imageView.image = [UIImage imageNamed:@"main_bg"];
    [self.view addSubview:imageView];
    _backgroundView = imageView;
    
    //菜单
    MainMenuView *menuView = [[[MainMenuView alloc] initWithFrame:self.view.bounds] autorelease];
    menuView.delegate = self;
    [self.view addSubview:menuView];
    
    //天气
    WeatherView *weatherView = [[[WeatherView alloc] initWithFrame:CGRectMake(0, [CommonTools viewTopWithNav], self.view.frame.size.width/2, 60)] autorelease];
    [self.view addSubview:weatherView];
    _weatherView = weatherView;
    
    [self setWeatherInfo:@"101010100"];
}

- (void)setWeatherInfo:(NSString *)areaId {
    [_weatherAPI getWeatherInfoAreaId:areaId completion:^(BOOL finished) {
        if (finished) {
            NSDictionary *info = [_weatherAPI weatherInfo];
            [_weatherView setWeatherCode:[[info objectForKey:WeahterPropertyDayWeather] integerValue]];
            [_weatherView setMinTemperature:[[info objectForKey:WeatherPropertyNightTemperature] integerValue]];
            [_weatherView setMaxTemperature:[[info objectForKey:WeatherPropertyDayTemperature] integerValue]];
            [_weatherView setNeedsLayout];
        }
        else {
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewHidden:(BOOL)hidden {
    for (UIView *v in self.view.subviews) {
        if (v != _backgroundView) {
            v.alpha = hidden ? 0.0 : 1.0;
        }
    }
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
    self.navigationController.navigationBar.alpha = hidden ? 0.0 : 1.0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self cityPickerViewIsShwon]) return;
    
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(_weatherView.frame, [touch locationInView:self.view])) {
        CityPickerView *picker = [[CityPickerView alloc] init];
        picker.delegate = self;
        [picker showInView:self.view];
        [picker release];
    }
}

- (BOOL)cityPickerViewIsShwon {
    BOOL isShwon = NO;
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[CityPickerView class]]) {
            isShwon = YES;
            break;
        }
    }
    return isShwon;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pickerView:(CityPickerView *)pickerView cityId:(NSString *)cityId {
    [self setWeatherInfo:cityId];
}

#pragma mark -
#pragma mark MenuView Delegate
- (void)menuView:(MainMenuView *)menuView didSelectAtIndex:(NSInteger)index {
    [self.tabBarController setSelectedIndex:menuIndex[index]];
}

- (void)rightBarAction {
    [self setShowBadgeView:NO];
    MessageViewController *controller = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
