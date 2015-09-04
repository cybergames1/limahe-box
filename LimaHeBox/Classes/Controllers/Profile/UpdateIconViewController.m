//
//  UpdateIconViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "UpdateIconViewController.h"
#import "HeaderView.h"
#import "RegisterButton.h"
#import "AccountManager.h"

#define Basic_Tag 1231
#define Left_Rate (25.0/268.0) //图片区离屏幕边的距离
#define Edge_H_Rate (30.0/268.0) //图片之间左右的距离
#define Edge_V_Rate (10.0/480.0) //图片之间上下的距离

@interface UpdateIconViewController ()
{
    NSInteger _selectedIndex;
}

@end

@implementation UpdateIconViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        MUser *loginUser = [[AccountManager sharedManager] loginUser];
        NSString *userIcon = [loginUser.userIcon substringWithRange:NSMakeRange(loginUser.userIcon.length-8, 1)];
        _selectedIndex = [userIcon integerValue]-1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"头像选择"];
    self.view.backgroundColor = UIColorRGB(248, 248, 248);
    
    CGFloat left = Left_Rate*self.view.width;
    CGFloat edgeH = Edge_H_Rate*self.view.width;
    CGFloat edgeV = Edge_V_Rate*self.view.width;
    
    for (int i = 0;i < 9;i++) {
        int x = i/3; //行
        int y = i%3; //列
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pf_logo%d",i+1]];
        HeaderView *header = [[HeaderView alloc] initWithFrame:CGRectMake(left+(image.size.width+edgeH)*y, 64+left+(image.size.height+35+edgeV)*x, image.size.width, image.size.height+35)];
        header.headerImage = image;
        header.tag = Basic_Tag+i;
        [header addTarget:self action:@selector(changeIconAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:header];
        [header release];
    }
    
    [(HeaderView *)[self.view viewWithTag:Basic_Tag+_selectedIndex] setSelected:YES];
    
    RegisterButton *buton = [RegisterButton showGreenInView:self.view frame:CGRectMake(left, self.view.height-70-44, self.view.width-2*left, 44) title:@"确定" target:self action:@selector(doneAction)];
    [buton setEnabled:YES];
}

- (void)changeIconAction:(HeaderView *)sender {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[HeaderView class]]) {
            [(HeaderView *)v setSelected:NO];
        }
    }
    [sender setSelected:YES];
    _selectedIndex = sender.tag-Basic_Tag;
}

- (void)doneAction {
    MUser *loginUser = [[AccountManager sharedManager] loginUser];
    [loginUser updateUserValue:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"pf_logo%ld@2x",(long)_selectedIndex+1] ofType:@"png"] forKey:kUserInfoIconKey];
    [self leftBarAction];
}

@end
