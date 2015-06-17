//
//  LRSuperViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LRSuperViewController.h"

#define FieldEdge_Rate 30.0/320.0

@interface LRSuperViewController ()
{
    UITextField * _textField1;
    UITextField * _textField2;
    UIButton * _actionButton;
}

@end

@implementation LRSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"登陆账号"];
    
    _textField1 = [[[UITextField alloc] initWithFrame:CGRectMake(FieldEdge_Rate*self.view.bounds.size.width, 120, (1-2*FieldEdge_Rate)*self.view.bounds.size.width, 30.0)] autorelease];
    _textField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField1.keyboardType = UIKeyboardTypeEmailAddress;
    _textField1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField1.borderStyle = UITextBorderStyleRoundedRect;
    _textField1.placeholder = @"请输入用户名";
    
    _textField2 = [[[UITextField alloc] initWithFrame:CGRectMake(_textField1.frame.origin.x, _textField1.frame.origin.y+_textField1.bounds.size.height+20, _textField1.bounds.size.width, _textField1.bounds.size.height)] autorelease];
    _textField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField2.clearsOnBeginEditing = YES;
    _textField2.secureTextEntry = YES;
    _textField2.borderStyle = UITextBorderStyleRoundedRect;
    _textField2.placeholder = @"请输入密码";
    
    _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionButton setFrame:CGRectMake(_textField1.frame.origin.x, _textField2.frame.origin.y+_textField2.frame.size.height+50, _textField2.bounds.size.width, _textField2.bounds.size.height)];
    [_actionButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    [_actionButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_textField1];
    [self.view addSubview:_textField2];
    [self.view addSubview:_actionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneAction {
    //子类实现
    NSLog(@"done");
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarAction {
    
}

@end
