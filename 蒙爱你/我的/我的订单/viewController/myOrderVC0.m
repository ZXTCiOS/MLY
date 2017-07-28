//
//  myOrderVC0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myOrderVC0.h"
#import "myorderCell.h"
#import "detailedOrderVC.h"
#import "MBProgressHUD+XMG.h"
#import "myOrderModel.h"
@interface myOrderVC0 ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
@property (nonatomic,strong) UITableView *ordertableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSMutableArray *copydic;
@end
static NSString *myordercell0 = @"myordercell0identfid";
@implementation myOrderVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ordertableView];
    self.dataSource = [NSMutableArray array];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"order" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    self.copydic = [NSMutableArray array];
    self.copydic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"dic=====%@",self.copydic);
    
    
    [self addHeader];
    self.ordertableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSLog(@"token------%@",token);
    NSString *uid = [userDefault objectForKey:user_key_user_id];
    NSLog(@"uid----%@",uid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.ordertableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.ordertableView.mj_header beginRefreshing];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *urlstr = [NSString stringWithFormat:get_myorder,userid,token,@"1"];
    
    self.dataSource = [NSMutableArray array];
    
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
        NSLog(@"obj=%@",obj);
        
        obj = self.copydic;
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *data = [obj objectForKey:@"data"];
            
            for (int i = 0; i<data.count; i++) {
                NSDictionary *dit = [data objectAtIndex:i];
                NSDictionary *gooddit = [dit objectForKey:@"goods"];
                myOrderModel *model = [[myOrderModel alloc] init];
                model.orderidstr = [dit objectForKey:@"order_id"];
                model.ordertype = [dit objectForKey:@"order_type"];
                model.ordersn = [dit objectForKey:@"order_sn"];
                model.pricestr = [dit objectForKey:@"order_money"];
                model.numstr = [dit objectForKey:@"order_count"];
                model.totalpricestr = [dit objectForKey:@"order_money"];
                model.discountprice = [dit objectForKey:@"discount"];
                //退款原因
                model.refundstr = [dit objectForKey:@"order_invoice"];
                
                model.ordertype = @"6";
                
                if ([gooddit objectForKey:@"bedeat_id"]==nil&&[gooddit objectForKey:@"ticket_id"]==nil) {
                    //goods_id
                    model.namestr = [gooddit objectForKey:@"goods_name"];
                    model.orderimgstr = [gooddit objectForKey:@"goods_pic"];
                    model.contentstr = [gooddit objectForKey:@"goods_intro"];
                    
                }
                if ([gooddit objectForKey:@"goods_id"]==nil&&[gooddit objectForKey:@"ticket_id"]==nil) {
                    //bedeat_id
                    model.namestr = [gooddit objectForKey:@"bedeat_name"];
                    model.orderimgstr = [gooddit objectForKey:@"bedeat_pic"];
                    model.contentstr = [gooddit objectForKey:@"bedeat_intro"];
                }
                if ([gooddit objectForKey:@"goods_id"]==nil&&[gooddit objectForKey:@"bedeat_id"]==nil) {
                    //ticket_id
                    model.namestr = [gooddit objectForKey:@"ticket_name"];
                    model.orderimgstr = [gooddit objectForKey:@"bedeat_pic"];
                    model.contentstr = [gooddit objectForKey:@"ticket_intro"];
                }
                
                [self.dataSource addObject:model];
            }
            [self.ordertableView reloadData];
        }else
        {
            NSString *hud = [obj objectForKey:@"message"];
            [MBProgressHUD showSuccess:hud];
        }
        [self.ordertableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.ordertableView.mj_header endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)ordertableView
{
    if(!_ordertableView)
    {
        _ordertableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenW , kScreenH-64-44)];
        _ordertableView.dataSource = self;
        _ordertableView.delegate = self;
    }
    return _ordertableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myorderCell *cell = [tableView dequeueReusableCellWithIdentifier:myordercell0];
    cell =  [[myorderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myordercell0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setdata:self.dataSource[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 380/2*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailedOrderVC *detalvc = [[detailedOrderVC alloc] init];
    [self.navigationController pushViewController:detalvc animated:YES];
    
}

//取消

-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.ordertableView indexPathForCell:cell];
    NSLog(@"333===%ld   取消",index.section);
}

//支付

-(void)myTabVClick2:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.ordertableView indexPathForCell:cell];
    NSLog(@"222===%ld   付款",index.section);
}

@end
