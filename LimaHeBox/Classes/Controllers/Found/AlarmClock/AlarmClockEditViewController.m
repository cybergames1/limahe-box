//
//  AlarmClockEditViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/26.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "AlarmClockEditViewController.h"
#import "AlarmClockManager.h"

NSInteger UITableViewCellAccessorySwitch = 5;

@interface AlarmClockEditViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataList;
    AlarmClock * _clock;
}

@end

@implementation AlarmClockEditViewController

- (void)dealloc {
    [_dataList release];_dataList = nil;
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
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
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

@end
