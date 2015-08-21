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

@interface FoundViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _titleList;
}

@end

@implementation FoundViewController

- (void)dealloc {
    [_titleList release];_titleList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *titleList_ = @[@"日历",@"计步器",@"遥控旅行箱",@"箱子GPS定位",@"温度/湿度监控",@"闹钟",@"公司介绍"];
        _titleList = [titleList_ retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"发现"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            //日历
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
            break;
        case 3:
            //箱子GPS定位
            break;
        case 4:
            //温度/湿度监控
            break;
        case 5:
            //闹钟
        {
            AlarmClockEditViewController *controller = [[AlarmClockEditViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
            break;
        case 6:
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

- (void)leftBarAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarAction {
}

@end
