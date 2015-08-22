//
//  TemperatureView.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TemperatureView.h"
#import <Category/Category.h>

#define GradutionCount 31 //刻度个数

@interface TemperatureView ()
{
    UIView * _VLineView;
    UIView * _VSelectView;
    NSMutableArray * _gradutionList;
    
    UIView * _currentView;
    UIImageView * _imageView;
    
    UILabel * _maxLabel;
    UILabel * _minLabel;
    UILabel * _selectMaxLabel;
    UILabel * _selectMinLabel;
}

@end
@implementation TemperatureView

- (void)dealloc {
    [_gradutionList release];_gradutionList = nil;
    [_selectedColor release];_selectedColor = nil;
    [_tempImage     release];_tempImage     = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /** 竖条 **/
        UIView *view1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 10, 6, frame.size.height-20)] autorelease];
        view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view1];
        _VLineView = view1;
        
        /** 选择的区域 **/
        UIView *view2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 10, 6, frame.size.height-20)] autorelease];
        [self addSubview:view2];
        _VSelectView = view2;
        
        /** 当前值所对应的长线 **/
        UIView *view3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-view1.width-20, 2)] autorelease];
        [self addSubview:view3];
        _currentView = view3;
        
        /** 图片显示的view **/
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
        [self addSubview:imageView];
        _imageView = imageView;
        
        // 每个刻度之间的间隙
        CGFloat edge = (view1.height-GradutionCount*2-2)/GradutionCount;
        _gradutionList = [[NSMutableArray alloc] initWithCapacity:0];
        /** 刻度线 **/
        for (int i = 0; i < GradutionCount+1; i++) {
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(view1.right, i*(2+edge)+view1.top, 3, 2)];
            v.backgroundColor = [UIColor whiteColor];
            [self addSubview:v];
            [_gradutionList addObject:v];
            [v release];
        }
        
        /** 四个Label **/
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)] autorelease];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _maxLabel = label;
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)] autorelease];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _minLabel = label;
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)] autorelease];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _selectMaxLabel = label;
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)] autorelease];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _selectMinLabel = label;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /** 长竖线的位置更新 **/
    if (_gradutaionDirection == GraduationDirectionLeft) {
        _VLineView.right = self.width-20;
    }else {
        _VLineView.left = 20;
    }
    
    /** 刻度位置更新 **/
    for (UIView *v in _gradutionList) {
        v.left = (_gradutaionDirection == GraduationDirectionRight) ? _VLineView.right : (_VLineView.left-v.width);
    }
    
    /** 选择区域的位置更新 **/
    _VSelectView.left = _VLineView.left;
    
    CGFloat height = _maxValue-_minValue;
    CGFloat selectHeightRate = ((_selectedMaxValue-_selectedMinValue)*1.0)/(height*1.0);
    CGFloat selectTopRate = ((_maxValue-_selectedMaxValue)*1.0)/(height*1.0);
    
    _VSelectView.top = selectTopRate*_VLineView.height+_VLineView.top;
    _VSelectView.height = selectHeightRate*_VLineView.height;
    _VSelectView.backgroundColor = _selectedColor;
    
    /** 选择长线的位置更新 **/
    CGFloat topRate =  ((_maxValue-_currentValue)*1.0)/(height*1.0);
    
    _currentView.top = topRate*_VLineView.height+_VLineView.top;
    _currentView.left = (_gradutaionDirection == GraduationDirectionRight) ? _VLineView.right : 0;
    _currentView.backgroundColor = _selectedColor;
    
    /** 图片位置的更新 **/
    CGFloat left = (_gradutaionDirection == GraduationDirectionRight) ? _VLineView.right : 0;
    _imageView.width = _tempImage.size.width;
    _imageView.height = _tempImage.size.height;
    _imageView.center = CGPointMake(left+(self.width-_VLineView.width-15)/2, _currentView.top-5-_tempImage.size.height/2);
    _imageView.image = _tempImage;
    
    /** 更新四个Label的位置 **/
    _maxLabel.left = (_gradutaionDirection == GraduationDirectionRight) ? 0 : self.width-16;
    _maxLabel.top = 5;
    _maxLabel.text = [NSString stringWithFormat:@"%ld",(long)_maxValue];
    
    _minLabel.left = _maxLabel.left;
    _minLabel.top = self.height-25;
    _minLabel.text = [NSString stringWithFormat:@"%ld",(long)_minValue];
    
    _selectMaxLabel.left = _maxLabel.left;
    _selectMaxLabel.top = _VSelectView.top-10;
    _selectMaxLabel.text = [NSString stringWithFormat:@"%ld",(long)_selectedMaxValue];
    
    _selectMinLabel.left = _maxLabel.left;
    _selectMinLabel.top = _VSelectView.bottom-10;
    _selectMinLabel.text = [NSString stringWithFormat:@"%ld",(long)_selectedMinValue];
}
@end
