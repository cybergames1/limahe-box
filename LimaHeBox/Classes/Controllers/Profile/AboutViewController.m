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
    
//    UIImage *image = [UIImage imageNamed:@"pf_about"];
//    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, 64+45, image.size.width, image.size.height)] autorelease];
//    imageView.image = image;
//    [self.view addSubview:imageView];
    
    UIImage *image = [UIImage imageNamed:@"pf_logo1"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-123/2, 64+45, 123, 123)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    //产品名称和版本
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 64+5+180, self.view.width, 45)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 2;
    label.text = @"利马赫智能旅行箱\nV1.2";
    [self.view addSubview:label];
    
    //产品宣言
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom+17, self.view.width, 30)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"您的随身安全管家";
    [self.view addSubview:label];
    
    //公司网站
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom+12, self.view.width, 45)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 2;
    label.text = @"公司网站:\nwww.liemoch.com";
    [self.view addSubview:label];
    
    //版权
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-40, self.view.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"2014 liemoch.com all right reserved";
    [self.view addSubview:label];
}
@end
