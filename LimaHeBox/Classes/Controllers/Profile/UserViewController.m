//
//  UserViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "UserViewController.h"
#import <Category/Category.h>
#import "AccountManager.h"
#import "CommonTools.h"
#import "UserInfoViewController.h"
#import "BlueToothSettingViewController.h"

@interface UserViewController () <UITableViewDataSource,UITableViewDelegate>

@end
@implementation UserViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"个人信息"];
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
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
        case 0:{
            cell.textLabel.text = @"蓝牙报警设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 1:{
            cell.textLabel.text = @"检查更新";
        }
            break;
        case 2:{
            cell.textLabel.text = @"关于我们";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 200)];
    
//    UIImageView *logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(view.width/2-80/2, 40, 80, 80)] autorelease];
//    logoImageView.image = [UIImage imageNamed:@"setting_icon"];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    UILabel *versionLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 10, view.width, 20)] autorelease];
    versionLabel.backgroundColor = [UIColor clearColor];
    versionLabel.text = [CommonTools isEmptyString:loginUser.userName] ? @"登录/注册" : loginUser.userName;
    versionLabel.textColor = [UIColor blackColor];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:versionLabel];
    
    [view addTarget:self action:@selector(goUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            // 蓝牙报警设置
            BlueToothSettingViewController *controller = [[BlueToothSettingViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 1: {
            //检查更新
        }
            break;
        case 2:{
            //关于
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

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

