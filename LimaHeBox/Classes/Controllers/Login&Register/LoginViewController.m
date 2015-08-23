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
#import "AccountManager.h"
#import "RetrievePwdViewController.h"

@interface LoginViewController ()
{
    RLCell * _useNameCell;
    RLCell * _passwordCell;
}

@end
@implementation LoginViewController

+ (void)showLogin:(UIViewController *)rootController
      finishBlock:(LoginFinish)finish
     failureBlock:(void (^)(void))failure
{
    BOOL isLogin = [AccountManager isLogin];
    if (isLogin && failure) {
        failure();
        return;
    }
    
    //保存finishBlock
    [[LRTools sharedTools] setFinishBlock:finish];
    
    LoginViewController *controller = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [rootController presentViewController:nav animated:YES completion:^(){}];
    [controller release];
    [nav release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"登录帐号"];
    
    _useNameCell = [self topCell];
    _passwordCell = [self bottomCell];
    
    [_useNameCell.textField setPlaceholder:@"请输入用户名"];
    [_passwordCell.textField setPlaceholder:@"请输入密码"];
    RegisterButton *loginButton = [self registerButton];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    UIButton *registerButton = [[[UIButton alloc] initWithFrame:CGRectMake(loginButton.left, loginButton.bottom+10, self.view.width/2-loginButton.left, 44)] autorelease];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.view addSubview:registerButton];
    
    UIButton *resetPwdButton = [[[UIButton alloc] initWithFrame:CGRectMake(loginButton.right-registerButton.width, registerButton.top, registerButton.width, 44)] autorelease];
    [resetPwdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [resetPwdButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetPwdButton addTarget:self action:@selector(resetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    [resetPwdButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
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
    RetrievePwdViewController *controller = [[RetrievePwdViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)doneAction {
    //登录
    [self showIndicatorHUDView:@"正在登录..."];
    LRDataSource *dataSource = [[[LRDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource loginWithUserName:_useNameCell.textField.text password:_passwordCell.textField.text];
    self.dataSource = dataSource;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [super dataSourceFinishLoad:source];
    [LRTools setLoginWithDictionary:[source.data objectForKey:@"data"]];
    [LRTools startAppIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self leftBarAction];
    });
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [super dataSource:source hasError:error];
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarAction {
    
}

@end
