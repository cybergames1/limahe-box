//
//  TravelViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/16.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TravelViewController.h"

@interface TravelViewController ()

@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"行程预定"];
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Qunar" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://touch.qunar.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
