//
//  WeighViewController.h
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BoxSuperViewController.h"

@interface WeighViewController : BoxSuperViewController

@end

@interface SegmentLabel : UILabel
{
    id _target;
    SEL _action;
}

- (void)addTarget:(id)target action:(SEL)action;

@end
