//
//  BedDetailTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/17.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "BedDetailTVC.h"
#import "BedDetailCell.h"
#import <HYBLoopScrollView.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import "LiJiYuDingTVC.h"
#import "MinsuDetailModel.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>



@interface BedDetailTVC ()<UIScrollViewDelegate, CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UIView *headerV;


@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UILabel *nameL_EN;

@property (weak, nonatomic) IBOutlet UIImageView *star1_minsu;

@property (weak, nonatomic) IBOutlet UIImageView *star2_minsu;

@property (weak, nonatomic) IBOutlet UIImageView *star3_minsu;

@property (weak, nonatomic) IBOutlet UIImageView *star4_minsu;

@property (weak, nonatomic) IBOutlet UIImageView *star5_minsu;


@property (weak, nonatomic) IBOutlet UIImageView *action1_img;

@property (weak, nonatomic) IBOutlet UILabel *action1_L;

@property (weak, nonatomic) IBOutlet UIImageView *action2_img;

@property (weak, nonatomic) IBOutlet UILabel *action2_L;

@property (weak, nonatomic) IBOutlet UIImageView *action3_img;

@property (weak, nonatomic) IBOutlet UILabel *action3_L;

@property (weak, nonatomic) IBOutlet UIImageView *action4_img;

@property (weak, nonatomic) IBOutlet UILabel *action4_L;

@property (weak, nonatomic) IBOutlet UIImageView *action5_img;

@property (weak, nonatomic) IBOutlet UILabel *action5_L;

@property (weak, nonatomic) IBOutlet UIControl *actionContrl;

// 地图

@property (weak, nonatomic) IBOutlet UIButton *gomap;

@property (weak, nonatomic) IBOutlet UILabel *name_map;

@property (weak, nonatomic) IBOutlet UILabel *distanceL;

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) CLLocation *here;
@property (nonatomic, strong) CLLocation *there;


// 评价
@property (weak, nonatomic) IBOutlet UIImageView *pingjia_img;

@property (weak, nonatomic) IBOutlet UILabel *pingjia_name;

@property (weak, nonatomic) IBOutlet UIImageView *pingjia_star1;

@property (weak, nonatomic) IBOutlet UIImageView *pingjia_star2;

@property (weak, nonatomic) IBOutlet UIImageView *pingjia_star3;

@property (weak, nonatomic) IBOutlet UIImageView *pingjia_star4;

@property (weak, nonatomic) IBOutlet UIImageView *pingjia_star5;

@property (weak, nonatomic) IBOutlet UILabel *pingjia_detail;

@property (weak, nonatomic) IBOutlet UILabel *pingjia_time;




// 民宿简介
@property (weak, nonatomic) IBOutlet UILabel *jianjie_detailL;



// 轮播
@property (nonatomic, strong) HYBLoopScrollView *banner;


// 存放 cell 状态数组
@property (nonatomic, strong) NSMutableArray *arraybed;
@property (nonatomic, strong) NSMutableArray *arrayeat;

@property (nonatomic, strong) NSArray<MinsuBedModel *> *bedlist;
@property (nonatomic, strong) NSArray<MinsuBedModel *> *eatlist;
@property (nonatomic, assign) BOOL isBed;
@property (nonatomic, assign) NSInteger phone;

@property (nonatomic, strong) UIButton *bedBtn;
@property (nonatomic, strong) UIButton *eatBtn;

@end

@implementation BedDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self getDataFromNet];
    [XDFactory addBackItemForVC:self];
    self.title = @"民宿信息";
   [self configNaviBar];
}

