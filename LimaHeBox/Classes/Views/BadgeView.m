//
//  BadgeView.m
//  LimaHeBox
//
//  Created by jianting on 15/9/2.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 16, 16);
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = self.bounds.size.height/2;
        self.layer.masksToBounds = YES;
        self.font = [UIFont systemFontOfSize:12];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setBadgeNumber:(NSInteger)badgeNumber {
    if (_badgeNumber != badgeNumber) {
        _badgeNumber = badgeNumber;
        self.text = [NSString stringWithFormat:@"%ld",(long)badgeNumber];
    }
}

@end
