//
//  ExpressQueryViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ExpressQueryViewController.h"
#import "ExpressListViewController.h"
#import "ExpressResultViewController.h"

#define FieldEdge_Rate 30.0/320.0

@interface ExpressQueryViewController ()
{
    RLCell * _ticketCell;
    RLCell * _comCell;
}

/* 选择了相应的快递公司后生成临时的expressModel用于查询 */
@property (nonatomic, retain) ExpressModel * expressModel;

@end

@implementation ExpressQueryViewController

- (void)dealloc {
    [_expressModel release];_expressModel = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"快递查询"];
    
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.kuaidi100.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]];
    
//    _ticketCell = [self topCell];
//    _ticketCell.textField.placeholder = @"请输入快递单号";
//    
//    _comCell = [self bottomCell];
//    _comCell.textField.placeholder = @"请选择快递公司";
//    _comCell.textField.secureTextEntry = NO;
//    [_comCell addTarget:self action:@selector(comTapAction)];
//    
//    RegisterButton *loginButton = [self registerButton];
//    [loginButton setTitle:@"查询" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)comTapAction {
    [self allTextFieldResignFirstResponder];

    ExpressListViewController *controller = [[ExpressListViewController alloc] init];
    controller.handleBlock = ^(ExpressModel *expressModel) {
        _comCell.textField.text = expressModel.expressName;
        self.expressModel = expressModel;
    };
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)doneAction {
    ExpressResultViewController *controller = [[ExpressResultViewController alloc] init];
    controller.comId = _expressModel.expressId;
    controller.postId = _ticketCell.textField.text;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
