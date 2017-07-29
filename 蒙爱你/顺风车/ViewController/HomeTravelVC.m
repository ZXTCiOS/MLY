//
//  HomeTravelVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeTravelVC.h"
#import "TouSuVC.h"


@interface HomeTravelVC ()

@property(nonatomic, strong) HomeTravelModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *imageV_car;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UILabel *numberL;

@property (weak, nonatomic) IBOutlet UILabel *driverL;

@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;




@end

@implementation HomeTravelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self loadInfo];
}


- (void)loadInfo{
    
    
    [self.imageV_car sd_setImageWithURL:[NSURL URLWithString:self.model.trip_pic] placeholderImage:img_shunFengChe_default];
    self.timeL.text = [NSString stringWithFormat:@"%@", self.model.trip_time];
    self.addressL.text = self.model.trip_address;
    self.numberL.text = [NSString stringWithFormat:@"%ld人", self.model.trip_people];
    self.driverL.text = self.model.trip_driver;
    [self.callBtn bk_addEventHandler:^(id sender) {
        [self call];
    } forControlEvents:UIControlEventTouchUpInside];
    self.headImgV.layer.cornerRadius = 45;
    self.headImgV.layer.masksToBounds = YES;
    [self.headImgV sd_setImageWithURL:self.model.trip_driver_pic.xd_URL placeholderImage:[UIImage imageNamed:@"54"]];
}



- (IBAction)popVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)tousu:(id)sender {
    
    TouSuVC *vc = [[TouSuVC alloc] initWithNibName:@"TouSuVC" bundle:nil];
    vc.trip_id = self.model.trip_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}







- (void)call{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%ld",(long)self.model.trip_phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}



- (instancetype)initWithHomeTravelModel:(HomeTravelModel *)model{
    self = [super initWithNibName:NSStringFromClass([HomeTravelVC class]) bundle:nil];
    if (self) {
        self.model = model;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
