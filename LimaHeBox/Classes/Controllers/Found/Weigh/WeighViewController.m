//
//  WeighViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeighViewController.h"
#import "DeviceManager.h"

@implementation WeighViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"称重"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UIImage *image = [UIImage imageNamed:@"f_weigh"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 64+100, self.view.width-40, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(131.0/255.0) green:(229.0/255.0) blue:(210.0/255.0) alpha:1.0];
    label.font = [UIFont systemFontOfSize:60];
    label.text = [NSString stringWithFormat:@"%.1f",[[[DeviceManager sharedManager] currentDevice] weight]];
    [self.view addSubview:label];
}

@end
