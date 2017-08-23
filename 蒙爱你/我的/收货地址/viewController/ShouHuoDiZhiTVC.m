//
//  ShouHuoDiZhiTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShouHuoDiZhiTVC.h"
#import "ShouHuoDiZhiCell.h"
#import "NewAddressCell.h"
#import "AddAddressTVC.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "EditSHDZVC.h"

#import "addressModel.h"

@interface ShouHuoDiZhiTVC ()<mycellVdelegate>
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ShouHuoDiZhiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDiZhiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[NewAddressCell class] forCellReuseIdentifier:@"new"];
    self.title = @"收货地址";
    self.dataSource = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loaddata];
}

#pragma mark - lodaddata

-(void)loaddata
{
    [self.dataSource removeAllObjects];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *url = [NSString stringWithFormat:get_address,userid,token,@""];

    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
                    NSArray *data = [responseObject objectForKey:@"data"];
                    
                    if ([data isKindOfClass:[NSArray class]]) {
                        for (int i = 0; i<data.count; i++) {
                            NSDictionary *dic = [data objectAtIndex:i];
                            addressModel *model = [[addressModel alloc] init];
                            model.address_adds = [dic objectForKey:@"address_adds"];
                            model.address_id = [dic objectForKey:@"address_id"];
                            model.address_phone = [dic objectForKey:@"address_phone"];
                            model.address_pid = [dic objectForKey:@"address_pid"];
                            model.address_name = [dic objectForKey:@"address_name"];
                            model.isDefaultstr = @"0";
                            model.time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
                            [self.dataSource addObject:model];
                        }
                        [self.tableView reloadData];
                    }
                   
                }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"=====/n%@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.dataSource.count;
    }else
    {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ShouHuoDiZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        //    cell.nameL.text = @"啦啊啊啊啊";
        //    cell.tele.text = @"0216543521";
        [cell setdata:self.dataSource[indexPath.row]];
        [cell.isDefault setBackgroundImage:[UIImage imageNamed:@"dd-fkcg"] forState:UIControlStateNormal];
        cell.delegate = self;
        //    cell.addressL.text = @"l 类似大幅度开发工具数量的看法法律手段会计法发斯蒂芬斯蒂芬;lfkjsd";
        cell.edit = ^(){
            UIStoryboard *stb = [UIStoryboard storyboardWithName:@"SHDZ" bundle:nil];
            EditSHDZVC *vc = [stb instantiateViewControllerWithIdentifier:@"edit"];
            addressModel *model = self.dataSource[indexPath.row];
            vc.addressidstr = model.address_id;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        NewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"new" forIndexPath:indexPath];
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 45;
    }
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(ShouHuoDiZhiCell *cell) {
        cell.nameL.text = @"啦啊啊啊啊";
        cell.tele.text = @"0216543521";
        [cell.isDefault setImage:[UIImage imageNamed:@"dd-fkcg"] forState:UIControlStateNormal];
        cell.addressL.text = @"l 类似大幅度开发工具数量的看法法律手段会计法发斯蒂芬斯蒂芬;lfkjsd";
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==1) {
        
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"SHDZ" bundle:nil];
        AddAddressTVC *vc = [st instantiateViewControllerWithIdentifier:@"add"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section==0) {

    }
    
}

#pragma mark - 选择按钮

-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    NSLog(@"选择按钮");
    addressModel *model = self.dataSource[index.row];
    model.isDefaultstr = @"1";
    [self.tableView reloadData];
    
    NSDictionary *dic = @{@"name":model.address_name,@"phone":model.address_phone,@"addid":model.address_id,@"addressass":model.address_adds};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addresskvc" object:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
