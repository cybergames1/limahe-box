//
//  BlueToothViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BlueToothViewController.h"
#import "RadarView.h"
#import "CommonTools.h"
#import "SettingManager.h"

@interface BlueToothViewController () <CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _devices;
    RadarView * _radarView;
    BOOL _showAlert;
}

@property (nonatomic, retain) CBCentralManager * manager;
@property (nonatomic, retain) CBPeripheral * peripheral;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) CBCharacteristic * c;

@end

@implementation BlueToothViewController

- (void)dealloc {
    [_devices release];_devices = nil;
    [_timer invalidate];
    [_timer release];_timer = nil;
    [self stopManager];
    [super dealloc];
}

- (void)stopManager {
    [_c release];_c = nil;
    if (_peripheral) {
        [_manager cancelPeripheralConnection:_peripheral];
        [_peripheral setDelegate:nil];
        [_peripheral release];_peripheral = nil;
    }
    [_manager setDelegate:nil];
    [_manager stopScan];
    [_manager release];_manager = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _devices = [[NSMutableArray alloc] initWithCapacity:0];
        _showAlert = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"蓝牙安全监控"];
    
    UIImageView *backgroundImageView = [[[UIImageView alloc] initWithFrame:self.view.bounds] autorelease];
    backgroundImageView.image = [UIImage imageNamed:@"bl_bg"];
    [self.view addSubview:backgroundImageView];
    
    RadarView *radarView = [[[RadarView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 250)] autorelease];
    [self.view addSubview:radarView];
    _radarView = radarView;
    
    RadarLabel *radarLabel = [[[RadarLabel alloc] initWithFrame:CGRectMake(35, radarView.bottom+50, self.view.width-70, self.view.height-radarView.bottom-10)] autorelease];
    [self.view addSubview:radarLabel];
    
    _tableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
    _tableView.top = 64;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];

    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 30 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_manager stopScan];
        NSLog(@"扫描超时");
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)connect:(UIButton *)sender {
    [_manager connectPeripheral:_peripheral options:nil];
}

- (void)scheduleLocalNotification {
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    if (notification != nil) {
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        notification.fireDate = [NSDate date];
//        notification.soundName= UILocalNotificationDefaultSoundName;//声音
//        notification.repeatInterval = 0; //重复的方式。
//        notification.alertTitle = @"报警";
//        notification.alertBody = @"盒子超出范围!";
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    }
    if (_showAlert) return;
    
    NSLog(@"<<<<<<报警>>>>>>>>>");
    _showAlert = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意！" message:@"你的箱子离你过远" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
    [alert show];
    [alert release];
        
    /////////////
    Byte dataArr[5];
    
    dataArr[0]=0x01; dataArr[1]=0x01;
    dataArr[2]=0x03; dataArr[3]=0x0A;
    dataArr[4]=0x00;
    
    NSData * myData = [NSData dataWithBytes:dataArr length:5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_peripheral writeValue:myData forCharacteristic:_c type:CBCharacteristicWriteWithResponse];
    });
    ////////////////////
    
    [CommonTools makeSound:[[SettingManager sharedManager] bthWarningFileName] openVibration:[[SettingManager sharedManager] openVibration]];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate&Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"DeviceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    BLEInfo *info = _devices[indexPath.row];
    cell.textLabel.text = info.discoveredPeripheral.name ? info.discoveredPeripheral.name : @"未知设备";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %ld",@"信号",(long)[info.rssi integerValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BLEInfo *info = _devices[indexPath.row];
    self.peripheral = info.discoveredPeripheral;
    [_manager connectPeripheral:info.discoveredPeripheral options:nil];
    [_manager stopScan];
    
    [tableView setAlpha:0.0];
    [self showIndicatorHUDView:@"正在连接..."];
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)readRSSI {
    [_peripheral readRSSI];
}

//开启查看服务，蓝牙开启
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙已打开，请扫描外设");
            break;
        default:
            break;
    }
}

