//
//  ExpressListViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/6/24.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ExpressListViewController.h"

@interface ExpressListViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _expressList;
}

@end

@implementation ExpressListViewController

- (void)dealloc {
    [_expressList release];_expressList = nil;
    [_handleBlock release];_handleBlock = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _canCall = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationTitle:@"快递列表"];
    
    NSArray *expressList = [NSArray arrayWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kuaidi.plist"]];
    
    _expressList = [[self sortedArray:expressList] retain];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSMutableArray *)sortedArray:(NSArray *)array {
    //NSDictionary转成ExpressModel
    NSMutableArray *expressList_ = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *dic in array) {
        ExpressModel *model = [[ExpressModel alloc] init];
        model.expressId = [dic objectForKey:@"k_id"];
        model.expressName = [dic objectForKey:@"k_name"];
        model.expressPhone = [dic objectForKey:@"k_phone"];
        [expressList_ addObject:model];
        [model release];
    }
    
    //用UILocalizedIndexedCollation来进行分组，按首字母分组A~Z,#
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSInteger sectionTitlesCount = [[collation sectionTitles] count];
    
    /* 26个字母加#对应27个数组 */
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
        [array release];
    }
    
    /* 获取expressId属性的首字母，加到对应的字母组 */
    for (ExpressModel *model in expressList_) {
        NSInteger sectionNumber = [collation sectionForObject:model collationStringSelector:@selector(expressId)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:model];
    }
    
    /* 每个字母组内再进行排序 */
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *arrayForSection = newSectionsArray[index];
        NSArray *sortedArrayForSection = [collation sortedArrayFromArray:arrayForSection collationStringSelector:@selector(expressId)];
        newSectionsArray[index] = sortedArrayForSection;
    }
    
    [expressList_ release];
    
    return [newSectionsArray autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[UILocalizedIndexedCollation currentCollation] sectionTitles][section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_expressList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray*)[_expressList objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"ExpressCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    ExpressModel *model = _expressList[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"k_%@",model.expressId]];
    cell.textLabel.text = model.expressName;
    cell.detailTextLabel.text = model.expressPhone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ExpressModel *model = _expressList[indexPath.section][indexPath.row];
    if (_canCall) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.expressPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        [str release];
        return;
    }
    if (_handleBlock) {
        _handleBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
