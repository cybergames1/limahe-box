//
//  CompanyViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CompanyViewController.h"

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"公司介绍"];
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.liemoch.com/mobile/article_cat.php?id=11"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]];
    
    return;
}


@end
