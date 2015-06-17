//
//  MessageViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarAction {
    
}

@end
