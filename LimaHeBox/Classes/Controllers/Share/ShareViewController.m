//
//  ShareViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ShareViewController.h"
#import "VideoShareInputView.h"
#import "RegisterButton.h"

@interface ShareViewController ()
{
    VideoShareInputView * _inputView;
}

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"分享"];
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    
    VideoShareInputView * inputView = [[[VideoShareInputView alloc] initWithFrame:CGRectMake(0, 12, self.view.width, 90.0)] autorelease];
    [inputView applyBoardMasks:UIViewBorderMaskRoundrect borderWidth:1.0 borderColor:UIColorRGB(203, 203, 203) lineDashWidth:0 radius:0.0];
    [self.view addSubview:inputView];
    _inputView = inputView;
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(inputView.left, inputView.bottom, self.view.width-inputView.left, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"您最多可输入140个汉字";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    RegisterButton * button = [RegisterButton showGreenInView:self.view top:label.bottom+50 title:@"发送" target:self action:@selector(shareAction)];
    [button setEnabled:YES];
}

- (void)shareAction {
    
}

- (void)leftBarAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
