//
//  ACDateViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/1.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ACDateViewController.h"

@interface ACDateViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _dateArray;
    NSMutableArray * _indexArray; //标志数组，标志有没有选中
}

@end

@implementation ACDateViewController

- (void)dealloc {
    [_dateArray release]; _dateArray = nil;
    [_indexArray release]; _indexArray = nil;
    [_selectedIndexList release]; _selectedIndexList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateArray = [[NSArray alloc] initWithObjects: @"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];
        _indexArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],
                                                              [NSNumber numberWithBool:NO],nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [self updateIndexArray];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self updateSelectedIndexList];
    if (_handleBlock) _handleBlock(_selectedIndexList);
}

/* 根据已经选择的日期更新标志数组 */
- (void)updateIndexArray {
    for (id indexString in _selectedIndexList) {
        NSInteger index = [indexString integerValue];
        [_indexArray replaceObjectAtIndex:index-1 withObject:[NSNumber numberWithBool:YES]];
    }
}

/* 根据标志数组更新选择的日期 */
- (void)updateSelectedIndexList {
    [_selectedIndexList removeAllObjects];
    [_selectedIndexList release];
    _selectedIndexList = [[NSMutableArray alloc] initWithCapacity:7];
    
    for (NSInteger i = 0; i < [_indexArray count]; i++) {
        BOOL indexBool = [_indexArray[i] boolValue];
        if (indexBool) {
            [_selectedIndexList addObject:[NSNumber numberWithInteger:i+1]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dateArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"DateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = _dateArray[indexPath.row];
    cell.accessoryType = [_indexArray[indexPath.row] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_indexArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:![_indexArray[indexPath.row] boolValue]]];
    [tableView reloadData];
}

@end
