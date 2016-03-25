//
//  StroreViewController.m
//  LimaHeBox
//
//  Created by jianting on 16/3/25.
//  Copyright © 2016年 jianting. All rights reserved.
//

#import "StroreViewController.h"

@interface StroreViewController () <UIWebViewDelegate>
{
    UIActivityIndicatorView * _indicatorView;
}

@end

@implementation StroreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"商城"];
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    webView.scalesPageToFit = YES;
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.liemoch.com/mobile"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0]];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = self.view.center;
    _indicatorView.frame = CGRectMake(0, 0, 20, 20);
    _indicatorView.hidesWhenStopped = YES;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_indicatorView stopAnimating];
}
@end
