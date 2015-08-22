//
//  BlueToothSettingViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BlueToothSettingViewController.h"
#import "AccountManager.h"
#import "FlagView.h"

#define Slider_Tag 3221
#define Switch_Tag 3232

@interface BlueToothSettingViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _audioSelectArray;
    NSInteger _lastSelectRow;
    UITableView * _tableView;
}

@end

@implementation BlueToothSettingViewController

- (void)dealloc {
    [_audioSelectArray release];_audioSelectArray = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _audioSelectArray = [[NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO], nil] retain];
        _lastSelectRow = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"蓝牙报警设置"];
    self.view.backgroundColor = UIColorRGB(248, 248, 248);
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)setFlagViewInCell:(UITableViewCell *)cell {
    FlagView *flagView = [[[FlagView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)] autorelease];
    cell.accessoryView = flagView;
}

- (void)setSliderInCell:(UITableViewCell *)cell {
    [[cell.contentView viewWithTag:Slider_Tag] removeFromSuperview];
    UISlider *slider = [[[UISlider alloc] initWithFrame:CGRectMake(30, cell.height/2-20/2, self.view.width-60, 20)] autorelease];
    slider.tag = Slider_Tag;
    [cell.contentView addSubview:slider];
}

- (void)setSwitchInCell:(UITableViewCell *)cell {
    UISwitch *s = [[[UISwitch alloc] init] autorelease];
    cell.accessoryView = s;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"BlueToothSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"铃声%ld",indexPath.row+1];
        [self setFlagViewInCell:cell];
        [(FlagView *)cell.accessoryView setSelected:[_audioSelectArray[indexPath.row] boolValue]];
    }else if (indexPath.section == 1) {
        [self setSliderInCell:cell];
    }else if (indexPath.section == 2) {
        cell.textLabel.text = @"蓝牙报警震动";
        [self setSwitchInCell:cell];
    }else {
        //
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"蓝牙报警铃声";
    }else if (section == 1) {
        return @"蓝牙报警铃声音量";
    }else if (section == 2) {
        return @"震动";
    }else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [_audioSelectArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:_lastSelectRow];
        [tableView reloadData];
        _lastSelectRow = indexPath.row;
    }
}

@end
