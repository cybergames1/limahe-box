//
//  BindPhoneViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()
{
    RLCell * _phoneCell;
    RLCell * _codeCell;
}

@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"修改密码"];
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    
    _phoneCell = [self topCell];
    _phoneCell.textField.placeholder = @"请输入手机号";
    
    _codeCell = [self bottomCell];
    _codeCell.textField.placeholder = @"请输入验证码";
    
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 130, _codeCell.height)] autorelease];
    [button setBackgroundColor:UIColorRGB(72, 217, 192)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_codeCell setRightView:button];
    
    [[self registerButton] setTitle:@"绑定" forState:UIControlStateNormal];
}

- (void)getCodeAction:(UIButton *)sender {
    
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

