//
//  detailedOrderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "detailedOrderVC.h"
#import "detailCell0.h"
#import "detailCell1.h"
#import "strisNull.h"
#import "myOrderModel.h"

@interface detailedOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *detailtableView;



@property (nonatomic,strong) NSString *orderidstr;
@property (nonatomic,strong) NSString *firsttimestr;
@property (nonatomic,strong) NSString *lasttimestr;
@property (nonatomic,strong) NSString *ordertimestr;

@property (nonatomic,strong) NSString *addresssstr;
@property (nonatomic,strong) NSString *pricestr;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

static NSString *detalcellidentfid0 = @"detalcellidentfid0";
static NSString *detalcellidentfid1 = @"detalcellidentfid1";

@implementation detailedOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.dataSource = [NSMutableArray array];
    self.detailtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.detailtableView];
    
    [self loaddata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loaddata
{
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *urlstr = [NSString stringWithFormat:get_detalorder,userid,token,self.order_snstr];
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];// 开启状态来网络请求指示
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        NSLog(@"res-----%@",responseObject);
        
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        
        if ([[dic objectForKey:@"code"] intValue]==400) {
            loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            vc.relogin = @"1";
            ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:navi animated:YES completion:^{
                
            }];
        }
        
        if ([[responseObject objectForKey:@"code"] intValue]==200&&[[responseObject objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            //NSDictionary *datadic = [responseObject objectForKey:@"data"];
            
            NSArray *dataarr = [responseObject objectForKey:@"data"];
            NSDictionary *datadit = [dataarr objectAtIndex:0];
            NSString *timestr = [datadit objectForKey:@"create_time"];
            self.pricestr = [datadit objectForKey:@"order_money"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                NSDictionary *goodsdit = [dit objectForKey:@"goods"];
                myOrderModel *model = [[myOrderModel alloc] init];
                model.namestr = [goodsdit objectForKey:@"goods_name"];
                model.orderimgstr = [goodsdit objectForKey:@"goods_pic"];
                model.pricestr = [goodsdit objectForKey:@"goods_price"];
                model.contentstr = [goodsdit objectForKey:@"goods_intro"];
                model.numstr = [NSString stringWithFormat:@"%lu",(unsigned long)dataarr.count];
                [self.dataSource addObject:model];
            }
            
            self.ordertimestr = [strisNull timeWithTimeIntervalString:timestr];
            
            [self.detailtableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
    }];
}

#pragma mark - getters

-(UITableView *)detailtableView
{
    if(!_detailtableView)
    {
        _detailtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _detailtableView.dataSource = self;
        _detailtableView.delegate = self;
    }
    return _detailtableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.dataSource.count;
    }else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        detailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:detalcellidentfid0];
        cell = [[detailCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalcellidentfid0];
        [cell setdata:self.dataSource[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        detailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:detalcellidentfid1];
        cell = [[detailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalcellidentfid1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"text";
        if (indexPath.row==0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"订单编号：",self.order_snstr];
            
        }
        if (indexPath.row==1) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"下单时间：",self.ordertimestr];
            
        }
        if (indexPath.row==2) {
            NSString *str1 = @"合计：";
            NSString *str2 = self.pricestr;
            
            NSString *newstr = [NSString stringWithFormat:@"%@%@",str1,str2];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newstr];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,str1.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"df0842"] range:NSMakeRange(str1.length,str2.length)];

             cell.textLabel.attributedText = str;
            
            
        }
//        if (indexPath.row==3) {
//            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//        }
//        if (indexPath.row==4) {
//            
//        }
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140*HEIGHT_SCALE;
    }else
    {
        return 40*HEIGHT_SCALE;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else
    {
        return 0.01f;
    }
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
