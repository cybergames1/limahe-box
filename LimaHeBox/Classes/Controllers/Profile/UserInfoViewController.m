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

@interface UserInfoViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"个人信息"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 100)];
    
    UIImageView *logoImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(view.width/2-80/2, 40, 80, 80)] autorelease];
    logoImageView.image = [UIImage imageNamed:@"setting_icon"];
    [view addSubview:logoImageView];
    return [view autorelease];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 60)];
    RegisterButton *button = [RegisterButton showGreenInView:view top:15 title:@"退出登录" target:self action:@selector(logoutAction)];
    [button setEnabled:YES];
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        //绑定手机号
    }else if (indexPath.row == 6) {
        //修改密码
    }else {
        
    }
}

- (void)logoutAction {
    
}

@end
