//
//  PedoMeterViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "PedoMeterViewController.h"
#import "PedoMeterView.h"

@interface PedoMeterViewController ()
{
    UILabel * _meterLabel;
    UILabel * _kaLabel;
    UILabel * _timeLabel;
    UILabel * _mileLabel;
}

@end

@implementation PedoMeterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"计步器"];
    
    /** 计步器显示区 **/
    PedoMeterView *meterView = [[[PedoMeterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2)] autorelease];
    meterView.backgroundColor = [UIColor colorWithRed:(3.0/255.0) green:(104.0/255.0) blue:(183.0/255.0) alpha:1.0];
    [self.view addSubview:meterView];
    
    /** 今日步数 **/
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, meterView.bottom+5, self.view.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"今日步数";
    [self.view addSubview:label];
    
    _meterLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, label.bottom+5, self.view.width, 30)] autorelease];
    _meterLabel.backgroundColor = [UIColor clearColor];
    _meterLabel.textColor = UIColorRGB(65, 200, 177);
    _meterLabel.textAlignment = NSTextAlignmentCenter;
    _meterLabel.font = [UIFont systemFontOfSize:40];
    _meterLabel.text = @"8916";
    [self.view addSubview:_meterLabel];
    
    /** 大卡 **/
    _kaLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, _meterLabel.bottom+10, self.view.width/3, 30)] autorelease];
    _kaLabel.backgroundColor = [UIColor clearColor];
    _kaLabel.textColor = UIColorRGB(240, 208, 61);
    _kaLabel.textAlignment = NSTextAlignmentCenter;
    _kaLabel.font = [UIFont systemFontOfSize:30];
    _kaLabel.text = @"237";
    [self.view addSubview:_kaLabel];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(0, _kaLabel.bottom+2, _kaLabel.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"大卡";
    [self.view addSubview:label];
    
    /** 活跃时间 **/
    _timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(_kaLabel.right, _kaLabel.top, self.view.width/3, 30)] autorelease];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textColor = UIColorRGB(65, 200, 177);
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:30];
    _timeLabel.text = @"1h35m";
    [self.view addSubview:_timeLabel];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom+2, _timeLabel.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"活跃时间";
    [self.view addSubview:label];
    
    /** 英里 **/
    _mileLabel = [[[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.right, _kaLabel.top, self.view.width/3, 30)] autorelease];
    _mileLabel.backgroundColor = [UIColor clearColor];
    _mileLabel.textColor = UIColorRGB(3, 100, 183);
    _mileLabel.textAlignment = NSTextAlignmentCenter;
    _mileLabel.font = [UIFont systemFontOfSize:30];
    _mileLabel.text = @"3.9";
    [self.view addSubview:_mileLabel];
    
    label = [[[UILabel alloc] initWithFrame:CGRectMake(_mileLabel.left, _mileLabel.bottom+2, _mileLabel.width, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"英里";
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
