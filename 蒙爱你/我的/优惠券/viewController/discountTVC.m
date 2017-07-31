//
//  discountTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "discountTVC.h"
#import "DiscountCell.h"

#import "discountModel.h"
@interface discountTVC ()


@property (nonatomic,strong) NSMutableArray *discountArray;
@property (nonatomic, strong) UILabel *headL;

@end

@implementation discountTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discountArray = [NSMutableArray array];
    
    [self getData];
    
    self.title = @"我的优惠券";
    [XDFactory addBackItemForVC:self];
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.title = @"优惠券";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)getData{
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    //userid = @"2";
    NSString *urlstr = [NSString stringWithFormat:get_discount,userid];
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                discountModel *model = [[discountModel alloc] init];
                model.discount_id = [dit objectForKey:@"discount_id"];
                model.discount_jian = [dit objectForKey:@"discount_jian"];
                model.discount_man = [dit objectForKey:@"discount_man"];
                [self.discountArray addObject:model];
            }
  
            //self.headL.text = @"您有3张优惠券";
        }else
        {
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discountArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //  yhq-wx  huise  image
    //  yhq-yx  hongse
    [cell setdata:self.discountArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 38)];
    self.headL = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, 300, 18)];
    view.backgroundColor = krgb(241, 241, 241, 1);
//    self.headL.text = @"您有3张优惠券";
    NSString *num = [NSString stringWithFormat:@"%lu",(unsigned long)self.discountArray.count];
    self.headL.text = [NSString stringWithFormat:@"%@%@%@",@"您有",num,@"张优惠券"];
    self.headL.textColor = krgb(51, 51, 51, 1);
    [view addSubview:self.headL];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 35)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW - 300)/2, 20, 300, 15)];
    lab.textAlignment = NSTextAlignmentCenter;
    view.backgroundColor = krgb(241, 241, 241, 1);
    lab.text = @"没有更多了";
    lab.textColor = krgb(51, 51, 51, 1);
    [view addSubview:lab];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    discountModel *model = self.discountArray[indexPath.row];
    NSDictionary *dic = @{@"contentid":model.discount_id};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"discountkvc" object:dic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
