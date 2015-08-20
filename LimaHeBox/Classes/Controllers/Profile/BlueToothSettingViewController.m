//
//  BlueToothSettingViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BlueToothSettingViewController.h"
#import <Category/Category.h>
#import "AccountManager.h"
#import "CommonTools.h"

@interface BlueToothSettingViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation BlueToothSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"蓝牙报警设置"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
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
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"铃声%ld",indexPath.row+1];
    }else if (indexPath.section == 1) {
        //
    }else if (indexPath.section == 2) {
        cell.textLabel.text = @"蓝牙报警震动";
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
@end
