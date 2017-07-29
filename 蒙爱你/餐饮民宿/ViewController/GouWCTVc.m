//
//  GouWCTVc.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "GouWCTVc.h"
#import "GouWCCell.h"
#import "FoodDataModel.h"
#import "loginVC.h"

@interface GouWCTVc ()

@property (nonatomic, assign) NSInteger home_id;

@property (nonatomic, strong) NSMutableArray<FoodModel *> *datalist;

@property (nonatomic, strong) UILabel *total;

@end

@implementation GouWCTVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self netwroking];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = krgb(241, 241, 241, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GouWCCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

- (NSMutableArray<FoodModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<FoodModel *> array];
    }
    return _datalist;
}

- (void)netwroking{
    kget_token
    kget_userID
    
    [DNNetworking getWithURLString:get_checkGWC parameters:@{@"user_id": user_id, @"token": token, @"home_id": @(self.home_id)} success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSArray<FoodModel *> *arr = [NSArray modelArrayWithClass:[FoodModel class] json:[obj valueForKey:@"data"]];
            for (int i = 0; i < arr.count-1; i++) {
                arr[i].isselected = NO;
            }
            [self.datalist removeAllObjects];
            [self.datalist addObjectsFromArray:arr];
            [self.tableView reloadData];
        } else {
            [self.view showWarning:[obj valueForKey:@"message"]];
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GouWCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FoodModel *model = self.datalist[indexPath.row];
    [cell.imageV sd_setImageWithURL:model.bedeat_pic.xd_URL placeholderImage:[UIImage imageNamed:@"1"]];
    cell.name.text = model.bedeat_name;
    cell.count.text = [NSString stringWithFormat:@"%ld", model.bedeat_count];
    cell.desc.text = model.bedeat_des;
    cell.price.text = [NSString stringWithFormat:@"¥%.2f", model.bedeat_price];
    cell.isSel = model.isselected;
    [cell.isselected bk_addEventHandler:^(id sender) {
        self.datalist[indexPath.row].isselected = !self.datalist[indexPath.row].isselected;
        cell.isSel = self.datalist[indexPath.row].isselected;
        [self changetotal];
    } forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)changetotal{
    float f = 0;
    for (int i = 0; i < self.datalist.count; i++) {
        if (self.datalist[i].isselected) {
            f += self.datalist[i].bedeat_price;
        }
        if (i == self.datalist.count -1) {
            self.total.text = [NSString stringWithFormat:@"¥ %.2f", f];
        }
    }
}

static BOOL allSel = NO;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    UIButton *all = [UIButton buttonWithType:UIButtonTypeSystem];
    //[all setImage:[UIImage imageNamed:@"shdi-ns"] forState:UIControlStateNormal];
    [all setTitle:@"全选" forState: UIControlStateNormal];
    [all setTintColor:[UIColor blackColor]];
    all.titleLabel.font = [UIFont systemFontOfSize:14];
    [all bk_addEventHandler:^(id sender) {
        allSel = !allSel;
        
        for (int i = 0; i< self.datalist.count; i++) {
            self.datalist[i].isselected = allSel;
            if ( i == self.datalist.count - 1) {
                [self.tableView reloadData];
            }
        }
        //NSString *img = allSel ? @"shdz-s": @"shdi-ns";
        
        //[sender setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        
    } forControlEvents:UIControlEventTouchUpInside];
    all.frame = CGRectMake(10, 5, 60, 30);
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeSystem];
    [delete setTitle:@"删除" forState: UIControlStateNormal];
    delete.tintColor = [UIColor blackColor];
    [delete bk_addEventHandler:^(id sender) {
        
        
        NSMutableString *str;
        for (int i = 0; i < self.datalist.count; i++) {
            if (self.datalist[i].isselected) {
                if (!str) {
                    str = [NSMutableString stringWithFormat:@"%ld,", self.datalist[i].cart_id];
                } else {
                [str appendString:[NSString stringWithFormat:@"%ld,", self.datalist[i].cart_id]];
                NSLog(@"%@", str);
                }
                if (str && i == self.datalist.count - 1) {
                    [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
                    NSLog(@"%@", str);
                    [DNNetworking getWithURLString:get_gouwuche_delete parameters:@{@"cart_id": str} success:^(id obj) {
                        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
                        if ([code isEqualToString:@"200"]) {
                            [self.view showWarning:@"删除成功"];
                            [self netwroking];
                        } else {
                            [self.view showWarning:[obj valueForKey:@"message"]];
                        }
                        
                        
                    } failure:^(NSError *error) {
                        [self.view showWarning:@"网络错误"];
                    }];
                }
                
            }
            
        }
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    delete.frame = CGRectMake(kScreenW - 65, 5, 60, 30);
    [view addSubview:all];
    [view addSubview:delete];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 60)];
    
    UILabel *heji = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 40, 30)];
    heji.font = [UIFont systemFontOfSize:14];
    heji.text = @"合计:";
    heji.textColor = krgb(51, 51, 51, 1);
    
    self.total = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 100, 30)];
    self.total.font = [UIFont systemFontOfSize:15];
    self.total.textColor = krgb(223, 8, 66, 1);
    self.total.text = @"¥ 0";
    
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [delete setTitle:@"预定" forState: UIControlStateNormal];
    [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delete setBackgroundImage:[UIImage imageNamed:@"msxx-btn-ljyd"] forState:UIControlStateNormal];
    delete.tintColor = [UIColor blackColor];
    [delete bk_addEventHandler:^(id sender) {
        
        
        
        for (int i = 0; i < self.datalist.count; i++) {
            if (self.datalist[i].isselected) {
#warning  添加 提交订单页面....................
                NSLog(@"........");
            }
        }
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    delete.frame = CGRectMake(kScreenW - 70, 15, 60, 30);
    [view addSubview:delete];
    [view addSubview:self.total];
    [view addSubview:heji];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}





- (instancetype)initWithHome_id:(NSInteger)home_id{
    self = [super init];
    if (self) {
        self.home_id = home_id;
    }
    return self;
}





@end
