//
//  PedoMeterView.h
//  LimaHeBox
//
//  Created by jianting on 15/7/17.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PedoMeterView : UIView

//更新一个时间点对应的步数
- (void)updatePemoMeter:(CGFloat)meter date:(NSDate *)date;

@end
