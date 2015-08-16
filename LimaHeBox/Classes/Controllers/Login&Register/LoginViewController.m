//
//  LoginViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LoginViewController.h"
#import "LRDataSource.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
{
    RLCell * _useNameCell;
    RLCell * _passwordCell;
}

@end
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"登陆帐号"];
    
    _useNameCell = [self topCell];
    _passwordCell = [self bottomCell];
    
    [_useNameCell.textField setPlaceholder:@"请输入用户名"];
    [_passwordCell.textField setPlaceholder:@"请输入密码"];
    [[self registerButton] setTitle:@"登录" forState:UIControlStateNormal];
    
    UIButton *registerButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, [self registerButton].bottom+10, self.view.width/2, 44)] autorelease];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    UIButton *resetPwdButton = [[[UIButton alloc] initWithFrame:CGRectMake(registerButton.right, registerButton.top, self.view.width/2, 44)] autorelease];
    [resetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [resetPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetPwdButton addTarget:self action:@selector(resetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPwdButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerAction {
    //注册
    RegisterViewController *controller = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)resetPwdAction {
    //忘记密码
}

- (void)doneAction {
    //登录
    LRDataSource *dataSource = [[[LRDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource loginWithUserName:_useNameCell.textField.text password:_passwordCell.textField.text];
    self.dataSource = dataSource;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarAction {
    
}

@end
