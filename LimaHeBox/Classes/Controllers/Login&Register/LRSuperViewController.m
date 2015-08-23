//
//  LRSuperViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "LRSuperViewController.h"

#define FieldEdge_Rate (30.0/320.0)
#define Height_Rate (40.0/260.0)

@interface LRSuperViewController ()
{
    RLCell * _textCell1;
    RLCell * _textCell2;
}

@end

@implementation LRSuperViewController

- (void)dealloc {
    [_dataSource setDelegate:nil];
    [_dataSource release];_dataSource = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    UIImageView *backgroundImageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    backgroundImageView.image = [UIImage imageNamed:@"lr_bg"];
    [self.view addSubview:backgroundImageView];
    
    CGFloat width = (1-2*FieldEdge_Rate)*self.view.width;
    _textCell1 = [[[RLCell alloc] initWithFrame:CGRectMake(FieldEdge_Rate*self.view.width, 120, width, width*Height_Rate)] autorelease];
    _textCell1.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textCell1.textField.keyboardType = UIKeyboardTypeEmailAddress;
    _textCell1.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _textCell2 = [[[RLCell alloc] initWithFrame:CGRectMake(_textCell1.left, _textCell1.bottom+20, _textCell1.width, _textCell1.height)] autorelease];
    _textCell2.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textCell2.textField.clearsOnBeginEditing = YES;
    _textCell2.textField.secureTextEntry = YES;
    
    [RegisterButton showGreenInView:self.view top:_textCell2.bottom+50 title:@"" target:self action:@selector(doneAction)];
    
    [self.view addSubview:_textCell1];
    [self.view addSubview:_textCell2];
    
    UIImage *image = [UIImage imageNamed:@"lr_change"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, self.view.height-20-image.size.height, image.size.width, image.size.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    [tap release];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (RLCell *)topCell {
    return _textCell1;
}

- (RLCell *)bottomCell {
    return _textCell2;
}

- (RegisterButton *)registerButton {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[RegisterButton class]]) {
            return (RegisterButton *)view;
        }
    }
    return nil;
}

- (void)tapAction {
    [self allTextFieldResignFirstResponder];
}

- (NSArray *)allTextField {
    NSMutableArray *textFields = [NSMutableArray arrayWithCapacity:0];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [textFields addObject:view];
        }else if ([view isKindOfClass:[RLCell class]]) {
            [textFields addObject:[(RLCell *)view textField]];
        }else {
            //
        }
    }
    return textFields;
}

- (void)allTextFieldResignFirstResponder {
    for (UITextField *textField in [self allTextField]) {
        [textField resignFirstResponder];
    }
}

#pragma mark -
#pragma mark UITextField Notification

- (void)textFieldDidChange:(NSNotification *)notification {
    /*
     * 有一个textField没有内容，则RegisterButton为Disable
     * 所有的textField都有内容，则RegisterButton为enable
     */
    BOOL allTextFieldHasText = NO;
    for (UITextField *textField in [self allTextField]) {
        allTextFieldHasText = (textField.text.length <= 0) ? NO : YES;
    }
    
    [[self registerButton] setEnabled:allTextFieldHasText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneAction {
    //子类实现
    [self allTextFieldResignFirstResponder];
    NSLog(@"done");
}

- (void)leftBarAction {
    
}

- (void)rightBarAction {
    
}

#pragma mark -
#pragma mark PPQDataLoader Delegate

/*
 * 从服务器读取数据成功或失败后需要删除所有HUD
 * 子类需要继承该方法
 */
- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    [self hideAllHUDView];
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [self hideAllHUDView];
    [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
}

@end
