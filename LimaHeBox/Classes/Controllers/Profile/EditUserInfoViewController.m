//
//  EditUserInfoViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/9/21.
//  Copyright © 2015年 jianting. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "EditProfileManager.h"
#import "AccountManager.h"
#import <FTUIKit/FTInputView.h>

@interface EditUserInfoViewController () <UITextFieldDelegate,FTInputViewDelegate>
{
    UITextField*   _nickTextField;
    FTInputView*   _inputView;
}
@property (nonatomic, assign) ProfileEditOption option;
@property (nonatomic, retain) NSString* info;
@end

static NSInteger kMaxTextCount = 30;
@implementation EditUserInfoViewController

- (void)dealloc
{
    [_nickTextField release];
    [_inputView release];
    self.info = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}
- (instancetype) initWithOption:(ProfileEditOption) option
                    profileInfo:(NSString*) userInfo
{
    self = [super init];
    if (self) {
        _option = option;
        self.info = userInfo;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (ProfileEditOptionAge == self.option) {
        [self setNavigationTitle:@"年龄"];
    }else if (ProfileEditOptionDeviceId == self.option){
        [self setNavigationTitle:@"设备号"];
    }else if (ProfileEditOptionAddress == self.option){
        [self setNavigationTitle:@"常用地址"];
    }
    [self setNavigationItemRightTitle:@"保存"];
    self.rightBarButtonItem.enabled = NO;
    self.option = _option;
    if ([self.info length] > 0) {
        [self updateSaveButtonState:YES];
    }
    else{
        [self updateSaveButtonState:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void) setOption:(ProfileEditOption)option
{
    _option = option;
    if (ProfileEditOptionAge == _option || ProfileEditOptionDeviceId == _option) {
        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+15, KScreenWidth, 40)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        [backView release];
        
        _nickTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 64+25, KScreenWidth-20, 20)];
        _nickTextField.backgroundColor = [UIColor whiteColor];
        _nickTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nickTextField.returnKeyType = UIReturnKeyDone;
        _nickTextField.font = [UIFont systemFontOfSize:15];
        _nickTextField.delegate = self;
        _nickTextField.placeholder = (ProfileEditOptionAge == _option)?@"请输入年龄":@"请输入设备号";
        _nickTextField.text = self.info;
        [self.view addSubview:_nickTextField];
    }else if (ProfileEditOptionAddress == _option){
        UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+15, KScreenWidth, 90)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        [backView release];
        
        _inputView = [[FTInputView alloc] initWithFrame:CGRectMake(10.0f, 64+15, KScreenWidth-20, 90.0f) delegate:self];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.fontSize = 14.0f;
        _inputView.textColor = UIColorRGB(41, 41, 41);
        _inputView.placeholder = @"请输入常用详细地址";
        _inputView.countLimit = kMaxTextCount;
        _inputView.placeholderStyle = FTPlaceholderStyleTop;
        _inputView.returnKeyType = UIReturnKeyDone;
        _inputView.borderStyle = FTInputBorderStyleNone;
        _inputView.fitStyle = FTFitStyleNone;
        [self.view addSubview:_inputView];
    }else {
        //
    }
}

#pragma mark - update save button
- (void) updateSaveButtonState:(BOOL) enable
{
    if (enable) {
        self.rightBarButtonItem.enabled = YES;
    }
    else{
        self.rightBarButtonItem.enabled = NO;
    }
}

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = [notification object];
    if ([textField.text length] > 0) {
        [self updateSaveButtonState:YES];
    }
    else{
        [self updateSaveButtonState:NO];
    }
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
#pragma mark - FTInputViewDelegate
- (void) inputViewFrameChanged:(FTInputView*) inputView
{
    
}

- (void) inputViewDidTouchesDoneButton:(FTInputView*) inputView
{
    [inputView resignFirstResponder];
}

// did change
- (void) inputViewDidChange:(FTInputView*) inputView
{
    NSInteger textCount = [inputView.text length];
    if (textCount > 0) {
        [self updateSaveButtonState:YES];
    }
    else{
        [self updateSaveButtonState:NO];
    }
}

#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (void)leftBarAction
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction
{
    if (ProfileEditOptionAge == _option) {
        [_nickTextField resignFirstResponder];
        [EditProfileManager uploadUserAge:_nickTextField.text block:^(NSError *error,id info) {
            if (error) {
                [self showHUDWithText:[error localizedDescription]];
            }
            else{
                MUser* loginUser = [AccountManager sharedManager].loginUser;
                [loginUser updateUserValue:_nickTextField.text forKey:kUserInfoAgeKey];
                [self showHUDWithText:@"修改年龄成功！"];
                [self performSelector:@selector(leftBarButtonAction) withObject:nil afterDelay:2.0];
            }
        }];
    }else if (ProfileEditOptionDeviceId == _option) {
        [_nickTextField resignFirstResponder];
        [EditProfileManager uploadUserDevice:_nickTextField.text block:^(NSError *error,id info) {
            if (error) {
                [self showHUDWithText:[error localizedDescription]];
            }
            else{
                MUser* loginUser = [AccountManager sharedManager].loginUser;
                [loginUser updateUserValue:_nickTextField.text forKey:kUserInfoDeviceIdKey];
                [self showHUDWithText:@"修改设备成功！"];
                [self performSelector:@selector(leftBarButtonAction) withObject:nil afterDelay:2.0];
            }
        }];
    }else if (ProfileEditOptionAddress == _option){
        [_inputView resignFirstResponder];
        [EditProfileManager uploadUserAddress:_inputView.text block:^(NSError *error,id info) {
            if (error) {
                [self showHUDWithText:[error localizedDescription]];
            }
            else{
                MUser* loginUser = [AccountManager sharedManager].loginUser;
                [loginUser updateUserValue:_inputView.text forKey:kUserInfoIntroductionKey];
                [self showHUDWithText:@"修改常用地址成功！"];
                [self performSelector:@selector(leftBarButtonAction) withObject:nil afterDelay:2.0];
            }
        }];
    }else {
        //
    }
}

@end
