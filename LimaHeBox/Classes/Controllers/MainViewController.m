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
#import "DeviceDataSource.h"
#import "DeviceManager.h"

#define Cell_Label_Tag 13232

static int menuIndex[8] = {4,2,1,3,5,7,8,9};

@interface MainViewController () <MainMenuViewDelegate,TimePickerViewDelegate,PPQDataSourceDelegate>
{
    WeatherView * _weatherView;
    WeatherAPI * _weatherAPI;
    
    UIImageView * _backgroundView;
}

@property (nonatomic, retain) DeviceDataSource * dataSource;

@end

@implementation MainViewController

- (void)dealloc {
    [_weatherAPI release];_weatherAPI = nil;
    if (_dataSource) {
        _dataSource.delegate = nil;
    }
    [_dataSource release];_dataSource = nil;
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
    [self setShowBadgeView:YES];
    
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
    WeatherView *weatherView = [[[WeatherView alloc] initWithFrame:CGRectMake(0, [CommonTools viewTopWithNav], self.view.frame.size.width, 60)] autorelease];
    [self.view addSubview:weatherView];
    _weatherView = weatherView;
    
    [self setWeatherInfo:@"101010100"];
    
    //设备信息
    DeviceDataSource *dataSource = [[[DeviceDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource getDeviceInfo:@"867144029586110"];
    self.dataSource = dataSource;
}

- (void)setWeatherInfo:(NSString *)areaId {
    [_weatherAPI getWeatherInfoAreaId:areaId completion:^(BOOL finished) {
        if (finished) {
            NSDictionary *info = [_weatherAPI weatherInfo];
            NSLog(@"info:%@",info);
            NSLog(@"dayWeather:%d",[[info objectForKey:WeahterPropertyDayWeather] intValue]);
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
    UITouch *touch = [touches anyObject];
    if (CGRectContainsPoint(_weatherView.frame, [touch locationInView:self.view])) {
        CityPickerView *picker = [[CityPickerView alloc] init];
        picker.delegate = self;
        [picker showInView:self.view];
        [picker release];
    }
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

#pragma mark -
#pragma mark DataSource Delegate

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [[DeviceManager sharedManager] setCurrentDevice:[[[MDevice alloc] initWithDictionary:[source.data objectForKey:@"data"]] autorelease]];
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

@end
