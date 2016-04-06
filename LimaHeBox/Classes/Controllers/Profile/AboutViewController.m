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
    [self setNavigationTitle:@"版本信息"];
    self.view.backgroundColor = UIColorRGB(248, 248, 248);
    
    UIImage *image = [UIImage imageNamed:@"pf_about_log"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, 64+45, image.size.width, image.size.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //产品名称和版本
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 64+180, self.view.width, 45)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"利马赫世界随我转";
    [self.view addSubview:label];
    
    //版权
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-40, self.view.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"2014 liemoch.com all right reserved";
    [self.view addSubview:label];
    
    //产品名称和版本
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, label.top-45, self.view.width, 45)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 2;
    label.text = @"利马赫智能旅行箱V1.4";
    [self.view addSubview:label];
}
@end
