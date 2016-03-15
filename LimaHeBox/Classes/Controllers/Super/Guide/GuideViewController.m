//
//  GuideViewController.m
//  LimaHeBox
//
//  Created by jianting on 16/3/12.
//  Copyright © 2016年 jianting. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController () <UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    void(^_completionHanle)(void);
}

@end

@implementation GuideViewController

+ (BOOL)showGudieViewControllerWithCompletionHandle:(void (^)(void))completionHandle {
    BOOL notShowGuide = [[NSUserDefaults standardUserDefaults] boolForKey:@"Not_Need_ShowGuide"];
    if (notShowGuide) {
        if (completionHandle) completionHandle();
    }else {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        GuideViewController *controller = [[GuideViewController alloc] initWithCompletionHandle:completionHandle];
        delegate.window.rootViewController = controller;
        [delegate.window makeKeyAndVisible];
        [controller release];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Not_Need_ShowGuide"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return notShowGuide;
}

- (instancetype)initWithCompletionHandle:(void (^)(void))completionHandle {
    self = [super init];
    if (self) {
        if (completionHandle) {
            _completionHanle = [completionHandle copy];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _scrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(4*self.view.frame.size.width,_scrollView.frame.size.height);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    imageView.image = [UIImage imageNamed:@"common_guide_0.jpg"];
    [_scrollView addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (int i = 1; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.left = i*self.view.width;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_guide_%d.jpg",i]];
        [_scrollView addSubview:imageView];
        [imageView release];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)getPageInFilterScrollView:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.bounds.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    return page;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.width) {
        [self goMainView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > scrollView.contentSize.width-scrollView.width) {
        [self goMainView];
    }
}

- (void)goMainView {
    if (_completionHanle) {
        _completionHanle();
    }
    [_completionHanle release];
    _completionHanle = nil;
}

@end
