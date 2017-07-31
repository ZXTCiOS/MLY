//
//  submitorderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitorderVC.h"
#import "submitorderCell0.h"
#import "submitorderCell1.h"
#import "submitorderCell2.h"
#import "subbuttomView.h"
#import "submitorderModel.h"

#import "discountTVC.h"
#import "ShouHuoDiZhiTVC.h"
#import "confirmorderVC.h"

#import "strisNull.h"
#import "MBProgressHUD+XMG.h"

@interface submitorderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *submittableView;
@property (nonatomic,strong) NSDictionary *addressdit;
@property (nonatomic,strong) NSDictionary *discountdit;
@property (nonatomic,strong) subbuttomView *btnView;

@property (nonatomic,strong) NSString *order_snstr;
@end
static NSString *submitVCidentfid0 = @"submitVCidentfid0";
static NSString *submitVCidentfid1 = @"submitVCidentfid1";
static NSString *submitVCidentfid2 = @"submitVCidentfid2";
@implementation submitorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.addressdit = [NSDictionary dictionary];
    self.discountdit = [NSDictionary dictionary];
    [self.view addSubview:self.submittableView];
    [self.view addSubview:self.btnView];
    [self loaddata];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kvc01:) name:@"addresskvc" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(kvc02:) name:@"discountkvc" object:nil];
    
    self.submittableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    CGFloat sum = 0.0;
    NSMutableArray *sumarr = [NSMutableArray array];
    
    for (int i = 0; i<self.orderDatasource.count; i++) {
        submitorderModel *model = [self.orderDatasource objectAtIndex:i];
        CGFloat numfloat = [model.ordernumber floatValue];
        CGFloat pricefloat = [model.orderprice floatValue];
        CGFloat sums = numfloat*pricefloat;
        NSString *sunstr = [NSString stringWithFormat:@"%f",sums];
        [sumarr addObject:sunstr];
    }
    
    sum = [[sumarr valueForKeyPath:@"@sum.floatValue"] floatValue];
    NSString *strsum = [NSString stringWithFormat:@"%.2f",sum];
    self.btnView.pricelab.text = [NSString stringWithFormat:@"%@%@",@"合计：",strsum];
    
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *urlstr = [NSString stringWithFormat:get_confirmOrder,userid,token,self.goods_typestr];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    
    
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        if ([[dic objectForKey:@"code"] intValue]==200) {

            NSDictionary *datadit = [dic objectForKey:@"data"];
            self.addressdit = [datadit objectForKey:@"address"];
//            self.discountdit = [datadit objectForKey:@"discount"];
            [self.submittableView reloadData];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
}

#pragma mark - getters

-(UITableView *)submittableView
{
    if(!_submittableView)
    {
        _submittableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _submittableView.dataSource = self;
        _submittableView.delegate = self;
    }
    return _submittableView;
}

