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
#import "StroreViewController.h"
#import "InComingViewController.h"

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
        NSArray *titleList_ = @[@[@"GPS定位",@"称重",@"遥控旅行箱",@"温湿度监控"],
                                @[@"日历",@"闹钟"],
                                @[@"商城",@"游戏",@"摩景"],
                                @[@"品牌概述"]];
        _titleList = [titleList_ retain];
        
        NSArray *imageList_ = @[@[[UIImage imageNamed:@"f_1_gps"],[UIImage imageNamed:@"f_1_weigh"],[UIImage imageNamed:@"f_1_control"],[UIImage imageNamed:@"f_1_tem"]],
                                @[[UIImage imageNamed:@"f_1_date"],[UIImage imageNamed:@"f_1_alarm"]],
                                @[[UIImage imageNamed:@"f_1_store"],[UIImage imageNamed:@"f_1_game"],[UIImage imageNamed:@"f_1_view"]],
                                @[[UIImage imageNamed:@"f_1_com"]]];
        _imageList = [imageList_ retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"智能生活"];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_titleList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"FoundCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = _titleList[indexPath.section][indexPath.row];
    cell.imageView.image = _imageList[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    //箱子GPS定位
                {
                    GPSViewController *controller = [[GPSViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                case 1:
                    //称重
                {
                    WeighViewController *controller = [[WeighViewController alloc] init];
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
                    //温度/湿度监控
                {
                    TempViewController *controller = [[TempViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
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
                    //闹钟
                {
                    AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                    //商城
                {
                    StroreViewController *controller = [[StroreViewController alloc] init];
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                case 1:
                    //游戏
                {
                    InComingViewController *controller = [[InComingViewController alloc] init];
                    controller.title = @"游戏";
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                case 2:
                    //摩景
                {
                    InComingViewController *controller = [[InComingViewController alloc] init];
                    controller.title = @"摩景";
                    [self.navigationController pushViewController:controller animated:YES];
                    [controller release];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                    //品牌概述
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
            break;
        default:
            break;
    }
}

- (void)rightBarAction {
}

@end
