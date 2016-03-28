//
//  UserViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "UserViewController.h"
#import "AccountManager.h"
#import "UserInfoViewController.h"
#import "BlueToothSettingViewController.h"
#import "AboutViewController.h"
#import "NotificaionConstant.h"
#import "EditUserInfoViewController.h"

#define Logo_Left_Rate (40.0/360.0)

@interface UserViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end
@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"功能设置"];
    self.view.backgroundColor = UIColorRGB(248, 248, 248);
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:kUserInfoDidUpdateNotification object:nil];
}

- (void)updateUserInfo {
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    switch (indexPath.row) {
        case 0: {
            cell.textLabel.text = @"设备绑定";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:{
            cell.textLabel.text = @"蓝牙设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 2:{
            cell.textLabel.text = @"版本信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 150)];
    
    UIImage *logo = [UIImage imageWithContentsOfFile:[[[AccountManager sharedManager] loginUser] userIcon]];
    UIImageView *logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(view.width*Logo_Left_Rate, view.height/2-logo.size.height/2, logo.size.width, logo.size.height)] autorelease];
    logoImageView.image = logo;
    [view addSubview:logoImageView];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    UILabel *versionLabel = [[[UILabel alloc] initWithFrame:CGRectMake(logoImageView.right, view.height/2-20/2, view.width-logoImageView.right-40, 20)] autorelease];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.text = [CommonTools isEmptyString:loginUser.userName] ? @"登录/注册" : loginUser.userName;
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentRight;
    versionLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:versionLabel];
    
    [view addTarget:self action:@selector(goUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            //添加设备号
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            EditUserInfoViewController* controller = [[EditUserInfoViewController alloc] initWithOption:ProfileEditOptionDeviceId profileInfo:cell.detailTextLabel.text];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 1:{
            // 蓝牙报警设置
            BlueToothSettingViewController *controller = [[BlueToothSettingViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 2:{
            //关于
            AboutViewController *controller = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        default:
            break;
    }
}

- (void)goUserInfo {
    UserInfoViewController *controller = [[UserInfoViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end

