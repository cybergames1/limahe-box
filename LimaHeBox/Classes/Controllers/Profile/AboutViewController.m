//
//  AboutViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"关于"];
    self.view.backgroundColor = UIColorRGB(248, 248, 248);
    
    UIImage *image = [UIImage imageNamed:@"pf_about"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, 64+45, image.size.width, image.size.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-40, self.view.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"2014 liemoch.com all right reserved";
    [self.view addSubview:label];
}
@end
