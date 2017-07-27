//
//  ScenicVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicVC.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <HYBLoopScrollView.h>
#import "UIImage+alphaImage.h"
#import "ZXTCNavigationViewController.h"
#import "WKWedViewController.h"
#import "ScenicViewModel.h"
#import "TicketCell.h"



@interface ScenicVC ()<CLLocationManagerDelegate>

@property (nonatomic, assign) NSInteger scenic_id;

@property (weak, nonatomic) IBOutlet UIView *headerV;

@property (nonatomic, strong) HYBLoopScrollView *banner;

@property (weak, nonatomic) IBOutlet UILabel *headName;

@property (weak, nonatomic) IBOutlet UILabel *headDesc;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UIButton *goMap;

@property (weak, nonatomic) IBOutlet UIControl *gonglue;


//  地图

@property (weak, nonatomic) IBOutlet UIButton *gomap;

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) CLLocation *here;

@property (nonatomic, strong) ScenicViewModel *viewmodel;

@property (nonatomic, strong) UIView *naviBar;
@property (nonatomic, strong) UIButton *popBtn;
@property (nonatomic, strong) UILabel *titleL;

@end

@implementation ScenicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewmodel getScenicDetailDataWithScenic_id:self.scenic_id handller:^(NSError *error) {
        if (!error) {
            [self configHeaderView];
            [self configMap];
            [self.tableView reloadData];
        } else {
            [self.view showWarning:@"网络错误"];
        }
    }];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [XDFactory addBackItemForVC:self];
}

- (void)configHeaderView{
    self.banner.placeholder = img_banner_default;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.viewmodel.model.jingdian_lunbo.count; i++) {
        [arr addObject:self.viewmodel.model.jingdian_lunbo[i].image_url];
    }
    
    self.banner.imageUrls = arr;
    self.headName.text = self.viewmodel.model.jingdian_xiangqing.scenic_name;
    self.headDesc.text = self.viewmodel.model.jingdian_xiangqing.scenic_intro;
    self.address.text = self.viewmodel.model.jingdian_xiangqing.scenic_address;
    
    
    MJWeakSelf
    [self.gonglue bk_addEventHandler:^(id sender) {
        WKWedViewController *vc = [[WKWedViewController alloc] initWithTitle:self.viewmodel.model.jingdian_xiangqing.scenic_name Url:self.viewmodel.model.gonglue_href.xd_URL];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.viewmodel.model.jingdian_xiangqing.scenic_address.length) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:self.viewmodel.model.jingdian_xiangqing.scenic_address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *mark = [placemarks firstObject];
            [self.goMap bk_addEventHandler:^(id sender) {
                MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                double latitude = mark.location.coordinate.latitude;
                double longtitude = mark.location.coordinate.longitude;
                
                CLLocationCoordinate2D coordina = CLLocationCoordinate2DMake(latitude, longtitude);
                MKPlacemark *mark = [[MKPlacemark alloc] initWithCoordinate:coordina addressDictionary:nil];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:mark];
                toLocation.name = self.viewmodel.model.jingdian_xiangqing.scenic_name;
                [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                
            } forControlEvents:UIControlEventTouchUpInside];
            
        }];
    }
}




#pragma mark - tableview  datasource /  delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.model.jingdian_ticket.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewmodel.model.jingdian_ticket.count ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketCell" forIndexPath:indexPath];
    
    cell.ticketName.text = self.viewmodel.model.jingdian_ticket[indexPath.row].ticket_name;
    cell.priceL.text = [NSString stringWithFormat:@"¥ %0.2f", self.viewmodel.model.jingdian_ticket[indexPath.row].ticket_price];
    [cell.goumaixuzhi bk_addEventHandler:^(id sender) {
        WKWedViewController *vc = [[WKWedViewController alloc] initWithTitle:self.viewmodel.model.jingdian_xiangqing.scenic_name Url:self.viewmodel.model.jingdian_ticket[indexPath.row].must_know.xd_URL];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.buyBtn bk_addEventHandler:^(id sender) {
#warning 添加 支付接口
    } forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




#pragma mark - scrollview delegate

- (void)configNaviBar{
    
    self.naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
    [self.navigationController.view addSubview:self.naviBar];
    self.naviBar.backgroundColor = krgb(225, 225, 225, 0);
    
    
    self.popBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.naviBar addSubview:self.popBtn];
    [self.popBtn setImage:[UIImage imageNamed:@"dh-fh-w"] forState:UIControlStateNormal];
    self.popBtn.tintColor = [UIColor whiteColor];
    self.popBtn.frame = CGRectMake(15, 30, 20, 20);
    [self.popBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.naviBar addSubview:self.popBtn];
    
    
    self.titleL = [[UILabel alloc] init];
    [self.naviBar addSubview:self.titleL];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(self.popBtn.mas_centerY);
    }];
    self.titleL.textColor = [UIColor whiteColor];
    self.titleL.text = @"景点";
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint p = scrollView.contentOffset;
    if (p.y < 0) {
        self.tableView.contentOffset = CGPointMake(0, 0);
    } else if (p.y > 0 && p.y < 150) {
        self.naviBar.backgroundColor = krgb(225, 225, 225, p.y / 150.0);
        self.titleL.textColor = [UIColor whiteColor];
        self.popBtn.tintColor = [UIColor whiteColor];
    } else if (p.y > 150) {
        self.titleL.textColor = [UIColor colorWithHexString:@"#333333"];
        self.popBtn.tintColor = krgb(38, 38, 38, 1);
    }
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configNaviBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.naviBar removeFromSuperview];
}


#pragma Map  delegate

- (void)configMap{
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestWhenInUseAuthorization];
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    self.manager.delegate = self;
    self.manager.distanceFilter = 200;
    [self.manager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    self.here = locations.lastObject;
    [manager stopUpdatingLocation];
    
    if (self.viewmodel.model.jingdian_xiangqing.scenic_address.length) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:self.viewmodel.model.jingdian_xiangqing.scenic_address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *mark = [placemarks firstObject];
            
            CLLocation *there = [[CLLocation alloc] initWithLatitude:mark.location.coordinate.latitude longitude:mark.location.coordinate.longitude];
            CLLocationDistance meters = [self.here distanceFromLocation:there];
            self.distance.text = [NSString stringWithFormat:@"距离%0.1f公里", meters/ 1000.0];
        }];
    }
    self.distance.text = @"没有位置";
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    self.distance.text = @"定位失败";
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HYBLoopScrollView *)banner{
    if (!_banner) {
        _banner = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 195) imageUrls:@[] timeInterval:2 didSelect:^(NSInteger atIndex) {
            
            
            
        } didScroll:^(NSInteger toIndex) {
            
        }];
        
        [self.headerV addSubview:_banner];
    }
    return _banner;
}

- (ScenicViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [[ScenicViewModel alloc] init];
    }
    return _viewmodel;
}


- (id)initWithScenic_id:(NSInteger)scenic_id{
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"scenic" bundle:nil];
    self = [st instantiateInitialViewController];
    if (self) {
        self.scenic_id = scenic_id;
    }
    return self;
}





@end
