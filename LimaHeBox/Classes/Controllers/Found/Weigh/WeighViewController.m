//
//  WeighViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeighViewController.h"

@implementation WeighViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"称重"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UIImage *image = [UIImage imageNamed:@"f_weigh"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, 64, image.size.width, image.size.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
}
@end
