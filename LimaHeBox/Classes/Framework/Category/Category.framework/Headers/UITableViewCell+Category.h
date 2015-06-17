//
//  UITableViewCell+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark UITableViewCell （UITableViewCellShortCut）
@interface UITableViewCell (UITableViewCellShortCut)
/**
 @details 获取cell所在的tableView
 */
@property(nonatomic,readonly) UITableView *tableView;

/**
 @details 获取cell在tableView的位置
 */
@property(nonatomic,readonly) NSIndexPath *indexPath;

@end

//#pragma mark UITableViewSectionIndexView自定义索引
//@class UITableViewSectionIndexView;
//@interface UITableView (UITableViewSectionIndexView)
//@property (nonatomic,retain) UITableViewSectionIndexView* customSectionIndexView;
//@end
//
//@protocol UITableViewSectionIndexViewDataSource <NSObject>
//@optional
///** 
// 返回 tableview 索引关键字的列表，(比如：ABCDEFG.... 或者 赵钱孙李周吴郑王....)
// */
//- (NSArray *)sectionIndexTitles;
//
//@end
//
//@interface UITableViewSectionIndexView : UIControl
//- (instancetype) initWithTableview:(UITableView*) tableview;
//
///** dataSource */
//@property (nonatomic, assign) id<UITableViewSectionIndexViewDataSource> dataSource;
//
///** 默认系统字体，15号 */
//@property (nonatomic, retain) UIFont* indexFont;
///** 选中后系统字体，15号 */
//@property (nonatomic, retain) UIFont* highlightIndexFont;
//
///** 字体颜色，默认黑色 */
//@property (nonatomic, retain) UIColor* indexColor;
///** 选中后字体颜色，默认黑色 */
//@property (nonatomic, retain) UIColor* highlightIndexColor;
//
///** 字号随着索引文字的多少自动变化，默认 NO。 */
//@property (nonatomic, assign) BOOL autoFitSize;
//
///**
// 如果需要更新 index title，可以通过调用该 API
// */
//- (void) reloadSectionIndexTitles;
//@end

