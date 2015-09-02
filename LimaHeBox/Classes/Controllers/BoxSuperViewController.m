//
//  BoxSuperViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"
#import "MBProgressHUD.h"
#import "BadgeView.h"

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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = [UIColor colorWithRed:(248.0/255.0) green:(248.0/255.0) blue:(248.0/255.0) alpha:1.0];
    self.navigationController.navigationBar.barTintColor = _navigationBarTintColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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

- (BOOL)navigationShouldPopOnBackButton {
    //navigationBar自带返回按钮的点击事件
    return YES;
}

@end

@implementation BoxSuperViewController (BadgeNumber)

- (void)setShowBadgeView:(BOOL)isShow {
    UIView *customView = self.navigationItem.rightBarButtonItem.customView;
    
    BadgeView *badgeView = [[BadgeView alloc] init];
    badgeView.right = customView.width;
    badgeView.top = -10;
    [customView addSubview:badgeView];
    [badgeView release];
    
    [badgeView setBadgeNumber:3];
}

- (void)setBadgeNumber:(NSInteger)badgeNumber {
    for (UIView *view in self.navigationItem.rightBarButtonItem.customView.subviews) {
        if ([view isKindOfClass:[BadgeView class]]) {
            
        }
    }
}

@end

@implementation BoxSuperViewController (ShowHud)

- (void) showIndicatorHUDView:(NSString *)message
{
    [self showIndicatorHUDView:message toView:[CommonTools keyWindow]];
}

- (void) showIndicatorHUDView:(NSString*) message toView:(UIView*) view
{
    [self showIndicatorHUDView:message toView:view offset:CGPointZero];
}

- (void) showIndicatorHUDView:(NSString*) message toView:(UIView*) view offset:(CGPoint) offset
{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD* hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.xOffset = offset.x;
    hub.yOffset = offset.y;
    hub.removeFromSuperViewOnHide = YES;
    hub.labelText = message;
}

- (void) hideIndicatorHUDView
{
    [MBProgressHUD hideHUDForView:[CommonTools keyWindow] animated:NO];
}
- (void) hideIndicatorHUDViewWithDelay:(CGFloat)delay
{
    MBProgressHUD* hud = [MBProgressHUD HUDForView:[CommonTools keyWindow]];
    if (hud) {
        [hud hide:YES afterDelay:delay];
    }
}

- (void) hideAllHUDView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [MBProgressHUD hideAllHUDsForView:[CommonTools keyWindow] animated:NO];
    [MBProgressHUD hideAllHUDsForView:[CommonTools visibleWindow] animated:NO];
}

@end
