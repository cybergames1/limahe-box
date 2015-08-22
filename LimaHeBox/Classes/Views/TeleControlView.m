//
//  TeleControlView.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TeleControlView.h"

#define Basic_Tag 3213

@implementation TeleControlView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /** OK **/
        UIImage *okImage = [UIImage imageNamed:@"f_ok"];
        NSLog(@"imagesize:%@",NSStringFromCGSize(okImage.size));
        UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2-okImage.size.width/2, frame.size.height/2-okImage.size.height/2, okImage.size.width, okImage.size.height)] autorelease];
        [button setImage:okImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:Basic_Tag+1];
        [self addSubview:button];
        
        okImage = [UIImage imageNamed:@"f_top"];
        button = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2-okImage.size.width/2, 0, okImage.size.width, okImage.size.height)] autorelease];
        [button setImage:okImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:Basic_Tag+2];
        [self addSubview:button];
        
        okImage = [UIImage imageNamed:@"f_left"];
        button = [[[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height/2-okImage.size.height/2, okImage.size.width, okImage.size.height)] autorelease];
        [button setImage:okImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:Basic_Tag+3];
        [self addSubview:button];
        
        okImage = [UIImage imageNamed:@"f_bottom"];
        button = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2-okImage.size.width/2, frame.size.height-okImage.size.height, okImage.size.width, okImage.size.height)] autorelease];
        [button setImage:okImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:Basic_Tag+4];
        [self addSubview:button];
        
        okImage = [UIImage imageNamed:@"f_right"];
        button = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-okImage.size.width, frame.size.height/2-okImage.size.height/2, okImage.size.width, okImage.size.height)] autorelease];
        [button setImage:okImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:Basic_Tag+5];
        [self addSubview:button];
    }
    return self;
}

- (void)controlAction:(UIButton *)sender {
    _control = sender.tag-Basic_Tag;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
