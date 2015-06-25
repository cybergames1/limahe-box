//
//  ExpressResultViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/25.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ExpressResultViewController.h"

@interface ExpressResultViewController ()

@end

@implementation ExpressResultViewController

- (void)dealloc {
    [_comId release];_comId = nil;
    [_postId release];_postId = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //http://m.kuaidi100.com/index_all.html?type=yuantong&postid=200093247451
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@",_comId,_postId]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    UIWebView *webView = [[[UIWebView alloc] initWithFrame:self.view.bounds] autorelease];
    [webView loadRequest:requset];
    [self.view addSubview:webView];
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
