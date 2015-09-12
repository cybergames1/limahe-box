//
//  ResetPwdViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "LRDataSource.h"
#import "AccountManager.h"

@interface ResetPwdViewController ()
{
    RLCell * _prePwdCell;
    RLCell * _newPwdCell;
    RLCell * _repeatePwdCell;
}

@end
@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"修改密码"];
    
    _prePwdCell = [self topCell];
    _prePwdCell.textField.placeholder = @"请输入原密码";
    _prePwdCell.textField.secureTextEntry = YES;
    
    _newPwdCell = [self bottomCell];
    _newPwdCell.textField.placeholder = @"请输入新密码6-12位";
    
    _repeatePwdCell = [[[RLCell alloc] initWithFrame:CGRectMake(_newPwdCell.left, _newPwdCell.bottom+20, _newPwdCell.width, _newPwdCell.height)] autorelease];
    _repeatePwdCell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _repeatePwdCell.textField.clearsOnBeginEditing = YES;
    _repeatePwdCell.textField.secureTextEntry = YES;
    _repeatePwdCell.textField.placeholder = @"请再次输入新密码";
    [self.view addSubview:_repeatePwdCell];
    
    [self registerButton].top += 20+_repeatePwdCell.height;
    [[self registerButton] setTitle:@"确定" forState:UIControlStateNormal];
}

- (void)doneAction {
    if (![_newPwdCell.textField.text isEqualToString:_repeatePwdCell.textField.text]) {
        [self showHUDWithText:@"新密码两次输入不一样"];
        return;
    }
    
    if ([_newPwdCell.textField.text length] <= 0 || [_newPwdCell.textField.text length] <= 0) {
        [self showHUDWithText:@"密码不能为空"];
        return;
    }
    
    [self showIndicatorHUDView:@"正在更新..."];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    
    LRDataSource *dataSource = [[LRDataSource alloc] initWithDelegate:self];
    [dataSource updatePwdWithUserName:loginUser.userName oldpwd:_prePwdCell.textField.text newpwd:_newPwdCell.textField.text];
    self.dataSource = dataSource;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [super dataSourceFinishLoad:source];
    [self leftBarAction];
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [super dataSource:source hasError:error];
}

@end