- (void)getDataFromNet{
   
   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
   
   NSString *minsuid = [NSString stringWithFormat:@"%ld", self.minsu_id];
   [dic setValue:minsuid forKey:@"id"];
   [DNNetworking getWithURLString:@"MLY/api.php/Home/minsuDetail" parameters:dic success:^(id obj) {
      
      NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
      if ([code isEqualToString:@"200"]) {
         
         MinsuDetailModel *model = [MinsuDetailModel parse:obj];
         MinsuEvaluate *eva = model.data.eval;
         [self.pingjia_img sd_setImageWithURL:eva.user_pickture.xd_URL placeholderImage:[UIImage imageNamed:@"7"]];
         self.pingjia_detail.text = eva.eval_content;
         self.pingjia_name.text = eva.user_nickname;
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
         
         [dateFormatter setDateFormat:@"yyyy.MM.dd"];
         NSDate *date = [NSDate dateWithTimeIntervalSinceNow:eva.eval_time];
         NSString *d = [dateFormatter stringFromDate:date];
         self.pingjia_time.text = d;
         
         
         [self configPingjiaStarWithstar:eva.eval_star];
         [self configArtWitharray:model.data.art];
         
         
         MinsuHomeModel *home = model.data.home;
         self.banner.imageUrls = @[home.home_pic];
         self.nameL.text = home.home_name;
         self.priceL.text = [NSString stringWithFormat:@"¥%ld起", home.min_price];
         self.nameL_EN.text = home.home_intro;
         [self configMinsuStarWithstar:home.home_star];
         
         self.name_map.text = home.home_address;
         self.jianjie_detailL.text = home.home_description;
         self.phone = home.home_phone;
         
         
         self.bedlist = model.data.bed;
         self.eatlist = model.data.eat;
         
         
         self.isBed = YES;
         self.arraybed = [NSMutableArray array];
         self.arrayeat = [NSMutableArray array];
         for (int i= 0; i<model.data.bed.count; i++) {
            [self.arraybed addObject:@(0)];
         }
         for (int i= 0; i<model.data.eat.count; i++) {
            [self.arrayeat addObject:@(0)];
         }
         
         if (home.home_address.length) {
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:home.home_address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
               CLPlacemark *mark = [placemarks firstObject];
               [self.gomap bk_addEventHandler:^(id sender) {
                  MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                  double latitude = mark.location.coordinate.latitude;
                  double longtitude = mark.location.coordinate.longitude;
                  self.there = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
                  CLLocationCoordinate2D coordina = CLLocationCoordinate2DMake(latitude, longtitude);
                  MKPlacemark *mark = [[MKPlacemark alloc] initWithCoordinate:coordina addressDictionary:nil];
                  MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:mark];
                  toLocation.name = home.home_name;
                  [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                  
               } forControlEvents:UIControlEventTouchUpInside];
               
            }];
         }
         
         
         [self.tableView reloadData];
         
         
      }
      
      
      
   } failure:^(NSError *error) {
      [self.view showWarning:@"网络错误"];
   }];
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
   
   if (self.there) {
      
         CLLocationDistance meters = [self.here distanceFromLocation:self.there];
         self.distanceL.text = [NSString stringWithFormat:@"距离%0.1f公里", meters/ 1000.0];
   
   }
   self.distanceL.text = @"没有位置";
   
   
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
   
   self.distanceL.text = @"定位失败";
   
}




- (void)configMinsuStarWithstar:(NSInteger) star{
   if (star < 1) return;
   self.star1_minsu.image = [UIImage imageNamed:@"xj-s"];
   if (star < 2) return;
   self.star2_minsu.image = [UIImage imageNamed:@"xj-s"];
   if (star < 3) return;
   self.star3_minsu.image = [UIImage imageNamed:@"xj-s"];
   if (star < 4) return;
   self.star4_minsu.image = [UIImage imageNamed:@"xj-s"];
   if (star < 5) return;
   self.star5_minsu.image = [UIImage imageNamed:@"xj-s"];
}

