//
//  BoxSideBarController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSideBarController.h"
#import "MainViewController.h"
#import "BlueToothViewController.h"
#import "ExpressViewController.h"
#import "TravelViewController.h"
#import "ShareViewController.h"
#import "FoundViewController.h"
#import "UserViewController.h"
#import "LoginViewController.h"
#import "WeighViewController.h"
#import "TempViewController.h"
#import "GPSViewController.h"
#import "AccountManager.h"
#import "DeviceManager.h"
#import "MBProgressHUD.h"
#import "UserInfoViewController.h"

#define Label_Tag 1232

@interface BoxSideBarController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _tabList;
    UIView * _maskView;
    UITableView * _tableView;
    
    MainViewController * _mainController;
}

@end

@implementation BoxSideBarController

+ (void)registerSystemRemoteNotification
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                                categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

+ (void)unregisterForRemoteNotification
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

+ (void)logout {
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (controller.presentedViewController) {
        [controller.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)dealloc {
    [_tabList release];_tabList = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *tabList_ = @[@"首\t  页",@"蓝\t  牙",@"行程预定",@"分\t  享",@"快\t  递",@"发\t  现",@"我\t  的-"];
        _tabList = [tabList_ retain];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout:) name:kUserDidLogOutNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:kUserInfoDidUpdateNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainViewController *main = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    self.viewControllers = @[mainNav];
    [self.tabBar setHidden:YES];
    _mainController = main;
    
    [main release];
    [mainNav release];
    
    [self setBoxSideBar];
    
    //设备信息
    [[DeviceManager sharedManager] startGetDeviceInfo:^(NSError *error){
        if (error == nil) {
            //
        }else {
            if (error.code == 101) {
                [self showAlertView:@"您还没有登录" alertTitle:@"提示" cancleTitle:@"取消" otherButtonTitle:@"登录" dismissBlock:^(NSString *buttonTitle) {
                    if ([buttonTitle isEqualToString:@"登录"]) {
                        [self showLogin];
                    }
                }];
            }else if (error.code == 102) {
                [self showBindDevice];
            }else {
                //
            }
        }
    }success:^{
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD hideAllHUDsForView:[CommonTools keyWindow] animated:NO];
        [MBProgressHUD hideAllHUDsForView:[CommonTools visibleWindow] animated:NO];
    }failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD hideAllHUDsForView:[CommonTools keyWindow] animated:NO];
        [MBProgressHUD hideAllHUDsForView:[CommonTools visibleWindow] animated:NO];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideSideBar];
}

- (void)userLogout:(NSNotification *)notification {
    [_tableView reloadData];
}

- (void)updateUserInfo:(NSNotification *)notification {
    [_tableView reloadData];
}

- (void)showLogin {
    [LoginViewController showLogin:self
                       finishBlock:^
     {
         [_tableView reloadData];
         //延迟1秒提示绑定设备
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
             if ([CommonTools isEmptyString:[[[AccountManager sharedManager] loginUser] userDeviceId]]) {
                 [self showBindDevice];
             }
         });
     }
                      failureBlock:^
     {
         
     }];
}

- (void)showBindDevice {
    [self showAlertView:@"您还没有绑定设备" alertTitle:@"提示" cancleTitle:@"取消" otherButtonTitle:@"绑定" dismissBlock:^(NSString *buttonTitle) {
        if ([buttonTitle isEqualToString:@"绑定"]) {
            UserViewController *controller = [[UserViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:nav animated:YES completion:nil];
            [controller release];
            [nav release];
            
            UserInfoViewController *infoController = [[UserInfoViewController alloc] init];
            [controller.navigationController pushViewController:infoController animated:NO];
            [infoController release];
        }
    }];
}

- (void)showSideBar {
    [UIView animateWithDuration:0.3 animations:^{
        if (self.view.left <= 0) {
            self.view.left += 185;
            _maskView.alpha = 0.5;
            [_mainController setViewHidden:YES];
        }
    }];
}

- (void)hideSideBar {
    [UIView animateWithDuration:0.3 animations:^{
        if (self.view.left > 0) {
            self.view.left -= 185;
            _maskView.alpha = 0.0;
            [_mainController setViewHidden:NO];
        }
    }];
}

- (void)setBoxSideBar {
    // Create Content of SideBar
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 185, self.view.height)] autorelease];
    imageView.image = [UIImage imageNamed:@"main_left"];
    [window addSubview:imageView];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 185, self.view.height)] autorelease];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [window addSubview:tableView];
    _tableView = tableView;
    
    UIView *maskView = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.0;
    [self.view addSubview:maskView];
    _maskView = maskView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [maskView addGestureRecognizer:tap];
    [tap release];
}

- (void)tapAction:(UIGestureRecognizer *)recognizer {
    [self hideSideBar];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self hideSideBar];
    
    UIViewController *controller = nil;
    
    switch (selectedIndex) {
        case 1:
            //蓝牙
            controller = [[BlueToothViewController alloc] init];
            break;
        case 2:
            //行程
            controller = [[TravelViewController alloc] init];
            break;
        case 3:
            //分享
            controller = [[ShareViewController alloc] init];
            break;
        case 4:
            //快递
            controller = [[ExpressViewController alloc] init];
            break;
        case 5:
            //发现
            controller = [[FoundViewController alloc] init];
            break;
        case 6:
            //我的
            [self isShowLoginAction];
            break;
        case 7:
            //温湿度
            controller = [[TempViewController alloc] init];
            break;
        case 8:
            //称重
            controller = [[WeighViewController alloc] init];
            break;
        case 9:
            //GPS
            controller = [[GPSViewController alloc] init];
            break;
        default:
            break;
    }
    
    if (controller) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
        [controller release];
        [nav release];
    }
}

- (void)setLabelInCell:(UITableViewCell *)cell {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(30, 0, cell.width, cell.height)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.tag = Label_Tag;
    label.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:label];
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
        [self setLabelInCell:cell];
    }
    [(UILabel *)[cell.contentView viewWithTag:Label_Tag] setText: _tabList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setSelectedIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 120)];
    view.backgroundColor = [UIColor clearColor];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(-40, 5, view.width+40, 120)] autorelease];
    [button setTitle:[AccountManager isLogin] ? loginUser.userName : @"登录" forState:UIControlStateNormal];
    [button setImage:[AccountManager isLogin] ? [UIImage decodedImageWithImage:[UIImage imageWithContentsOfFile:loginUser.userIcon] maximumSize:CGSizeMake(68, 68)] : [UIImage imageNamed:@"main_userheader"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [button addTarget:self action:@selector(isShowLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 120;
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
         [self presentViewController:nav animated:YES completion:nil];
         [controller release];
         [nav release];
     }];
    
}


@end
