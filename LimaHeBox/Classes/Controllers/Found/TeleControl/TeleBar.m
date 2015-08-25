//
//  TeleBar.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TeleBar.h"

#define Left_Rate (16.0/320.0)
#define Edge_Rate (16.0/320.0)
#define Basic_Tag 1233

@implementation TeleBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *imageList = @[[UIImage imageNamed:@"f_sound"],[UIImage imageNamed:@"f_flag"],
                               [UIImage imageNamed:@"f_back"],[UIImage imageNamed:@"f_switch"]];
        CGFloat left = (frame.size.width-[imageList count]*[(UIImage *)imageList[0] size].width)/([imageList count]+1);
        for (int i = 0;i < [imageList count];i++) {
            UIImage *image = imageList[i];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(left+(image.size.width+left)*i, 0, image.size.width, image.size.height)];
            [button setImage:image forState:UIControlStateNormal];
            [button setTag:Basic_Tag+i];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button release];
        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(bar:didActionAtIndex:)]) {
        [_delegate bar:self didActionAtIndex:sender.tag-Basic_Tag];
    }
}

@end