- (void)configPingjiaStarWithstar:(NSInteger) star{
   if (star < 1) return;
   self.pingjia_star1.image = [UIImage imageNamed:@"xj-s-b"];
   if (star < 2) return;
   self.pingjia_star2.image = [UIImage imageNamed:@"xj-s-b"];
   if (star < 3) return;
   self.pingjia_star3.image = [UIImage imageNamed:@"xj-s-b"];
   if (star < 4) return;
   self.pingjia_star4.image = [UIImage imageNamed:@"xj-s-b"];
   if (star < 5) return;
   self.pingjia_star5.image = [UIImage imageNamed:@"xj-s-b"];
}
- (void)configArtWitharray:(NSArray<MinsuArtModel *> *) array{
   if (array.count < 1) return;
   [self.action1_img sd_setImageWithURL:array[0].art_logo.xd_URL placeholderImage:[UIImage imageNamed:@""]];
   self.action1_L.text = array[0].art_name;
   if (array.count < 2) return;
   [self.action2_img sd_setImageWithURL:array[1].art_logo.xd_URL placeholderImage:[UIImage imageNamed:@""]];
   self.action2_L.text = array[1].art_name;
   if (array.count < 3) return;
   [self.action3_img sd_setImageWithURL:array[2].art_logo.xd_URL placeholderImage:[UIImage imageNamed:@""]];
   self.action3_L.text = array[2].art_name;
   if (array.count < 4) return;
   [self.action4_img sd_setImageWithURL:array[3].art_logo.xd_URL placeholderImage:[UIImage imageNamed:@""]];
   self.action4_L.text = array[3].art_name;
   if (array.count < 5) return;
   [self.action5_img sd_setImageWithURL:array[4].art_logo.xd_URL placeholderImage:[UIImage imageNamed:@""]];
   self.action4_L.text = array[4].art_name;
   if (array.count > 5) {
      [self.actionContrl bk_addEventHandler:^(id sender) {
         
         
         // 弹出 活动窗口
         
#warning 添加 弹出活动窗口
         
         
         
         
         
      } forControlEvents: UIControlEventTouchUpInside];
   }
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.isBed ? self.bedlist.count : self.eatlist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BedDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bedCell" forIndexPath:indexPath];
   
   NSArray<MinsuBedModel *> *array;
   NSMutableArray *bedeat;
   if (self.isBed) {
      array = self.bedlist;
      bedeat = self.arraybed;
   } else {
      array = self.eatlist;
      bedeat = self.arrayeat;
   }
    cell.detailL.text = array[indexPath.row].bedeat_intro;
    cell.otherL.text = array[indexPath.row].bedeat_des;
    cell.name.text = array[indexPath.row].bedeat_name;
    cell.priceL.text = [NSString stringWithFormat:@"%.2ld元", (long)array[indexPath.row].bedeat_price];
   
    [cell.imgV sd_setImageWithURL:array[indexPath.row].bedeat_pic.xd_URL placeholderImage:[UIImage imageNamed:@"7"]];
    cell.buynow = ^(){
       UIStoryboard *stb = [UIStoryboard storyboardWithName:@"BedDetailTVC" bundle:nil];
       LiJiYuDingTVC *vc = [stb instantiateViewControllerWithIdentifier:@"lijiyuding"];
       //vc.room_id =
       //vc.minsu_id =
       [self.navigationController pushViewController:vc animated:YES];
    };
   NSInteger shouqi = [bedeat[indexPath.row] integerValue];
   [cell.shouqiBtn setTitle:shouqi ? @"收起" : @"展开" forState:UIControlStateNormal];
   UIImage *img = [UIImage imageNamed:shouqi ? @"msxx-sq" : @"msxx-zk2"];
   [cell.shouqiBtn setImage:img forState:UIControlStateNormal];
   
   
   
    cell.kefu = ^(){
       NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%ld",(long)self.phone];
       UIWebView *callWebview = [[UIWebView alloc] init];
       [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
       [self.view addSubview:callWebview];
    };
   [cell.shouqiBtn bk_addEventHandler:^(id sender) {
      int b = [bedeat[indexPath.row] intValue];
      bedeat[indexPath.row] = b ? @(0) : @(1);
      [self.tableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationMiddle];
   } forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    // 创建数组记录 cell 的展开状态,依据展开状态来返回 cell 高度
   NSArray *bedeat;
   NSArray<MinsuBedModel *> *array;
   if (self.isBed) {
      array = self.bedlist;
      bedeat = self.arraybed;
   } else {
      array = self.eatlist;
      bedeat = self.arrayeat;
   }
   CGSize size = CGSizeMake(kScreenW - 20, 1000);
   NSInteger h1 = [array[indexPath.row].bedeat_intro sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByCharWrapping].height;
   NSInteger h2 = [array[indexPath.row].bedeat_des sizeForFont:[UIFont systemFontOfSize:15] size:size mode:NSLineBreakByCharWrapping].height;
   if ([bedeat[indexPath.row] intValue]) {
      return 283 + h1 + 94 + h2;
   }
   return 283 + h1;
   
   
   
   
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 500;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

static UIView *view;
//static UIView *redline;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 35)];
    view.backgroundColor = [UIColor whiteColor];
   UIView *white = [UIView new];
   white.backgroundColor = [UIColor clearColor];
   [view addSubview:white];
   [white mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(0);
      make.height.equalTo(10);
      make.width.equalTo(10);
   }];
   
   
   
   
   self.bedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   self.eatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   [self.bedBtn setTitle:@"住宿" forState: UIControlStateNormal];
   [self.eatBtn setTitle:@"餐饮" forState: UIControlStateNormal];
   [self.bedBtn setTitleColor:krgb(223, 8, 66, 1) forState:UIControlStateDisabled];
   [self.eatBtn setTitleColor:krgb(223, 8, 66, 1) forState:UIControlStateDisabled];
   [self.bedBtn setTitleColor:krgb(51, 51, 51, 1) forState:UIControlStateNormal];
   [self.eatBtn setTitleColor:krgb(51, 51, 51, 1) forState:UIControlStateNormal];
   
   
   [view addSubview:self.bedBtn];
   [view addSubview:self.eatBtn];
   [self.bedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.equalTo(CGSizeMake(50, 30));
      make.right.equalTo(white.mas_left).equalTo(-15);
      make.centerY.equalTo(0);
   }];
   [self.eatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.equalTo(CGSizeMake(50, 30));
      make.left.equalTo(white.mas_right).equalTo(15);
      make.centerY.equalTo(0);
   }];
   
   //redline = [[UIView alloc] init];
   //[view addSubview:redline];
   //redline.backgroundColor = krgb(223, 8, 66, 1);
   //redline.frame = CGRectMake(kScreenW/2 - 70, 33, 50, 2);
