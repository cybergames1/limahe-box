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
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"bg-addbutton"]];
    [self setNavigationItemRightImage:[UIImage imageNamed:@"icon-plus-highlighted"]];
    [self setNavigationTitle:@"快递"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarAction {
    ExpressQueryViewController *controller = [[ExpressQueryViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end
