//
//  CompanyNewsListViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "CompanyNewsListViewController.h"
#import "NewsDataSource.h"
#import "CompanyNewsViewController.h"

@interface CompanyNewsListViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@property (nonatomic, retain) NSMutableArray * newsList;

@end

@implementation CompanyNewsListViewController

- (void)dealloc {
    [_newsList release];_newsList = nil;
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _newsList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"公司动态"];
    
    UITableView *tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped] autorelease];
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    NewsDataSource *dataSource_ = [[NewsDataSource alloc] initWithDelegate:self];
    [dataSource_ getNewsListWithPage:1 pageSize:20];
    self.dataSource = dataSource_;
}

#pragma mark -
#pragma mark UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"NewsListCell";
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    [cell setTitle:[_newsList[indexPath.row] objectForKey:@"title"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyNewsViewController *controller = [[CompanyNewsViewController alloc] init];
    controller.newsId = [_newsList[indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark -
#pragma mark PPQDataSourceDelegate

- (void)dataSourceFinishLoad:(PPQDataSource *)source {
    id list = [[source.data objectForKey:@"data"] objectForKey:@"list"];
    if ([list isKindOfClass:[NSArray class]]) {
        self.newsList = [NSMutableArray arrayWithArray:list];
    }
    [_tableView reloadData];
}

- (void)dataSource:(PPQDataSource *)source hasError:(NSError *)error {
    [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
}

@end


@interface NewsCell ()
{
    UILabel * _titleLabel;
}

@end

@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 50)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 2;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:label];
        _titleLabel = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end