-(subbuttomView *)btnView
{
    if(!_btnView)
    {
        _btnView = [[subbuttomView alloc] init];
        _btnView.frame = CGRectMake(0, kScreenH-80*HEIGHT_SCALE, kScreenW, 80*HEIGHT_SCALE);
        [_btnView.submitBtn addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnView;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return self.orderDatasource.count;
    }
    if (section==2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        submitorderCell0 *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid0];
        cell = [[submitorderCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid0];
        [cell setdata:self.addressdit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    if (indexPath.section==1) {
        submitorderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid1];
        cell = [[submitorderCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid1];
        [cell setdata:self.orderDatasource[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==2) {
        submitorderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid2];
        cell = [[submitorderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid2];
        if ([strisNull isNullToString:[self.discountdit objectForKey:@"discount_jian"]]) {
            cell.numlab.text = @"选择优惠券";
        }
        else
        {
            cell.numlab.text = [NSString stringWithFormat:@"%@%@",[self.discountdit objectForKey:@"discount_jian"],@"元"];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60*HEIGHT_SCALE;
    }
    if (indexPath.section==1) {
        return 140*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        return 40*HEIGHT_SCALE;
    }
    return 0;
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
    if (indexPath.section==0) {
        ShouHuoDiZhiTVC *shouhuovc = [[ShouHuoDiZhiTVC alloc] init];
        [self.navigationController pushViewController:shouhuovc animated:YES];
    }
    if (indexPath.section==2) {
        discountTVC *disvc = [[discountTVC alloc] init];
        [self.navigationController pushViewController:disvc animated:YES];
    }
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交订单

-(void)submitclick
{
//    user_id true string 用户id
//    api_token true string 用户token
//    goods_id true string 商品id 多商品(,)隔开
//    goods_type true string 商品类型 1商品 2门票 3住宿 4餐饮 5 美食
//    number true string 商品数量
//    address_id false string 收货地址
//    appoint_time false string 预约时间 (-)号隔开
//    discount_id false string 优惠券id
//    order_userphone false string goods_type 为234必填
//    order_username false string goods_type 为234必填
//    now false string 是否立即下单
    
   
    NSMutableArray *goods_idarr = [NSMutableArray array];
    for (int i = 0; i<self.orderDatasource.count; i++) {
        submitorderModel *model = [self.orderDatasource objectAtIndex:i];
        NSString *goodsid = model.goods_id;
        [goods_idarr addObject:goodsid];
    }
    
    
    NSString *user_id = [userDefault objectForKey:user_key_user_id];
    NSString *api_token = [userDefault objectForKey:user_key_token];
    NSString *goods_id = [goods_idarr componentsJoinedByString:@","];;
    NSString *goods_type = self.goods_typestr;
    NSString *number = @"1";
    
    NSString *address_id = @"";
    NSString *order_userphone = @"";
    NSString *order_username = @"";
    
    
    
    //addressid
    if ([strisNull isNullToString:[self.addressdit objectForKey:@"addid"]]&&[strisNull isNullToString:[self.addressdit objectForKey:@"address_id"]]) {
        address_id = @"";
    }
    else if([strisNull isNullToString:[self.addressdit objectForKey:@"address_id"]])
    {
        address_id = [self.addressdit objectForKey:@"addid"];
    }
    else
    {
        address_id = [self.addressdit objectForKey:@"address_id"];
    }
    
    //addressname
    
    if ([strisNull isNullToString:[self.addressdit objectForKey:@"name"]]&&[strisNull isNullToString:[self.addressdit objectForKey:@"address_name"]]) {
        order_username = @"";
    }
    else if([strisNull isNullToString:[self.addressdit objectForKey:@"address_name"]])
    {
         order_username = [self.addressdit objectForKey:@"name"];
    }
    else
    {
        order_username = [self.addressdit objectForKey:@"address_name"];
    }
    
    //addressphone
    
    if ([strisNull isNullToString:[self.addressdit objectForKey:@"phone"]]&&[strisNull isNullToString:[self.addressdit objectForKey:@"address_phone"]]) {
        order_userphone = @"";
    }
    else if([strisNull isNullToString:[self.addressdit objectForKey:@"address_phone"]])
    {
        order_userphone = [self.addressdit objectForKey:@"phone"];
    }
    else
    {
        order_userphone = [self.addressdit objectForKey:@"address_phone"];
    }
    
    NSString *appoint_time = @"";
    appoint_time = [strisNull getNowTimeTimestamp];
    
    
    NSString *discount_id = [self.discountdit objectForKey:@"discount_id"];
    
    NSDictionary *para = @{@"user_id":user_id,@"api_token":api_token,@"goods_id":goods_id,@"goods_type":goods_type,@"number":number,@"address_id":address_id,@"appoint_time":appoint_time,@"discount_id":discount_id,@"order_userphone":order_userphone,@"order_username":order_username};
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 关闭状态来网络请求指示
    [manager POST:post_placeOrder parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res-----%@",responseObject);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
        if ([[responseObject objectForKey:@"code"] intValue]==200) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            self.order_snstr = [data objectForKey:@"order_sn"];
            NSString *hud = [responseObject objectForKey:@"message"];
            [MBProgressHUD showSuccess:hud];
            confirmorderVC *confirVC = [[confirmorderVC alloc] init];
            [self.navigationController pushViewController:confirVC animated:YES];
        }
        else
        {
            [MBProgressHUD showSuccess:@"请检查信息"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"=====/n%@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        

    }];
    
}

-(void)kvc01:(NSNotification *)notifocation
{
    NSDictionary *dic = [notifocation object];
    NSLog(@"kvc1dic--------%@",dic);
    self.addressdit = dic;
    [self.submittableView reloadData];
}

-(void)kvc02:(NSNotification *)notifocation
{
    NSDictionary *dic = [notifocation object];
    NSLog(@"kvc2dic---------%@",dic);
    
    NSMutableArray *sumarr = [NSMutableArray array];
    
    for (int i = 0; i<self.orderDatasource.count; i++) {
        submitorderModel *model = [self.orderDatasource objectAtIndex:i];
        CGFloat numfloat = [model.ordernumber floatValue];
        CGFloat pricefloat = [model.orderprice floatValue];
        CGFloat sums = numfloat*pricefloat;
        NSString *sunstr = [NSString stringWithFormat:@"%f",sums];
        [sumarr addObject:sunstr];
    }
    CGFloat sum = 0.0;
    sum = [[sumarr valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat manfloat = [[dic objectForKey:@"discount_man"] floatValue];
    if (sum>manfloat||sum==manfloat) {
        self.discountdit = dic;
    }
    [self.submittableView reloadData];
}

- (void)dealloc{
    //[super dealloc];
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
