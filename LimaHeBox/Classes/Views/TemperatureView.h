//
//  TemperatureView.h
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    GraduationDirectionLeft, //刻度在左边
    GraduationDirectionRight, //刻度在右边
};
typedef NSInteger GraduationDirection;

@interface TemperatureView : UIView

/** 刻度的方向 **/
@property (nonatomic, assign) GraduationDirection gradutaionDirection;

/** 刻度的最大和最小取值范围 **/
@property (nonatomic, assign) NSInteger maxValue;
@property (nonatomic, assign) NSInteger minValue;

/** 选择区域的最大和最小值 **/
@property (nonatomic, assign) NSInteger selectedMaxValue;
@property (nonatomic, assign) NSInteger selectedMinValue;

/** 选择区间的颜色 **/
@property (nonatomic, retain) UIColor * selectedColor;

/** 当前的值 **/
@property (nonatomic, assign) NSInteger currentValue;

/** 对应的图片 **/
@property (nonatomic, retain) UIImage * tempImage;

@end
