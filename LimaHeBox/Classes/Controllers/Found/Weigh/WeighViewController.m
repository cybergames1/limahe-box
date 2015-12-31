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
#import "RegisterButton.h"

#define Basic_Tag 12331
#define Button_Width_Rate (150.0/360.0)

@interface WeighViewController ()
{
    UILabel * _weightLabel;
    RegisterButton * _startButton;
}

@end

@implementation WeighViewController

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"称重"];
    self.view.backgroundColor = self.navigationBarTintColor;
    
    RegisterButton *startButton = [RegisterButton showGreenInView:self.view frame:CGRectMake(self.view.width/2-self.view.width*Button_Width_Rate/2, self.view.height-50-44, self.view.width*Button_Width_Rate, 44) title:@"START" target:self action:@selector(startAction)];
    [startButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    _startButton = startButton;
    
    UILabel *startLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, startButton.top - 40, self.view.width, 20)] autorelease];
    startLabel.backgroundColor = [UIColor clearColor];
    startLabel.text = @"请提起箱子后点击开始按钮";
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:startLabel];
    
    UIImage *image = [UIImage imageNamed:@"f_w"];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(self.view.width/2-image.size.width/2, startLabel.top - image.size.height-30, image.size.width, image.size.height)] autorelease];
    imageView.image = image;
    [self.view addSubview:imageView];
    
    SegmentLabel *label1 = [[SegmentLabel alloc] initWithFrame:CGRectMake(self.view.width-44-50, 64+90, 44, 44)];
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 64+130, self.view.width-40, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:(131.0/255.0) green:(229.0/255.0) blue:(210.0/255.0) alpha:1.0];
    label.font = [UIFont systemFontOfSize:60];
    [self.view addSubview:label];
    _weightLabel = label;
    
    [self getWeightInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[DeviceManager sharedManager] setWeightStep:WeightStepStartModle start:^(NSError *error) {
        if (error == nil) {
            [self showIndicatorHUDView:@"等待进入称重模式"];
        }else {
            [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self leftBarAction];
            });
        }
    } success:^{
        [self hideAllHUDView];
        [self checkDeviceIsOnline];
        [_startButton setEnabled:YES];
    } failure:^(NSError *error) {
        [self hideAllHUDView];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeight:) name:UpdateDeviceInfoNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)getWeightInfo {
    [[DeviceManager sharedManager] setWeightStep:WeightStepSendInstruction start:^(NSError *error) {
        if (error == nil) {
            [self showIndicatorHUDView:@"正在获取称重信息"];
        }else {
            [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
        }
    } success:^{
        [self hideAllHUDView];
    } failure:^(NSError *error) {
        [self hideAllHUDView];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    }];
}

- (void)updateWeight:(NSNotification *)notification {
    [self hideAllHUDView];
    if (![self checkDeviceIsOnline]) return;
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

- (void)startAction {
    [self getWeightInfo];
}

- (void)leftBarAction {
    [[DeviceManager sharedManager] setWeightStep:WeightStepStopModle start:^(NSError *error) {
        if (error == nil) {
            [self showIndicatorHUDView:@"等待退出称重模式"];
        }else {
            [super leftBarAction];
        }
    } success:^{
        [self hideAllHUDView];
        [super leftBarAction];
    } failure:^(NSError *error) {
        [self hideAllHUDView];
        [self showHUDWithText:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
        [super leftBarAction];
    }];
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
