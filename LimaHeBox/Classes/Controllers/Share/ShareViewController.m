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
#import "ShareTool.h"

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
    
    VideoShareInputView * inputView = [[[VideoShareInputView alloc] initWithFrame:CGRectMake(0, 12+64, self.view.width, 130.0)] autorelease];
    [inputView applyBoardMasks:UIViewBorderMaskRoundrect borderWidth:1.0 borderColor:UIColorRGB(203, 203, 203) lineDashWidth:0 radius:0.0];
    [inputView insertContent:[[ShareTool sharedTools] shareText] atIndex:0];
    [self.view addSubview:inputView];
    _inputView = inputView;
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(inputView.left+10, inputView.bottom+10, self.view.width-inputView.left, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"您最多可输入140个汉字";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    RegisterButton * button = [RegisterButton showGreenInView:self.view top:label.bottom+50 title:@"发送" target:self action:@selector(shareAction)];
    [button setEnabled:YES];
    
    //清掉草稿箱
    [[ShareTool sharedTools] setShareText:nil];
}

- (void)shareAction {
    if ([[_inputView content] length] <= 0) {
        [self showHUDWithText:@"分享点内容吧"];
    }
}

/*
 * 询问是否要保存草稿箱
 */
- (BOOL)canDismiss {
    if ([CommonTools isEmptyString:_inputView.content]) {
        return YES;
    }else {
        [self showAlertView:@"是否保存草稿箱" alertTitle:nil cancleTitle:@"不保存" otherButtonTitle:@"保存" dismissBlock:^(NSString *buttonTitle) {
            if ([buttonTitle isEqualToString:@"保存"]) {
                [[ShareTool sharedTools] setShareText:_inputView.content];
            }
            [self dismissSelf];
        }];
        return NO;
    }
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leftBarAction {
    if ([self canDismiss]) [self dismissSelf];
}

@end
