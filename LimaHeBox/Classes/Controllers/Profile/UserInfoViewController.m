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
#import "PFPickerSheet.h"
#import "EditProfileManager.h"
#import "AccountManager.h"
#import "EditUserInfoViewController.h"

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

- (NSDictionary *)addressDictionary:(NSString *)city {
    NSArray *citys = [city componentsSeparatedByString:@" "];
    if ([citys count] <= 0) return nil;
    
    NSDictionary* provinceCityList = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinceCity" ofType:@"plist"]];
    NSDictionary* provinceList = [[NSDictionary alloc] initWithDictionary:[provinceCityList valueForKey:@"province"]];
    NSDictionary* cityList = [[NSDictionary alloc] initWithDictionary:[provinceCityList valueForKey:@"city"]];
    NSString *provinceCode = [provinceList allKeysForObject:citys[0]][0];
    NSDictionary* cityListForProvince = [[NSDictionary alloc] initWithDictionary:[cityList valueForKey:provinceCode]];
    
    NSDictionary *dic = nil;
    if ([citys count] == 1) {
        dic = @{@"province" : citys[0],
                 @"provinceCode" : provinceCode};
    }else {
        dic = @{@"province" : citys[0],
                 @"provinceCode" : provinceCode,
                 @"city" : citys[1],
                 @"cityCode" : [cityListForProvince allKeysForObject:citys[1]][0]};
    }
    
    [provinceCityList release];
    [provinceList release];
    [cityList release];
    [cityListForProvince release];
    
    return dic;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UserInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = [loginUser userName];
        }
            break;
        case 1:{
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = [loginUser userGender];
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
            cell.detailTextLabel.text = [loginUser userAge];
        }
            break;
        case 4: {
            cell.textLabel.text = @"常居地";
            cell.detailTextLabel.text = [loginUser userCity];
        }
            break;
        case 5: {
            cell.textLabel.text = @"常用地址";
            cell.detailTextLabel.text = [loginUser userAddress];
        }
            break;
        case 6: {
            cell.textLabel.text = @"设备号";
            cell.detailTextLabel.text = [CommonTools isEmptyString:[loginUser userDeviceId]] ? @"未绑定" : [loginUser userDeviceId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 7: {
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
    }else if (indexPath.row == 1) {
        //性别
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [PFPickerSheet showPickerSheet:PFPickerOptionGender previewData:cell.detailTextLabel.text finishBlock:^(PFPickerOption option, id data) {
            __block NSString* gender = [data retain];
            [EditProfileManager uploadUserGender:gender block:^(NSError *error, id info) {
                if (error) {
                    [self showHUDWithText:[error localizedDescription]];
                }
                else{
                    MUser* user = [[AccountManager sharedManager] loginUser];
                    [user updateUserValue:gender forKey:kUserInfoGenderKey];
                    [self showHUDWithText:@"修改性别成功！"];
                }
            }];
        }];
    }else if (indexPath.row == 3) {
        //修改年龄
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditUserInfoViewController* controller = [[EditUserInfoViewController alloc] initWithOption:ProfileEditOptionAge profileInfo:cell.detailTextLabel.text];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else if (indexPath.row == 4) {
        //修改居住地
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [PFPickerSheet showPickerSheet:PFPickerOptionAddress previewData:[self addressDictionary:cell.detailTextLabel.text] finishBlock:^(PFPickerOption option, id data) {
            __block NSString* city = [data retain];
            [EditProfileManager uploadUserCity:city block:^(NSError *error, id info) {
                if (error) {
                    [self showHUDWithText:[error localizedDescription]];
                }
                else{
                    MUser* user = [[AccountManager sharedManager] loginUser];
                    [user updateUserValue:city forKey:kUserInfoCityKey];
                    [self showHUDWithText:@"修改常居地成功"];
                }
            }];
        }];
    }else if (indexPath.row == 5) {
        //修改常用地址
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditUserInfoViewController* controller = [[EditUserInfoViewController alloc] initWithOption:ProfileEditOptionAddress profileInfo:cell.detailTextLabel.text];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else if (indexPath.row == 6) {
        //添加设备号
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        EditUserInfoViewController* controller = [[EditUserInfoViewController alloc] initWithOption:ProfileEditOptionDeviceId profileInfo:cell.detailTextLabel.text];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else if (indexPath.row == 7) {
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
