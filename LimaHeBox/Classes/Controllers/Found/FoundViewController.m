//
//  FoundViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "FoundViewController.h"
#import "AlarmClockEditViewController.h"
#import "PedoMeterViewController.h"
#import "CompanyViewController.h"
#import "TempViewController.h"
#import "TeleControlViewController.h"
#import "WeighViewController.h"
#import "CalendarViewController.h"
#import "GPSViewController.h"

@interface FoundViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _titleList;
    NSArray * _imageList;
}

@end

@implementation FoundViewController

- (void)dealloc {
    [_titleList release];_titleList = nil;
    [_imageList release];_imageList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *titleList_ = @[@"日历",@"计步器",@"遥控旅行箱",@"箱子GPS定位",@"温湿度监控",@"称重",@"闹钟",@"公司介绍"];
        _titleList = [titleList_ retain];
        
        NSArray *imageList_ = @[[UIImage imageNamed:@"f_1_date"],[UIImage imageNamed:@"f_1_pedo"],[UIImage imageNamed:@"f_1_control"],
                               [UIImage imageNamed:@"f_1_gps"],[UIImage imageNamed:@"f_1_tem"],[UIImage imageNamed:@"f_1_weigh"],
                               [UIImage imageNamed:@"f_1_alarm"],[UIImage imageNamed:@"f_1_com"]];
        _imageList = [imageList_ retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"发现"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"FoundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = _titleList[indexPath.row];
    cell.imageView.image = _imageList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            //日历
        {
            CalendarViewController *controller = [[CalendarViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 1:
            //计步器
        {
            PedoMeterViewController *controller = [[PedoMeterViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 2:
            //遥控旅行箱
        {
            TeleControlViewController *controller = [[TeleControlViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 3:
            //箱子GPS定位
        {
            GPSViewController *controller = [[GPSViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 4:
            //温度/湿度监控
        {
            TempViewController *controller = [[TempViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 5:
            //称重
        {
            WeighViewController *controller = [[WeighViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 6:
            //闹钟
        {
            AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 7:
            //公司介绍
        {
            CompanyViewController *controller = [[CompanyViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        default:
            break;
    }
}

- (void)rightBarAction {
}

@end
