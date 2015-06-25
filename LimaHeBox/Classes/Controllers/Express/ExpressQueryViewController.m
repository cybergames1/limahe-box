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
    UITextField * _ticketField;
    UILabel * _comLabel;
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
    self.view.backgroundColor = [UIColor redColor];
    [self setNavigationTitle:@"快递查询"];
    
    _ticketField = [[[UITextField alloc] initWithFrame:CGRectMake(FieldEdge_Rate*self.view.bounds.size.width, 120, (1-2*FieldEdge_Rate)*self.view.bounds.size.width, 30.0)] autorelease];
    _ticketField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _ticketField.keyboardType = UIKeyboardTypeEmailAddress;
    _ticketField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _ticketField.borderStyle = UITextBorderStyleRoundedRect;
    _ticketField.placeholder = @"请输入快递单号";
    
    _comLabel = [[[UILabel alloc] initWithFrame:CGRectMake(_ticketField.frame.origin.x, _ticketField.frame.origin.y+_ticketField.bounds.size.height+20, _ticketField.bounds.size.width, _ticketField.bounds.size.height)] autorelease];
    _comLabel.text = @"请选择快递公司";
    
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [queryButton setFrame:CGRectMake(_comLabel.frame.origin.x, _comLabel.frame.origin.y+_comLabel.frame.size.height+50, _comLabel.bounds.size.width, _comLabel.bounds.size.height)];
    [queryButton addTarget:self action:@selector(queryAction) forControlEvents:UIControlEventTouchUpInside];
    [queryButton setTitle:@"查询" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_ticketField];
    [self.view addSubview:_comLabel];
    [self.view addSubview:queryButton];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comTapAction:)];
    [self.view addGestureRecognizer:tapRecognizer];
    [tapRecognizer release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)comTapAction:(UIGestureRecognizer *)recognizer {
    [_ticketField resignFirstResponder];
    
    if (CGRectContainsPoint(_comLabel.frame, [recognizer locationInView:self.view])) {
        ExpressListViewController *controller = [[ExpressListViewController alloc] init];
        controller.handleBlock = ^(ExpressModel *expressModel) {
            _comLabel.text = expressModel.expressName;
            self.expressModel = expressModel;
        };
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}

- (void)queryAction {
    ExpressResultViewController *controller = [[ExpressResultViewController alloc] init];
    controller.comId = _expressModel.expressId;
    controller.postId = _ticketField.text;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
