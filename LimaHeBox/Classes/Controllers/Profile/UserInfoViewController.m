//
//  UserInfoViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AccountManager.h"
#import "CommonTools.h"
#import "RegisterButton.h"
#import "UpdateIconViewController.h"
#import "NotificaionConstant.h"
#import "AccountManager.h"
#import "ResetPwdViewController.h"
#import "BindPhoneViewController.h"

@interface UserInfoViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation UserInfoViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"个人信息"];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UserInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = [[[AccountManager sharedManager] loginUser] userName];
        }
            break;
        case 1:{
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"男";
        }
            break;
        case 2:{
            cell.textLabel.text = @"手机号";
            cell.detailTextLabel.text = @"未绑定";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3: {
            cell.textLabel.text = @"年龄";
            cell.detailTextLabel.text = @"40";
        }
            break;
        case 4: {
            cell.textLabel.text = @"常居地";
            cell.detailTextLabel.text = @"北京";
        }
            break;
        case 5: {
            cell.textLabel.text = @"接受礼物地址";
            cell.detailTextLabel.text = @"北京市西城区西单北大街";
        }
            break;
        case 6: {
            cell.textLabel.text = @"修改密码";
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
    UIImageView *logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(view.width/2-logo.size.width/2, view.height/2-logo.size.height/2, logo.size.width, logo.size.height)] autorelease];
    logoImageView.image = logo;
    [view addSubview:logoImageView];
    
    [view addTarget:self action:@selector(changeIconAction) forControlEvents:UIControlEventTouchUpInside];
    return [view autorelease];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 100)];
    RegisterButton *button = [RegisterButton showGreenInView:view top:35 title:@"退出登录" target:self action:@selector(logoutAction)];
    [button setEnabled:YES];
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        //绑定手机号
        BindPhoneViewController *controller = [[BindPhoneViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:^(){}];
        [controller release];
        [nav release];
    }else if (indexPath.row == 6) {
        //修改密码
        ResetPwdViewController *controller = [[ResetPwdViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:^(){}];
        [controller release];
        [nav release];
    }else {
        
    }
}

- (void)changeIconAction {
    UpdateIconViewController *controller = [[UpdateIconViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:^(){}];
    [controller release];
    [nav release];
}

- (void)logoutAction {
    
}

@end
