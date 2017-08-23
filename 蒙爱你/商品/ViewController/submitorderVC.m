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
@property (nonatomic,strong) NSString *mingsunamestr;
@end
static NSString *submitVCidentfid0 = @"submitVCidentfid0";
static NSString *submitVCidentfid1 = @"submitVCidentfid1";
static NSString *submitVCidentfid2 = @"submitVCidentfid2";

static NSString *submitVCidentfid3 = @"submitVCidentfid3";
static NSString *submitVCidentfid4 = @"submitVCidentfid4";
static NSString *submitVCidentfid5 = @"submitVCidentfid5";
static NSString *submitVCidentfid6 = @"submitVCidentfid6";
static NSString *submitVCidentfid7 = @"submitVCidentfid7";
static NSString *submitVCidentfid8 = @"submitVCidentfid8";

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
        self.mingsunamestr = model.ordername;
        NSString *sunstr = [NSString stringWithFormat:@"%f",sums];
        [sumarr addObject:sunstr];
    }
    
    NSString *jianstr = [self.discountdit objectForKey:@"discount_jian"];
    NSString *man = [self.discountdit objectForKey:@"discount_man"];

    if ([strisNull isNullToString:man]) {
        jianstr = @"0";
    }
    else
    {
        jianstr = [self.discountdit objectForKey:@"discount_jian"];
    }
    sum = [[sumarr valueForKeyPath:@"@sum.floatValue"] floatValue];
    NSString *strsum = [NSString stringWithFormat:@"%.2f",sum];
    NSString *str1 = @"合计：";
    NSString *str2 = strsum;
    NSString *str3 = [NSString stringWithFormat:@"%@%@%@",@" (已优惠¥",jianstr,@")"];
    NSString *newstr = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newstr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,str1.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"df0842"] range:NSMakeRange(str1.length,str2.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"b3b3b3"] range:NSMakeRange(str1.length+str2.length,str3.length)];
    self.btnView.pricelab.attributedText = str;
    
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

        if ([[dic objectForKey:@"code"] intValue]==400) {
            loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            vc.relogin = @"1";
            ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:navi animated:YES completion:^{
                
            }];
        }
        
        if ([[dic objectForKey:@"code"] intValue]==200&&[[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {

            NSDictionary *datadit = [dic objectForKey:@"data"];
            NSDictionary *adddit = [datadit objectForKey:@"address"];
            
            NSString *addressass = [adddit objectForKey:@"address_adds"];
            NSString *name = [adddit objectForKey:@"address_name"];
            NSString *phone = [adddit objectForKey:@"address_phone"];
            NSString *address_id = [adddit objectForKey:@"address_id"];
            
            self.addressdit = @{@"address_id":address_id,@"addressass":addressass,@"name":name,@"phone":phone};
            
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
    if ([self.goods_typestr isEqualToString:@"3"]) {
        return 2;
    }
    else
    {
        return 3;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (section==0) {
             return self.orderDatasource.count;
        }
        else
        {
            return 4;
        }
    }
    else
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
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (indexPath.section==0) {
            submitorderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid3];
            cell = [[submitorderCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid3];
            [cell setdata:self.orderDatasource[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.section==1) {
            
            if (indexPath.row==0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid5];
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid5];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
                [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
                NSString *currentTime = [formatter stringFromDate:[NSDate date]];//将NSDate  ＊对象 转化为 NSString ＊对象。
                cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"下单时间 ",currentTime];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
                return cell;
            }
            if (indexPath.row==1) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid7];
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid7];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"预定时间:",self.yudingtime];
                
                cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
                return cell;
            }
            if (indexPath.row==2) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid8];
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid8];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"位置信息 :",self.mingsunamestr];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
                return cell;
            }
            if (indexPath.row==3) {
                submitorderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:submitVCidentfid8];
                cell = [[submitorderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitVCidentfid8];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString *str = [self.discountdit objectForKey:@"discount_jian"];
                
                if ([strisNull isNullToString:str]) {
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
            
        }
        
    }
    else
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
            
            NSString *str = [self.discountdit objectForKey:@"discount_jian"];
            
            if ([strisNull isNullToString:str]) {
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

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (indexPath.section==0) {
            return 140*HEIGHT_SCALE;
        }
        else
        {
            return 40*HEIGHT_SCALE;
        }
    }
    else
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

    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (indexPath.section==1&&indexPath.row==3) {
            discountTVC *disvc = [[discountTVC alloc] init];
            [self.navigationController pushViewController:disvc animated:YES];
        }
    }
    else
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

}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 提交订单

-(void)submitclick
{

    
   
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
    if ([self.goods_typestr isEqualToString:@"3"]) {
        order_username = self.yudingname;
        order_userphone = self.yudingphone;
    }else
    {
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

    }
    
    
    NSString *appoint_time = @"";
    if ([self.goods_typestr isEqualToString:@"3"]) {
        appoint_time = self.yudingtime;
    }
    else
    {
        appoint_time = [strisNull getNowTimeTimestamp];
    }
    
    
    NSString *discount_id = @"";
    if ([strisNull isNullToString:[self.discountdit objectForKey:@"discount_id"]]) {
        discount_id = @"";
    }
    else
    {
        discount_id = [self.discountdit objectForKey:@"discount_id"];
    }

    

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
        
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        
        if ([[dic objectForKey:@"code"] intValue]==400) {
            loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            vc.relogin = @"1";
            ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:navi animated:YES completion:^{
                
            }];
        }
        
        if ([[responseObject objectForKey:@"code"] intValue]==200) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            self.order_snstr = [data objectForKey:@"order_sn"];
            NSString *hud = [responseObject objectForKey:@"message"];
            [MBProgressHUD showSuccess:hud];
            
            confirmorderVC *confirVC = [[confirmorderVC alloc] init];
            confirVC.goods_typestr = self.goods_typestr;
            confirVC.orderDatasource = [NSMutableArray array];
            confirVC.orderDatasource = self.orderDatasource;
            confirVC.addressdit = [NSDictionary dictionary];
            confirVC.addressdit = self.addressdit;
            confirVC.discountdit = [NSDictionary dictionary];
            confirVC.discountdit = self.discountdit;
            confirVC.ordersn = self.order_snstr;
            confirVC.yudingtime = self.yudingtime;
            confirVC.mingsunamestr = self.mingsunamestr;
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
    [self loaddata];
    [self.submittableView reloadData];
    
}

- (void)dealloc{
    //[super dealloc];
    // 移除当前对象监听的事件
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
