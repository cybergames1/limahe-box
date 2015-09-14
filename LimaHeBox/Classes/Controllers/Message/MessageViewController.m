//
//  MessageViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"消息"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)rightBarAction {
    
}

@end