//   [redline mas_makeConstraints:^(MASConstraintMaker *make) {
//      make.bottom.equalTo(0);
//      make.size.equalTo(CGSizeMake(50, 2));
//      make.centerX.equalTo(self.bedBtn.mas_centerX);
//   }];
   
   
   self.bedBtn.enabled = !self.isBed;
   self.eatBtn.enabled = self.isBed;
   
   [self.bedBtn bk_addEventHandler:^(id sender) {
      self.isBed = YES;
      [self.tableView reloadData];
      //redline.frame = CGRectMake(kScreenW/2 - 70, 33, 50, 2);
      //[UIView animateWithDuration:0.5 animations:^{
        // redline.frame = CGRectMake(kScreenW/2 - 70, 33, 50, 2);
//         [redline mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.bedBtn.mas_centerX);
//         }];
         
         //[view layoutSubviews];
      //}];
      self.bedBtn.enabled = NO;
      self.eatBtn.enabled = YES;
   } forControlEvents:UIControlEventTouchUpInside];
   [self.eatBtn bk_addEventHandler:^(id sender) {
      self.isBed = NO;
      [self.tableView reloadData];
     // redline.frame = CGRectMake(kScreenW/2 + 20, 33, 50, 2);
      //[UIView animateWithDuration:0.5 animations:^{
         
        // redline.frame = CGRectMake(kScreenW/2 + 20, 33, 50, 2);
         
//         [redline mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.eatBtn.mas_centerX);
//         }];
        // [view layoutSubviews];
      //}];
      self.bedBtn.enabled = YES;
      self.eatBtn.enabled = NO;
   } forControlEvents:UIControlEventTouchUpInside];
   
   
   
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

#pragma mark - NaviBar   透明

- (void)configNaviBar{
   
   UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
   [self.view.superview.superview addSubview:view];
   view.backgroundColor = [UIColor redColor];
   
}







- (void)viewWillAppear:(BOOL)animated{
   [super viewWillAppear:animated];
   //self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
   [super viewWillDisappear:animated];
   //self.navigationController.navigationBar.hidden = NO;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
