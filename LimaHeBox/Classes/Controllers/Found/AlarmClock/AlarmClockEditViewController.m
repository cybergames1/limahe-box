//
//  AlarmClockEditViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AlarmClockEditViewController.h"
#import "AlarmClockManager.h"
#import "TimePickerView.h"
#import "ACDateViewController.h"

NSInteger UITableViewCellAccessorySwitch = 5;

@interface AlarmClockEditViewController () <UITableViewDataSource,UITableViewDelegate,TimePickerViewDelegate>
{
    NSMutableArray * _dataList;
    AlarmClock * _clock;
    
    UITableView * _tableView;
}

@end

@implementation AlarmClockEditViewController

- (void)dealloc {
    [_dataList release];_dataList = nil;
    [_clock release];_clock = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        AlarmClock *clock = [[AlarmClock alloc] init];
        [clock setHour:7 min:10];
        [clock setDaysList:@[@"1",@"2",@"5",@"7"]];
        [clock setShake:YES];
        _clock = clock;
        
        _dataList = [[NSMutableArray alloc] initWithCapacity:5];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:@"时间" forKey:@"title"];
        [dic setObject:[clock timeString] forKey:@"text"];
        [dic setObject:[NSNumber numberWithInteger:UITableViewCellAccessoryNone] forKey:@"accessoryType"];
        [_dataList addObject:dic];
        [dic release];
        
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:@"重复" forKey:@"title"];
        [dic setObject:[clock daysString] forKey:@"text"];
        [dic setObject:[NSNumber numberWithInteger:UITableViewCellAccessoryDisclosureIndicator] forKey:@"accessoryType"];
        [_dataList addObject:dic];
        [dic release];
        
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:@"铃声" forKey:@"title"];
        [dic setObject:@"设置" forKey:@"text"];
        [dic setObject:[NSNumber numberWithInteger:UITableViewCellAccessoryDisclosureIndicator] forKey:@"accessoryType"];
        [_dataList addObject:dic];
        [dic release];
        
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:@"震动" forKey:@"title"];
        [dic setObject:@"" forKey:@"text"];
        [dic setObject:[NSNumber numberWithInteger:UITableViewCellAccessorySwitch] forKey:@"accessoryType"];
        [_dataList addObject:dic];
        [dic release];
        
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [dic setObject:@"标签" forKey:@"title"];
        [dic setObject:@"" forKey:@"text"];
        [dic setObject:[NSNumber numberWithInteger:UITableViewCellAccessoryDisclosureIndicator] forKey:@"accessoryType"];
        [_dataList addObject:dic];
        [dic release];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"闹钟"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)updateClockTime {
    NSMutableDictionary *dic = _dataList[0];
    [dic setObject:[_clock timeString] forKey:@"text"];
}

- (void)updateClockRepeate {
    NSMutableDictionary *dic = _dataList[1];
    [dic setObject:[_clock daysString] forKey:@"text"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"AlarmCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    NSDictionary *dic = _dataList[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"text"];
    if ([dic[@"accessoryType" ] integerValue] == UITableViewCellAccessorySwitch) {
        UISwitch *s = [[UISwitch alloc] init];
        [s setOn:_clock.shake];
        [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = s;
        [s release];
    }
    else {
        cell.accessoryType = [dic[@"accessoryType"] integerValue];
    }
    
    return cell;
}

- (void)switchAction:(UISwitch *)s {
    _clock.shake = s.on;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //时间
        TimePickerView *pickerView = [[TimePickerView alloc] init];
        pickerView.delegate = self;
        [pickerView showInView:self.view];
        [pickerView release];
    }
    else if (indexPath.row == 1) {
        //重复日期
        ACDateViewController *controller = [[ACDateViewController alloc] init];
        controller.handleBlock = ^(NSArray *dataIndexList) {
            [_clock setDaysList:dataIndexList];
            
            [self updateClockRepeate];
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}

#pragma mark -
#pragma mark TimePickerViewDelegate
- (void)pickerView:(TimePickerView *)pickerView hour:(NSInteger)hour minute:(NSInteger)minute {
    [_clock setHour:hour min:minute];
    
    [self updateClockTime];
    [_tableView reloadData];
}

@end
