//
//  BlueToothViewController.m
//  LimaHeBox
//
//  Created by jianting on 15/7/20.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import "BlueToothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BlueToothViewController () <CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, retain) CBCentralManager * manager;
@property (nonatomic, retain) CBPeripheral * peripheral;

@end

@implementation BlueToothViewController

- (void)dealloc {
    [self stopManager];
    [super dealloc];
}

- (void)stopManager {
    [_manager cancelPeripheralConnection:_peripheral];
    [_manager setDelegate:nil];
    [_manager stopScan];
    [_manager release];_manager = nil;
    
    [_peripheral setDelegate:nil];
    [_peripheral release];_peripheral = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationItemLeftImage:[UIImage imageNamed:@"common_icon_back"]];
    [self setNavigationTitle:@"蓝牙安全监控"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(self.view.frame.size.width/2-100/2, self.view.frame.size.height/2-100/2, 100, 100)];
    [button setTitle:@"连接" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(connect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.manager stopScan];
        NSLog(@"扫描超时");
    });
}

- (void)connect:(UIButton *)sender {
    [_manager connectPeripheral:_peripheral options:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CBCentralManagerDelegate

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
    NSLog(@"查到外设");
    //NSLog(@"已发现 peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.UUID, advertisementData);
    self.peripheral = peripheral;
    [_manager stopScan];
}

//连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功");
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:nil];
}

//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接失败:%@",error);
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    int rssi = abs([peripheral.RSSI intValue]);
    CGFloat ci = (rssi - 49) / (10 * 4.);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_peripheral,pow(10,ci)];
    NSLog(@"距离：%@",length);
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
        NSLog(@"特征 UUID: %@ (%@)",c.UUID.data,c.UUID);
    }
}

//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

- (void)leftBarAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
