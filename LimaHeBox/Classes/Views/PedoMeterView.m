//
//  PedoMeterView.m
//  LimaHeBox
//
//  Created by jianting on 15/7/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PedoMeterView.h"
#import <Category/Category.h>

#define Basic_Tag 21231

@interface PedoMeterView ()
{
    NSMutableArray * _metersList;
    CGFloat _maxMeter;
    
    UIView * _xView;
    UIView * _yView;
}

@end

@implementation PedoMeterView

- (void)dealloc {
    [_metersList release];_metersList = nil;
    [super dealloc];
}

- (void)loadData {
    _maxMeter = 0;
    _metersList = [[NSMutableArray alloc] initWithObjects:
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:300.0],
                   
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:780.0],
                   [NSNumber numberWithFloat:0.0],
                   
                   [NSNumber numberWithFloat:500.0],
                   [NSNumber numberWithFloat:105.0],
                   [NSNumber numberWithFloat:1004.0],
                   [NSNumber numberWithFloat:200.0],
                   
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:720.0],
                   [NSNumber numberWithFloat:0.0],
                   
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],
                   [NSNumber numberWithFloat:0.0],nil];
    
    for (int i = 0; i < [_metersList count]; i++) {
        [self updatePedoMeter:[_metersList[i] floatValue] atIndex:i];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        
        //x轴
        UIView * xView = [[[UIView alloc] initWithFrame:CGRectMake(50, self.height - 60, self.width-50-30, 2)] autorelease];
        xView.backgroundColor = [UIColor whiteColor];
        _xView = xView;
        
        //y轴
        UIView * yView = [[[UIView alloc] initWithFrame:CGRectMake(48, xView.bottom-100, 2, 100)] autorelease];
        yView.backgroundColor = [UIColor whiteColor];
        _yView = yView;
        
        [self addSubview:xView];
        [self addSubview:yView];
        
        //坐标基准点
        for (int i = 0; i < 24; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((3+7)*i+3+xView.left, xView.top-2, 7, 2)];
            view.tag = Basic_Tag+i;
            view.backgroundColor = [UIColor whiteColor];
            [self addSubview:view];
            [view release];
            
            [self setPedoMeter:[_metersList[i] floatValue] atIndex:i];
        }
    }
    return self;
}

- (void)updatePedoMeter:(CGFloat)meter date:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"hh"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"a"];
    NSString *currentAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    NSInteger index = [currentHourString integerValue];
    index = [currentAMPMString isEqualToString:@"下午"] ? index+12 : index;
    
    [self updatePedoMeter:meter atIndex:index];
}

- (void)updatePedoMeter:(CGFloat)meter atIndex:(NSInteger)index {
    if (meter > _maxMeter) {
        _maxMeter = meter;
    }
}

- (void)setPedoMeter:(CGFloat)meter atIndex:(NSInteger)index {
    CGFloat maxHeight = _maxMeter * 1.1;
    CGFloat percent = meter / maxHeight;
    CGFloat height = percent * _yView.height;
    height = (height <= 2) ? 2 : height;
    
    UIView *view = [self viewWithTag:Basic_Tag+index];
    view.frame = CGRectMake(view.left, _xView.top - height, 7, height);
}

@end
