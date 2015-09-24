//
//  RadarView.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "RadarView.h"
#import "RegisterButton.h"
#import "FlagView.h"
#import <Category/Category.h>

@interface RadarView ()
{
    RaceView * _raceView;
    NSInteger _tapCount;
}

@end

@implementation RadarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        RaceView *raceView = [[[RaceView alloc] initWithFrame:CGRectMake(frame.size.width/2-frame.size.width/4, frame.size.height/2-frame.size.width/4, frame.size.width/2, frame.size.width/2)] autorelease];
        [self addSubview:raceView];
        _raceView = raceView;
        
        _tapCount = RadarStateSearchFailure;
        self.state = _tapCount;
    }
    return self;
}

- (void)removeAllSubViews {
    /*
     * 清掉除环以外的所有子view
     */
    for (UIView *v in self.subviews) {
        if (![v isKindOfClass:[RaceView class]]) {
            [v removeFromSuperview];
        }
    }
}

- (void)setSearchFailureView {
    CGFloat width = 4*_raceView.width/3;
    [RegisterButton showBlueInView:self frame:CGRectMake(self.width/2-width/2, self.height/2-22, width, 44) title:@"未检测到箱子" target:nil action:NULL];
}

- (void)setWarningView {
    FlagView *flagView = [[[FlagView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)] autorelease];
    [flagView setCenter:CGPointMake(self.width/2, self.height/2)];
    [flagView setSelected:YES];
    [self addSubview:flagView];
}

- (void)setState:(RadarState)state {
    if (_state != state) {
        _state = state;
        
        [self removeAllSubViews];
        if (state == RadarStateSearchFailure) {
            [self setSearchFailureView];
        }else if (state == RadarStateWarning) {
            [self setWarningView];
        }else {
            //
        }
        
        //测试
        for (UIView *v in self.superview.subviews) {
            if ([v isKindOfClass:[RadarLabel class]]) {
                [(RadarLabel *)v setState:state];
            }
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (_tapCount == RadarStateSearchFailure) {
//        _tapCount = RadarStateMatchSuccess;
//    }else if (_tapCount == RadarStateMatchSuccess) {
//        _tapCount = RadarStateWarning;
//    }else if (_tapCount == RadarStateWarning) {
//        _tapCount = RadarStateSearchFailure;
//    }else {
//        //
//    }
//    self.state = _tapCount;
}

@end

//---------------------------------------
/////////////////////////////////////////

@implementation RadarLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 220)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 14;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.text = @"蓝牙功能未开启，请进入设置->蓝牙，打开蓝牙功能\n\n使用说明：\n\n1.初次配对手机和箱子\n请打开箱子的蓝牙开关，长按功能键4秒以上，\n指示灯会闪烁\n\n请进入手机的设置->蓝牙，打开蓝牙功能，\n手机会自动搜索设备并且配对\n\n2.当您成功配对手机和箱子后\n以后您只要同时开启手机和箱子的蓝牙功能，\n即可自动配对成功";
        [self addSubview:label];
        _noticeLabel = label;
    }
    return self;
}

- (void)removeAllSubViews {
    for (UIView *v in self.subviews) {
        if (v != _noticeLabel) {
            [v removeFromSuperview];
        }
    }
    _noticeLabel.hidden = YES;
}

- (void)setMatchSuccessView {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"配对成功，正在为您的箱子保驾护航";
    [self addSubview:label];
}

- (void)setWarningView {
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    label.text = @"注意！\nBE CAREFUL";
    [self addSubview:label];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom+10, self.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.text = @"您的箱子和您距离过远，请妥善保管";
    [self addSubview:label];
    
    [RegisterButton showWhiteInView:self frame:CGRectMake(label.left, label.bottom+50, label.width, 44) title:@"解除警报" target:nil action:NULL];
}


- (void)setState:(RadarState)state {
    if (_state != state) {
        _state = state;
        
        [self removeAllSubViews];
        if (state == RadarStateMatchSuccess) {
            [self setMatchSuccessView];
        }else if (state == RadarStateWarning) {
            [self setWarningView];
        }else {
            _noticeLabel.hidden = NO;
        }
    }
}

@end

//////////////////////////////////////////
//---------------------------------------
//////////////////////////////////////////

@implementation RaceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view1 = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        view1.backgroundColor = [UIColor clearColor];
        view1.layer.cornerRadius = view1.frame.size.width/2;
        view1.layer.masksToBounds = YES;
        view1.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.3].CGColor;
        view1.layer.borderWidth = 2;
        
        UIView *view2 = [[[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2-frame.size.width/3, frame.size.height/2-frame.size.height/3, 2*frame.size.width/3, 2*frame.size.height/3)] autorelease];
        view2.backgroundColor = [UIColor clearColor];
        view2.layer.cornerRadius = view2.frame.size.width/2;
        view2.layer.masksToBounds = YES;
        view2.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.4].CGColor;
        view2.layer.borderWidth = 2;
        
        UIView *view3 = [[[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2-frame.size.width/6, frame.size.height/2-frame.size.height/6, frame.size.width/3, frame.size.height/3)] autorelease];
        view3.backgroundColor = [UIColor clearColor];
        view3.layer.cornerRadius = view3.frame.size.width/2;
        view3.layer.masksToBounds = YES;
        view3.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
        view3.layer.borderWidth = 2;
        
        [self addSubview:view1];
        [self addSubview:view2];
        [self addSubview:view3];
    }
    return self;
}

@end