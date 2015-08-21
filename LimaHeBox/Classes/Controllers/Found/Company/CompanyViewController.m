//
//  CompanyViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CompanyViewController.h"
#import "NewsDataSource.h"
#import "CompanyNewsListViewController.h"

@interface CompanyViewController ()
{
    UITextView * _textView;
}

@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"公司介绍"];
    
    UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height-54-100)] autorelease];
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    _textView = textView;
    
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height-44, self.view.width/2, 44)] autorelease];
    [button setTitle:@"产品展示" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorRGB(248, 248, 248)];
    [button addTarget:self action:@selector(showProductListAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [[[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2, self.view.height-44, self.view.width/2, 44)] autorelease];
    [button setTitle:@"公司动态" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setBackgroundColor:UIColorRGB(248, 248, 248)];
    [button addTarget:self action:@selector(showCompanyNewsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView *line = [[[UIView alloc] initWithFrame:CGRectMake(self.view.width/2, button.top, 1, button.height)] autorelease];
    line.backgroundColor = UIColorRGB(229, 229, 229);
    [self.view addSubview:line];
    
    NewsDataSource *dataSource_ = [[NewsDataSource alloc] initWithDelegate:self];
    [dataSource_ getNewsInfoWithId:[NSString stringWithFormat:@"%d",20]];
    self.dataSource = dataSource_;
}

- (void)showProductListAction {
    
}

- (void)showCompanyNewsAction {
    CompanyNewsListViewController *controller = [[CompanyNewsListViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    NSString *content = [[source.data objectForKey:@"data"] objectForKey:@"content"];
    _textView.text = content;
    
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

@end
