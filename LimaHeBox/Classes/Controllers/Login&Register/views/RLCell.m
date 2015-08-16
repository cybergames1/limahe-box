//
//  RLCell.m
//  Papaqi
//
//  Created by jianting on 15/8/9.
//  Copyright (c) 2015年 PPQ. All rights reserved.
//

#import "RLCell.h"
#import <Category/Category.h>

@interface RLCell ()
{
    UIView * _lineView;
}

@end

@implementation RLCell

- (void)dealloc {
    [_titleLabel release];_titleLabel = nil;
    [_textField release];_textField = nil;
    [_rightView release];_rightView = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.height/2.0;
        self.layer.masksToBounds = YES;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, frame.size.height)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:(69.0/255.0) green:(69.0/255.0) blue:(76.0/255.0) alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, frame.size.width-10-CGRectGetMaxX(_titleLabel.frame), frame.size.height)];
        _textField.font = _titleLabel.font;
        _textField.keyboardType = UIKeyboardTypeEmailAddress;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_textField];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.width = _titleLabel.text ? 60 : 0;
    _textField.left = _titleLabel.right;
    _textField.width = self.width-_titleLabel.right-_rightView.width;
}

- (void)setRightView:(UIView *)rightView {
    if (_rightView != rightView) {
        [_rightView removeFromSuperview];
        [_rightView release];
        _rightView = [rightView retain];
        
        _rightView.frame = CGRectMake(self.width-rightView.width, rightView.top, rightView.width, rightView.height);
        [self addSubview:_rightView];
        [self setNeedsLayout];
    }
}

@end
