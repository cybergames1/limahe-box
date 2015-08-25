//
//  RetrievePwdViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "RetrievePwdViewController.h"

@interface RetrievePwdViewController ()
{
    RLCell * _useNameCell;
    RLCell * _emailCell;
}

@end

@implementation RetrievePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"找回密码"];
    
    _useNameCell = [self topCell];
    _useNameCell.titleLabel.text = @"用户名:";
    _useNameCell.textField.placeholder = @"4-12位的数字和字母";
    
    _emailCell = [self bottomCell];
    _emailCell.titleLabel.text = @"邮箱:";
    _emailCell.textField.placeholder = @"向该邮箱发送初始化密码";
    
    [[self registerButton] setTitle:@"初始化密码" forState:UIControlStateNormal];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(_useNameCell.left, [self registerButton].bottom+20, self.view.width-2*_useNameCell.left, 120)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 6;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = @"提示：\n请您输入有效邮箱，我们会向该邮箱发送一封邮寄，请注意查收。\n\n如果您没有收到，可能您设置了屏蔽功能，请尝试更换邮箱或者解除邮箱拦截功能。";
    [self.view addSubview:label];
}

@end
