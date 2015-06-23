//
//  WeatherView.m
//  LimaHeBox
//
//  Created by jianting on 15/6/23.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeatherView.h"
#import <Category/Category.h>

@interface WeatherView ()
{
    UIImageView * _weatherImageView;
    UILabel * _temperatureLabel;
}

@end

@implementation WeatherView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _weatherImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)] autorelease];
        
        _temperatureLabel = [[[UILabel alloc] initWithFrame:CGRectMake(_weatherImageView.frame.origin.x+_weatherImageView.frame.size.width+10, _weatherImageView.frame.origin.y+15, frame.size.width-_weatherImageView.frame.origin.x-_weatherImageView.frame.size.width-10, 20)] autorelease];
        _temperatureLabel.backgroundColor = [UIColor clearColor];
        _temperatureLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_weatherImageView];
        [self addSubview:_temperatureLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"w_%d",(int)_weatherCode+1]];
    _temperatureLabel.text = [NSString stringWithFormat:@"%d°/%d°",(int)_minTemperature,(int)_maxTemperature];
}
@end
