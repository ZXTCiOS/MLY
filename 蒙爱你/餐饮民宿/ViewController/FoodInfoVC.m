//
//  FoodInfoVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodInfoVC.h"
#import "GouWCTVc.h"
#import "Transition_Food.h"


@interface FoodInfoVC ()

@property (nonatomic, assign) NSInteger home_id;

@property (nonatomic, strong) FoodModel *model;


@property (weak, nonatomic) IBOutlet UILabel *foodname;

@property (weak, nonatomic) IBOutlet UILabel *foodprice;

@property (weak, nonatomic) IBOutlet UILabel *beizhu;

@property (weak, nonatomic) IBOutlet UIButton *gouwuche;

@property (weak, nonatomic) IBOutlet UILabel *count;



@end

@implementation FoodInfoVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imageV sd_setImageWithURL:self.model.bedeat_pic.xd_URL placeholderImage:[UIImage imageNamed:@"1"]];
    self.foodname.text = self.model.bedeat_name;
    self.foodprice.text = [NSString stringWithFormat:@"¥%.2f", self.model.bedeat_price];
    self.beizhu.text = self.model.bedeat_des;
    self.count.text = @"1";
    
    self.gouwuche.layer.cornerRadius = 5;
    self.gouwuche.layer.borderWidth = 0.5;
    self.gouwuche.layer.borderColor = [UIColor colorWithHexString:@"#df0842"].CGColor;
}

- (IBAction)plus:(id)sender {
    NSInteger i = self.count.text.integerValue;
    self.count.text = [NSString stringWithFormat:@"%ld", ++i];
}

- (IBAction)sub:(id)sender {
    NSInteger i = self.count.text.integerValue;
    if (i == 1) return;
    self.count.text = [NSString stringWithFormat:@"%ld", --i];
}

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)gouwuche:(id)sender {
    GouWCTVc *vc = [[GouWCTVc alloc] initWithHome_id:self.home_id];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)addgouwuche:(id)sender {
    
    if (![userDefault valueForKey:user_key_user_id]) {
        
        
    }
    
    NSString *user_id = [userDefault valueForKey:user_key_user_id];
    
    [DNNetworking postWithURLString:post_jiaGouWuChe parameters:@{@"user_id": user_id, @"home_id": @(self.home_id), @"bedeat_id": @(self.model.bedeat_id), @"bedeat_count": self.count.text} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            [self.view showWarning:@"添加成功"];
        } else {
            [self.view showWarning:[obj valueForKey:@"message"]];
        }
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (IBAction)yuding:(id)sender {
}


- (instancetype)initWithFoodModel:(FoodModel *)model home_id:(NSInteger) home_id{
    self = [super initWithNibName:@"FoodInfoVC" bundle:nil];
    if (self) {
        self.model = model;
        self.home_id = home_id;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
