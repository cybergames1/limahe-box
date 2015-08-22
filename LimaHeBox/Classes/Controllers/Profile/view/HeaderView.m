//
//  HeaderView.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "HeaderView.h"
#import "FlagView.h"

@interface HeaderView ()
{
    UIImageView * _headerImageView;
    FlagView * _flagView;
}

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _headerImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)] autorelease];
        _flagView = [[[FlagView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)] autorelease];
        _flagView.center = CGPointMake(frame.size.width/2, CGRectGetMaxY(_headerImageView.frame)+15);
        
        [self addSubview:_headerImageView];
        [self addSubview:_flagView];
        
        [self setSelected:NO];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _headerImageView.image = _headerImage;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    _flagView.selected = selected;
}

@end
