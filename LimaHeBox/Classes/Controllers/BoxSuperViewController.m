//
//  BoxSuperViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import "CommonTools.h"

@interface BoxSuperViewController ()

@end

@implementation BoxSuperViewController

- (void)dealloc {
    [_navigationBarTintColor release];_navigationBarTintColor = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationBarTintColor = [UIColor colorWithRed:(3.0/255.0) green:(104.0/255.0) blue:(183.0/255.0) alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = _navigationBarTintColor;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self setNavigationItemRightImage:[UIImage imageNamed:@"main_nav_right"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SetNavigationItem

- (void)setNavigationItemLeftImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(leftBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    [self.navigationItem setLeftBarButtonItem:item animated:YES];
}

- (void)setNavigationItemRightImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(rightBarAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}

- (void)setNavigationTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = title;
    [label sizeToFit];
    [label release];
    
    [self setNavigationBackTitle:title];
}

- (void)setNavigationImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.navigationItem.titleView = imageView;
    [imageView release];
    
    [self setNavigationBackTitle:@""];
}

- (void)setNavigationBackTitle:(NSString *)title {
    UIBarButtonItem *backItem = [[[UIBarButtonItem alloc] init] autorelease];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)leftBarAction {
    //子类实现
}

- (void)rightBarAction {
    //子类实现
}


@end
