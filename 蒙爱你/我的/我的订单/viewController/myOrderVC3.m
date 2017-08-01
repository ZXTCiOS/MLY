//
//  myOrderVC3.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myOrderVC3.h"
#import "myorderCell.h"
#import "detailedOrderVC.h"
#import "MBProgressHUD+XMG.h"
#import "myOrderModel.h"
@interface myOrderVC3 ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
@property (nonatomic,strong) UITableView *ordertableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSMutableArray *copydic;
@end

static NSString *myordercell3 = @"myordercell0identfid3";

@implementation myOrderVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ordertableView];
    self.dataSource = [NSMutableArray array];
    
    [self empty];
    
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


-(void)empty
{
    // method one 配置方法1
    typeof(self) weakSelf = self;
    [self.ordertableView emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        configer.emptyTitle = @"暂无此类订单信息";
        configer.emptyTitleFont = [UIFont boldSystemFontOfSize:14];
        configer.emptyTitleColor = [UIColor colorWithHexString:@"d5d5d5"];
        configer.emptyImage = [UIImage imageNamed:@"dd-kby"];
        configer.emptySpaceHeight = 20;
        configer.emptyViewTapBlock = ^{
            [weakSelf.ordertableView.mj_header beginRefreshing];
            //[self addHeader];
        };
    }];
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
    NSString *urlstr = [NSString stringWithFormat:get_myorder,userid,token,@"5"];
    
    self.dataSource = [NSMutableArray array];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res-----%@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue]==200&&[[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = [responseObject objectForKey:@"data"];
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
                model.addressid = [dit objectForKey:@"address_id"];
                model.discount_id = [dit objectForKey:@"discount_id"];
                model.discountprice = [gooddit objectForKey:@"goods_lowprice"];

                //退款原因
                model.refundstr = [dit objectForKey:@"order_invoice"];
//                
//                model.ordertype = @"1";
                
                if ([gooddit objectForKey:@"bedeat_id"]==nil&&[gooddit objectForKey:@"ticket_id"]==nil) {
                    //goods_id
                    model.namestr = [gooddit objectForKey:@"goods_name"];
                    model.orderimgstr = [gooddit objectForKey:@"goods_pic"];
                    model.contentstr = [gooddit objectForKey:@"goods_intro"];
                    model.goods_description = [gooddit objectForKey:@"goods_description"];
                    model.goods_id = [gooddit objectForKey:@"goods_id"];
                }
                if ([gooddit objectForKey:@"goods_id"]==nil&&[gooddit objectForKey:@"ticket_id"]==nil) {
                    //bedeat_id
                    model.namestr = [gooddit objectForKey:@"bedeat_name"];
                    model.orderimgstr = [gooddit objectForKey:@"bedeat_pic"];
                    model.contentstr = [gooddit objectForKey:@"bedeat_intro"];
                    model.goods_description = [gooddit objectForKey:@"bedeat_description"];
                    model.goods_id = [gooddit objectForKey:@"bedeat_id"];
                }
                if ([gooddit objectForKey:@"goods_id"]==nil&&[gooddit objectForKey:@"bedeat_id"]==nil) {
                    //ticket_id
                    model.namestr = [gooddit objectForKey:@"ticket_name"];
                    model.orderimgstr = [gooddit objectForKey:@"bedeat_pic"];
                    model.contentstr = [gooddit objectForKey:@"ticket_intro"];
                    model.goods_description = [gooddit objectForKey:@"ticket_description"];
                    model.goods_id = [gooddit objectForKey:@"ticket_id"];
                }
                
                [self.dataSource addObject:model];
            }
            [self.ordertableView reloadData];
        }else
        {
            NSString *hud = [responseObject objectForKey:@"message"];
            [MBProgressHUD showSuccess:hud];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        [self.ordertableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
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
    myorderCell *cell = [tableView dequeueReusableCellWithIdentifier:myordercell3];
    cell =  [[myorderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myordercell3];
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
-(void)myTabVClick3:(UITableViewCell *)cell//退款
{
    
}
-(void)myTabVClick4:(UITableViewCell *)cell//修改
{
    
}
-(void)myTabVClick5:(UITableViewCell *)cell//物流
{
    
}
-(void)myTabVClick6:(UITableViewCell *)cell//评价
{
    
}

-(void)myTabVClick7:(UITableViewCell *)cell//退款原因展示
{
    
}
@end
