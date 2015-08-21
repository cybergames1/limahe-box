//
//  CompanyNewsListViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/8/21.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "ComSuperViewController.h"

@interface CompanyNewsListViewController : ComSuperViewController <UITableViewDataSource,UITableViewDelegate>

@end

@interface NewsCell : UITableViewCell

- (void)setTitle:(NSString *)title;

@end