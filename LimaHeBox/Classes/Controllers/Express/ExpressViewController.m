//
//  ExpressViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ExpressViewController.h"
#import "ExpressQueryViewController.h"

@interface ExpressViewController ()

@end

@implementation ExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"main_nav_left"]];
    [self setNavigationTitle:@"快递"];
    
    //把两按钮放到一个模块view里，方便适配
    UIView *moduleView = [[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-260/2, self.view.frame.size.height/2-180/2, 260, 180)] autorelease];
    moduleView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:moduleView];
    
    //查询按钮
    UIButton *queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [queryButton setBackgroundColor:[UIColor colorWithRed:(72.0/255.0) green:(217.0/255.0) blue:(192.0/255.0) alpha:1.0]];
    [queryButton setFrame:CGRectMake(0, 0, moduleView.bounds.size.width, 60)];
    [queryButton setTitle:@"快递查询" forState:UIControlStateNormal];
    [queryButton addTarget:self action:@selector(expressQuery) forControlEvents:UIControlEventTouchUpInside];
    [queryButton.layer setCornerRadius:queryButton.bounds.size.height/2];
    [queryButton.layer setMasksToBounds:YES];
    
    //寄送按钮
    UIButton *deliveryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deliveryButton setBackgroundColor:[UIColor colorWithRed:(241.0/255.0) green:(209.0/255.0) blue:(64.0/255.0) alpha:1.0]];
    [deliveryButton setFrame:CGRectMake(0, moduleView.bounds.size.height-60, moduleView.bounds.size.width, 60)];
    [deliveryButton setTitle:@"寄快递" forState:UIControlStateNormal];
    [deliveryButton addTarget:self action:@selector(expressDelivery) forControlEvents:UIControlEventTouchUpInside];
    [deliveryButton.layer setCornerRadius:deliveryButton.bounds.size.height/2];
    [deliveryButton.layer setMasksToBounds:YES];
    
    [moduleView addSubview:queryButton];
    [moduleView addSubview:deliveryButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)expressQuery {
    ExpressQueryViewController *controller = [[ExpressQueryViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)expressDelivery {
    
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarAction {

}

@end
