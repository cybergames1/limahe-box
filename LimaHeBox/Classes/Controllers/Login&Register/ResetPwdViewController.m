//
//  ResetPwdViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ResetPwdViewController.h"

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
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    
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

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneAction {
    if (![_newPwdCell.textField.text isEqualToString:_repeatePwdCell.textField.text]) {
        [self showHUDWithText:@"新密码两次输入不一样"];
        return;
    }
}

@end
