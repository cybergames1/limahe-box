//
//  GuideViewController.m
//  LimaHeBox
//
//  Created by jianting on 16/3/12.
//  Copyright © 2016年 jianting. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()
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
        [delegate.window addSubview:controller.view];
        [delegate.window.rootViewController addChildViewController:controller];
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
    [self.view addSubview:_scrollView];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    imageView.image = [UIImage imageNamed:@"common_guide_0"];
    [_scrollView addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (int i = 1; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.left = i*self.view.width;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_guide_%d",i]];
        [_scrollView addSubview:imageView];
        [imageView release];
    }
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setFrame:CGRectMake(self.view.width/2-150/2+3*self.view.width, self.view.bottom-140, 150, 44)];
    [nextButton.layer setBorderWidth:1];
    [nextButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [nextButton addTarget:self action:@selector(goMainView) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nextButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goMainView {
    if (_completionHanle) {
        _completionHanle();
    }
    [_completionHanle release];
    _completionHanle = nil;
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
