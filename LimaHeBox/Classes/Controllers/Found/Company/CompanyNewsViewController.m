//
//  CompanyNewsViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CompanyNewsViewController.h"
#import "NewsDataSource.h"

@interface CompanyNewsViewController ()
{
    UIWebView * _webView;
}

@end


@implementation CompanyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"详情"];
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    webView.height += 54;
    webView.scalesPageToFit = YES;
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:webView];
    _webView = webView;
    
    NewsDataSource *dataSource_ = [[NewsDataSource alloc] initWithDelegate:self];
    [dataSource_ getNewsInfoWithId:_newsId];
    self.dataSource = dataSource_;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    NSString *content = [[source.data objectForKey:@"data"] objectForKey:@"content"];
    [_webView loadHTMLString:content baseURL:nil];
    
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

@end
