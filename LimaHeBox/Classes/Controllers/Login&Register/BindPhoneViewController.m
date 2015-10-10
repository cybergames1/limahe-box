//
//  BindPhoneViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "LRDataSource.h"

@interface BindPhoneViewController ()
{
    RLCell * _phoneCell;
    RLCell * _codeCell;
    int _count;
}

@property (nonatomic, retain) NSTimer * getCodeTimer;

@end

@implementation BindPhoneViewController

- (void)dealloc {
    [_getCodeTimer release];_getCodeTimer = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"绑定手机号"];
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

- (void)startGetTimer {
    [self stopGetTimer];
    
    _count = 60;
    [self updateCount];
    
    self.getCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
}

- (void)stopGetTimer {
    if (_getCodeTimer) {
        [_getCodeTimer invalidate];
        self.getCodeTimer = nil;
    }
}

- (void)updateCount {
    UIButton *button = (UIButton *)[_codeCell rightView];
    
    if (_count <= 1) {
        [self stopGetTimer];
        [button setEnabled:YES];
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        return;
    }
    
    _count --;
    [button setEnabled:NO];
    [button setTitle:[NSString stringWithFormat:@"获取验证码(%d)",_count] forState:UIControlStateNormal];
}

- (void)getCodeAction:(UIButton *)sender {
    [self startGetTimer];
    
    LRDataSource *dataSource_ = [[[LRDataSource alloc] initWithDelegate:self] autorelease];
    [dataSource_ sendAuthCode:_phoneCell.textField.text];
    self.dataSource = dataSource_;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [super dataSourceFinishLoad:source];
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [super dataSource:source hasError:error];
}

@end

