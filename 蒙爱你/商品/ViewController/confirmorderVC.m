//
//  confirmorderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "confirmorderVC.h"
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

@interface confirmorderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *confirtableView;
@property (nonatomic,strong) subbuttomView *btnView;
@end

static NSString *confirmorderidentfid0 = @"confirmorderidentfid0";
static NSString *confirmorderidentfid1 = @"confirmorderidentfid1";
static NSString *confirmorderidentfid2 = @"confirmorderidentfid2";
static NSString *confirmorderidentfid3 = @"confirmorderidentfid3";
static NSString *confirmorderidentfid4 = @"confirmorderidentfid4";

static NSString *confirmorderidentfid5 = @"confirmorderidentfid5";
static NSString *confirmorderidentfid6 = @"confirmorderidentfid6";
static NSString *confirmorderidentfid7 = @"confirmorderidentfid7";
static NSString *confirmorderidentfid8 = @"confirmorderidentfid8";
static NSString *confirmorderidentfid9 = @"confirmorderidentfid9";
static NSString *confirmorderidentfid10 = @"confirmorderidentfid10";


@implementation confirmorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.confirtableView];
    [self loaddata];
    [self.view addSubview:self.btnView];
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
}

#pragma mark - getters


-(UITableView *)confirtableView
{
    if(!_confirtableView)
    {
        _confirtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
        _confirtableView.dataSource = self;
        _confirtableView.delegate = self;
    }
    return _confirtableView;
}
-(subbuttomView *)btnView
{
    if(!_btnView)
    {
        _btnView = [[subbuttomView alloc] init];
        _btnView.frame = CGRectMake(0, kScreenH-80*HEIGHT_SCALE, kScreenW, 80*HEIGHT_SCALE);
        [_btnView.submitBtn addTarget:self action:@selector(submitclick) forControlEvents:UIControlEventTouchUpInside];
        [_btnView.submitBtn setImage:[UIImage imageNamed:@"dd-btn-ljzf"] forState:normal];
    }
    return _btnView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if ([self.goods_typestr isEqualToString:@"3"]) {
//        return 6;
//    }
//    else
//    {
//        return 6;
//    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (section==0) {
            return self.orderDatasource.count;
        }
        else
        {
            return 1;
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
        if (section==3) {
            return 1;
        }
        if (section==4) {
            return 1;
        }

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.goods_typestr isEqualToString:@"3"]) {
        if (indexPath.section==0) {
            submitorderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid1];
            cell = [[submitorderCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid1];
            [cell setdata:self.orderDatasource[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.section==1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid3];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"订单号:",self.ordersn];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            return cell;
        }
        if (indexPath.section==2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid4];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid4];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];//将NSDate  ＊对象 转化为 NSString ＊对象。
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"下单时间 ",currentTime];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.section==3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid7];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid7];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"预定时间:",self.yudingtime];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            return cell;
        }
        if (indexPath.section==4) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid6];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid6];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"位置信息 :",self.mingsunamestr];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            return cell;
        }
        
        if (indexPath.section==5) {
            submitorderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid2];
            cell = [[submitorderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid2];
            
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
    else
    {
        if (indexPath.section==0) {
            submitorderCell0 *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid0];
            cell = [[submitorderCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid0];
            [cell setdata:self.addressdit];
            return cell;
        }
        if (indexPath.section==1) {
            submitorderCell1 *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid1];
            cell = [[submitorderCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid1];
            [cell setdata:self.orderDatasource[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.section==2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid3];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"订单号:",self.ordersn];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            return cell;
        }
        if (indexPath.section==3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid4];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid4];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];//定义时间为这种格式： YYYY-MM-dd hh:mm:ss 。
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];//将NSDate  ＊对象 转化为 NSString ＊对象。
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"下单时间 ",currentTime];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.section==4) {
            submitorderCell2 *cell = [tableView dequeueReusableCellWithIdentifier:confirmorderidentfid2];
            cell = [[submitorderCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:confirmorderidentfid2];
            
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
            return 160*HEIGHT_SCALE;
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
        if (indexPath.section==3) {
            return 40*HEIGHT_SCALE;
        }
        if (indexPath.section==4) {
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

-(void)submitclick
{
    NSString *user_id = [userDefault objectForKey:user_key_user_id];
    NSString *api_token = [userDefault objectForKey:user_key_token];
    NSString *order_sn = self.ordersn;
    NSString *order_status = @"2";
    NSString *address_id = [self.addressdit objectForKey:@"address_id"];
    NSString *discount_id = [self.discountdit objectForKey:@"discount_id"];
    NSDictionary *para = @{@"user_id":user_id,@"api_token":api_token,@"order_sn":order_sn,@"order_status":order_status,@"address_id":address_id,@"discount_id":discount_id};
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [manager POST:post_changStatus parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res-----%@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue]==200) {
            [MBProgressHUD showSuccess:@"付款成功"];
        }
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
    }];
    
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