//查到外设后，停止扫描，连接设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    //NSLog(@"查到外设");
    //更新列表
    BLEInfo *disinfo = [[BLEInfo alloc] init];
    disinfo.discoveredPeripheral = peripheral;
    disinfo.rssi = RSSI;
    
    for (BLEInfo * info in _devices) {
        if ([info.discoveredPeripheral.identifier.UUIDString isEqualToString:disinfo.discoveredPeripheral.identifier.UUIDString]) {
            return;
        }
    }
    
    [_devices addObject:disinfo];
    [_tableView reloadData];
    [disinfo release];
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功");
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:nil];
    _radarView.state = RadarStateMatchSuccess;
    [self hideIndicatorHUDView];
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(readRSSI)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

//连接中断则重新连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接中断");
    _radarView.state = RadarStateSearchFailure;
    _showAlert = NO;
    [central connectPeripheral:self.peripheral options:nil];
}

//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接失败:%@",error);
    _radarView.state = RadarStateSearchFailure;
    _showAlert = NO;
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    /**
     d=10^((ABS(RSSI)-A)/(10*n)) 
     A:距离一米时的信号强度
     n:环境对信号的衰减系数
     **/
    int rssi = abs([peripheral.RSSI intValue]);
    CGFloat ci = (rssi - 64) / (10 * 4.);
    NSString *length = [NSString stringWithFormat:@"发现BLT热点:%@,距离:%.1fm",_peripheral.name,pow(10,ci)];
    NSLog(@"length:%@",length);
    if (pow(10, ci) > 7) {
        _radarView.state = RadarStateWarning;
        [self scheduleLocalNotification];
        
    }
}

//已发现服务
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"发现服务");
    int i = 0;
    for (CBService *s in peripheral.services) {
        NSLog(@"%d :服务 UUID: %@(%@)",i,s.UUID.data,s.UUID);
        i++;
        [peripheral discoverCharacteristics:nil forService:s];
    }
}

//已搜索到Characteristics
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"发现特征的服务:%@ (%@)",service.UUID.data ,service.UUID);
    for (CBCharacteristic *c in service.characteristics) {
        NSLog(@"特征 UUID: %@ (%@)--(%lu)",c.UUID.data,c.UUID,(unsigned long)c.properties);
        if (c.properties == CBCharacteristicPropertyRead) {
            NSLog(@"---read---");
        }else if (c.properties == CBCharacteristicPropertyWriteWithoutResponse) {
            NSLog(@"---writewithResponse---");
        }else if (c.properties == CBCharacteristicPropertyWrite) {
            NSLog(@"---write---");
        }else if (c.properties == CBCharacteristicPropertyNotify) {
            NSLog(@"---notify---");
        }else {
            NSLog(@"---other---");
        }
    }
    [peripheral readValueForCharacteristic:[service.characteristics firstObject]];
    [peripheral readValueForCharacteristic:[service.characteristics lastObject]];
    self.c = [service.characteristics firstObject];
}

//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:@"FE21"]]) {
        NSLog(@"value===:%@",characteristic.value);
        const unsigned char *hexBytesLight = [characteristic.value bytes];
        
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
        for (int i=0; i < 4; i++) {
            NSString *battery = [NSString stringWithFormat:@"%02x",hexBytesLight[i]];
            [string appendString:battery];
        }
        
        NSLog(@"info===21:%@",string);
    }else if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:@"FE25"]]) {
        const unsigned char *hexBytesLight = [characteristic.value bytes];
        
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
        for (int i=0; i < 1; i++) {
            NSString *battery = [NSString stringWithFormat:@"%02x",hexBytesLight[i]];
            [string appendString:battery];
        }
        
        NSLog(@"info<<<===25:%@",string);
    }else if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:@"FE24"]]) {
        const unsigned char *hexBytesLight = [characteristic.value bytes];
        
        NSMutableString *string = [[NSMutableString alloc] initWithCapacity:0];
        for (int i=0; i < 1; i++) {
            NSString *battery = [NSString stringWithFormat:@"%02x",hexBytesLight[i]];
            [string appendString:battery];
        }
        
        NSLog(@"info<<<===24:%@",string);
    }
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"读取Notify数据");
    if ([[characteristic UUID] isEqual:[CBUUID UUIDWithString:@"FE24"]]) {
        NSLog(@"value===:%@",characteristic.value);
    }
}

//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"writevalue for character :%@====",error);
}

@end


@implementation BLEInfo

- (void)dealloc {
    [_discoveredPeripheral release];_discoveredPeripheral = nil;
    [_rssi release];_rssi = nil;
    [super dealloc];
}

@end
