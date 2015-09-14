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
    UITextView * _textView;
}

@end


@implementation CompanyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"详情"];
    
    UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height-54-100)] autorelease];
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    _textView = textView;
    
    NewsDataSource *dataSource_ = [[NewsDataSource alloc] initWithDelegate:self];
    [dataSource_ getNewsInfoWithId:_newsId];
    self.dataSource = dataSource_;
}

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    NSString *content = [[source.data objectForKey:@"data"] objectForKey:@"content"];
    _textView.text = content;
    
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    
}

@end
