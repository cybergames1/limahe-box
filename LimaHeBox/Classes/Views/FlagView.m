//
//  FlagView.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 15, 15);
        
        self.layer.cornerRadius = self.bounds.size.width/2;
        self.layer.masksToBounds = YES;
        
        self.selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.backgroundColor = selected ? [UIColor colorWithRed:(72.0/255.0) green:(217.0/255.0) blue:(192.0/255.0) alpha:1.0] :[UIColor grayColor];
}
@end
