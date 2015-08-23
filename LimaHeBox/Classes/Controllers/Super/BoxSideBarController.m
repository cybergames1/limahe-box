//
//  BoxSideBarController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSideBarController.h"
#import "MainViewController.h"
#import "BlueToothViewController.h"
#import "ExpressViewController.h"
#import "TravelViewController.h"
#import "ShareViewController.h"
#import "FoundViewController.h"
#import "UserViewController.h"
#import "LoginViewController.h"
#import "AccountManager.h"

@interface BoxSideBarController () <CDRTranslucentSideBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _tabList;
}

@end

@implementation BoxSideBarController

- (void)dealloc {
    [_sideBar release];_sideBar = nil;
    [_tabList release];_tabList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *tabList_ = @[@"首页",@"蓝牙",@"行程预定",@"分享",@"快递",@"发现",@"我的"];
        _tabList = [tabList_ retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainViewController *main = [[MainViewController alloc] init];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:main];
    
    BlueToothViewController *bluetooth = [[BlueToothViewController alloc] init];
    UINavigationController *bluetoothNav = [[UINavigationController alloc] initWithRootViewController:bluetooth];
    
    TravelViewController *travel = [[TravelViewController alloc] init];
    UINavigationController *travelNav = [[UINavigationController alloc] initWithRootViewController:travel];
    
    ShareViewController *share = [[ShareViewController alloc] init];
    UINavigationController *shareNav = [[UINavigationController alloc] initWithRootViewController:share];
    
    ExpressViewController *express = [[ExpressViewController alloc] init];
    UINavigationController *expressNav = [[UINavigationController alloc] initWithRootViewController:express];
    
    FoundViewController *found = [[FoundViewController alloc] init];
    UINavigationController *foundNav = [[UINavigationController alloc] initWithRootViewController:found];
    
    UserViewController *user = [[UserViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:user];
    
    self.viewControllers = @[mainNav,bluetoothNav,travelNav,shareNav,expressNav,foundNav,userNav];
    [self.tabBar setHidden:YES];
    
    [self setBoxSideBar];
}

- (void)setBoxSideBar {
    CDRTranslucentSideBar *sideBar = [[[CDRTranslucentSideBar alloc] init] autorelease];
    sideBar.sideBarWidth = 200;
    sideBar.delegate = self;
    sideBar.tag = 0;
    self.sideBar = sideBar;
    
    // Create Content of SideBar
    UITableView *tableView = [[[UITableView alloc] init] autorelease];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.sideBar setContentViewInSideBar:tableView];
}

#pragma mark - CDRTranslucentSideBarDelegate
- (void)sideBar:(CDRTranslucentSideBar *)sideBar didAppear:(BOOL)animated
{
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willAppear:(BOOL)animated
{
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar didDisappear:(BOOL)animated
{
}

- (void)sideBar:(CDRTranslucentSideBar *)sideBar willDisappear:(BOOL)animated
{
}

#pragma mark -
#pragma mark UITableViewDataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tabList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _tabList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedIndex:indexPath.row];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 80)];
    view.backgroundColor = [UIColor clearColor];
    
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, view.width, 80)] autorelease];
    [button setTitle:[AccountManager isLogin] ? loginUser.userName : @"登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(isShowLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return [view autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

- (void)isShowLoginAction {
    [LoginViewController showLogin:self
                       finishBlock:nil
                      failureBlock:^
     {
         UserViewController *controller = [[UserViewController alloc] init];
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
         [self.navigationController presentViewController:nav animated:YES completion:nil];
         [controller release];
         [nav release];
     }];
    
}


@end
