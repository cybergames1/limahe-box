//
//  RegisterViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "RegisterViewController.h"
#import "LRDataSource.h"

@interface RegisterViewController ()
{
    RLCell * _useNameCell;
    RLCell * _passwordCell;
}

@end
@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"注册帐号"];
    
    _useNameCell = [self topCell];
    _useNameCell.titleLabel.text = @"用户名:";
    _useNameCell.textField.placeholder = @"4-12位的数字和字母";
    
    _passwordCell = [self bottomCell];
    _passwordCell.titleLabel.text = @"密码:";
    _passwordCell.textField.placeholder = @"6-12位";
    
    [[self registerButton] setTitle:@"提交" forState:UIControlStateNormal];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(_useNameCell.left, [self registerButton].bottom+20, self.view.width-2*_useNameCell.left, 120)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 6;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = @"如果您已经购买了利马赫的产品，请查看箱子的使用说明书，请按说明书提供的用户名和密码登录。您将得到更完善的服务，并且享受利马赫产品的全部售后服务。\n\n登录成功成功后可自行修改密码。";
    [self.view addSubview:label];
}

- (void)doneAction {
    //注册
    [self showIndicatorHUDView:@"正在注册..."];
    LRDataSource *dataSource = [[[LRDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource registerWithUserName:_useNameCell.textField.text password:_passwordCell.textField.text phone:@"13682010773"];
    self.dataSource = dataSource;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [super dataSourceFinishLoad:source];
    [LRTools setLoginWithDictionary:[source.data objectForKey:@"data"]];
    [LRTools startAppIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [super dataSource:source hasError:error];
    
}

@end
