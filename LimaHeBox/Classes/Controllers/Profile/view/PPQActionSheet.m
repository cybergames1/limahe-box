//
//  PPQActionSheet.m
//  PaPaQi
//
//  Created by Sean on 15/8/10.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import "PPQActionSheet.h"
#import <Category/Category.h>

@interface PPQActionSheet ()
{
    UIView * _backView;
}

@end

@implementation PPQActionSheet

- (void)dealloc
{
    [_contentView release];
    _contentView   =   nil;
    
    [super dealloc];
}
- (id)init
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        //self.hidden = YES;        
        _backView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.alpha = 0.0;
        [self addSubview:_backView];
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    UIView *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 260)] autorelease];
    [self addSubview:contentView];
    self.contentView = contentView;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    _contentView.top = view.bottom;
    
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 0.6;
        _contentView.top -= _contentView.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex
                             animated:(BOOL)animated
                          finishBlock:(void (^)(void)) finish
{
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 0.0;
        _contentView.top += _contentView.height;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (finish) {
            finish();
        }
    }];
}

@end
