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
#import "LoginViewController.h"
#import "WeatherAPI.h"
#import "WeatherView.h"
#import "ExpressViewController.h"
#import "FoundViewController.h"
#import "TravelViewController.h"
#import "BlueToothViewController.h"
#import "AccountManager.h"
#import "UserViewController.h"
#import "ShareViewController.h"
#import "CDRTranslucentSideBar.h"

#define Cell_Label_Tag 13232

static int menuIndex[7] = {-1,2,1,3,0,4,5};

@interface MainViewController () <MainMenuViewDelegate,CDRTranslucentSideBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _tabList;
    UITableView * _tableView;
}

@property (nonatomic, retain) CDRTranslucentSideBar *sideBar;

@end

@implementation MainViewController

- (void)dealloc {
    [_sideBar release];_sideBar = nil;
    [_tabList release];_tabList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *tabList_ = @[@"首页",@"蓝牙",@"行程预定",@"分享",@"快递",@"发现",@"我的"];
        _tabList = [tabList_ retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"main_nav_left"]];
    [self setNavigationImage:[UIImage imageNamed:@"main_logo"]];
    [self setBoxSideBar];
    
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

- (void)setBoxSideBar {
    CDRTranslucentSideBar *sideBar = [[[CDRTranslucentSideBar alloc] init] autorelease];
    sideBar.sideBarWidth = 200;
    sideBar.delegate = self;
    sideBar.tag = 0;
    self.sideBar = sideBar;
    
    // Create Content of SideBar
    UITableView *tableView = [[[UITableView alloc] init] autorelease];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView];
    _tableView = tableView;
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

#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated
{
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated
{
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated
{
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark -
#pragma mark UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tabList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, cell.height)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.tag = Cell_Label_Tag;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    [(UILabel *)[cell.contentView viewWithTag:Cell_Label_Tag] setText:_tabList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self menuView:nil didSelectAtIndex:menuIndex[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width, 100)] autorelease];
    [button setTitle:[AccountManager isLogin] ? loginUser.userName : @"登录" forState:UIControlStateNormal];
    [button setImage:[AccountManager isLogin] ? [UIImage decodedImageWithImage:[UIImage imageWithContentsOfFile:loginUser.userIcon] maximumSize:CGSizeMake(68, 68)] : [UIImage imageNamed:@"main_userheader"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [button addTarget:self action:@selector(isShowLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(20, view.height-2, view.width-40, 2)] autorelease];
    v.backgroundColor = [UIColor whiteColor];
    [view addSubview:v];
    
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

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
        case 1:
            //行程
        {
            TravelViewController *controller = [[TravelViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
        }
            break;
        case 2:
            //蓝牙
        {
            BlueToothViewController *controller = [[BlueToothViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
        }
            break;
        case 3:
            //分享
        {
            ShareViewController *controller = [[ShareViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
        }
            break;
        case 4:
            //发现
        {
            FoundViewController *controller = [[FoundViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
        }
            break;
        case 5:
            //我的
        {
            [self isShowLoginAction];
        }
            break;
        default:
        {
            if (self.presentedViewController) {
                [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
    }
}

- (void)isShowLoginAction {
    [LoginViewController showLogin:self
                       finishBlock:^
     {
         [_tableView reloadData];
     }
                      failureBlock:^
     {
         UserViewController *controller = [[UserViewController alloc] init];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
         [self.navigationController presentViewController:nav animated:YES completion:nil];
         [controller release];
         [nav release];
     }];

}

- (void)leftBarAction {
    [self.sideBar show];
}

- (void)rightBarAction {
    MessageViewController *controller = [[MessageViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
