//
//  TempViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "TempViewController.h"
#import "TemperatureView.h"
#import "DeviceDataSource.h"
#import "DeviceManager.h"

@interface TemperatureLabel : UIView

@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * descText;

@end

@interface TempViewController ()
{
    TemperatureLabel * _label1;
    TemperatureLabel * _label2;
    
    TemperatureView * _temp1;
    TemperatureView * _temp2;
}

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"温湿度监控"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44)] autorelease];
    label.backgroundColor = UIColorRGB(60, 139, 200);
    label.textColor = [UIColor whiteColor];
    label.text = @"\t舒适程度\t\tLOW";
    [self.view addSubview:label];
    
    
    TemperatureView *temp1 = [[[TemperatureView alloc] initWithFrame:CGRectMake(40, label.bottom+(self.view.height-label.bottom)/2-self.view.height/4, (self.view.width-80)/2, self.view.height/2)] autorelease];
    temp1.gradutaionDirection = GraduationDirectionRight;
    temp1.maxValue = 50;
    temp1.minValue = -10;
    temp1.selectedMaxValue = 20;
    temp1.selectedMinValue = 10;
    temp1.selectedColor = UIColorRGB(241, 209, 64);
    temp1.currentValue = [[[DeviceManager sharedManager] currentDevice] temperature];
    temp1.tempImage = [UIImage imageNamed:@"f_temp"];
    [self.view addSubview:temp1];
    _temp1 = temp1;
    
    TemperatureView *temp2 = [[[TemperatureView alloc] initWithFrame:CGRectMake(temp1.right, temp1.top, (self.view.width-80)/2, self.view.height/2)] autorelease];
    temp2.gradutaionDirection = GraduationDirectionLeft;
    temp2.maxValue = 100;
    temp2.minValue = 0;
    temp2.selectedMaxValue = 70;
    temp2.selectedMinValue = 30;
    temp2.selectedColor = UIColorRGB(71, 218, 192);
    temp2.currentValue = [[[DeviceManager sharedManager] currentDevice] wet];
    temp2.tempImage = [UIImage imageNamed:@"f_dity"];
    [self.view addSubview:temp2];
    _temp2 = temp2;
    
    TemperatureLabel *label1 = [[[TemperatureLabel alloc] initWithFrame:CGRectMake(40, temp1.top-40, 50, 27)] autorelease];
    [self.view addSubview:label1];
    _label1 = label1;
    
    TemperatureLabel *label2 = [[[TemperatureLabel alloc] initWithFrame:CGRectMake(self.view.width-90, label1.top, label1.width, label1.height)] autorelease];
    [self.view addSubview:label2];
    _label2 = label2;
    
    [[DeviceManager sharedManager] startGetDeviceInfo:^(NSError *error){
        if (error == nil) {
            [self showIndicatorHUDView:@"正在获取设备信息"];
        }else {
            [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
        }
    }success:^{
        [self hideAllHUDView];
        if (![self checkDeviceIsOnline]) return;
        _temp1.currentValue = [[[DeviceManager sharedManager] currentDevice] temperature];
        _temp2.currentValue = [[[DeviceManager sharedManager] currentDevice] wet];
        [_temp1 setNeedsLayout];
        [_temp2 setNeedsLayout];
        
        _label1.text = [NSString stringWithFormat:@"%d",(int)[[[DeviceManager sharedManager] currentDevice] temperature]];
        _label1.descText = @"℃";
        _label2.text = [NSString stringWithFormat:@"%d",(int)[[[DeviceManager sharedManager] currentDevice] wet]];
        _label2.descText = @"%";
        [_label1 setNeedsLayout];
        [_label2 setNeedsLayout];
    }failure:^(NSError *error) {
        [self hideAllHUDView];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

@end

@interface TemperatureLabel ()
{
    UILabel * _textLabel;
    UILabel * _descLabel;
}

@end

@implementation TemperatureLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(7, 0, 35, 20)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:label];
        _textLabel = label;
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(31, 5, 35, 17)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        _descLabel = label;
        
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)] autorelease];
        view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        [self addSubview:view];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.text = _text;
    _descLabel.text = _descText;
}

@end
