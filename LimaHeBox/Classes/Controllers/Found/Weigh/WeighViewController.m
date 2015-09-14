//
//  WeighViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "WeighViewController.h"
#import "DeviceManager.h"
#import "QYSegmentControl.h"

#define Basic_Tag 12331

@interface WeighViewController ()
{
    UILabel * _weightLabel;
}

@end

@implementation WeighViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"称重"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    UIImage *image = [UIImage imageNamed:@"f_weigh"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    SegmentLabel *label1 = [[SegmentLabel alloc] initWithFrame:CGRectMake(280, 64+140, 44, 44)];
    label1.text = @"oz";
    label1.tag = Basic_Tag;
    [label1 addTarget:self action:@selector(segmentClicked:)];
    [self.view addSubview:label1];
    
    SegmentLabel *label2 = [[SegmentLabel alloc] initWithFrame:CGRectMake(label1.left, label1.bottom, 44, 44)];
    label2.text = @"kg";
    label2.tag = Basic_Tag+1;
    [label2 addTarget:self action:@selector(segmentClicked:)];
    [self.view addSubview:label2];
    
    SegmentLabel *label3 = [[SegmentLabel alloc] initWithFrame:CGRectMake(label1.left, label2.bottom, 44, 44)];
    label3.text = @"g";
    label3.tag = Basic_Tag+2;
    [label3 addTarget:self action:@selector(segmentClicked:)];
    [self.view addSubview:label3];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 64+100, self.view.width-40, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(131.0/255.0) green:(229.0/255.0) blue:(210.0/255.0) alpha:1.0];
    label.font = [UIFont systemFontOfSize:60];
    [self.view addSubview:label];
    _weightLabel = label;
    
    [self showIndicatorHUDView:@"正在获取设备信息"];
    CGFloat weight = [[[DeviceManager sharedManager] currentDevice] weight];
    if (weight <= 0.0) return;
    
    [self hideAllHUDView];
    [self segmentClicked:(SegmentLabel *)[self.view viewWithTag:Basic_Tag+1]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeight:) name:UpdateUserInfoNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateWeight:(NSNotification *)notification {
    [self hideAllHUDView];
    [self segmentClicked:(SegmentLabel *)[self.view viewWithTag:Basic_Tag+1]];
}

- (void)segmentClicked:(SegmentLabel *)sender {
    NSInteger tag = sender.tag-Basic_Tag;
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[SegmentLabel class]]) {
            [(SegmentLabel *)v setHighlighted:NO];
        }
    }
    [(SegmentLabel *)sender setHighlighted:YES];
    
    CGFloat weight = [[[DeviceManager sharedManager] currentDevice] weight];
    if (tag == 0) {
        //盎司
        _weightLabel.text = [NSString stringWithFormat:@"%.2f",weight/28.35];
    }else if (tag == 1) {
        //kg
        _weightLabel.text = [NSString stringWithFormat:@"%.1f",weight/1000.0];
    }else {
        //g
        _weightLabel.text = [NSString stringWithFormat:@"%.1f",weight];
    }
}

@end

@implementation SegmentLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:28];
        self.textColor = [UIColor whiteColor];
        self.highlightedTextColor = [UIColor colorWithRed:(131.0/255.0) green:(229.0/255.0) blue:(210.0/255.0) alpha:1.0];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.bounds;
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)tap {
    if ([_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? [UIColor whiteColor] : [UIColor clearColor];
}

@end
