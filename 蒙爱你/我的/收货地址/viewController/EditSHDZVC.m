//
//  EditSHDZVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/18.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "EditSHDZVC.h"
#import <UITableView+FDTemplateLayoutCell.h>

#import "MBProgressHUD+XMG.h"
@interface EditSHDZVC ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *tele;

@property (weak, nonatomic) IBOutlet UITextView *address;

@end

@implementation EditSHDZVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.name.text = @"";
//    self.tele.text = @"";
//    self.address.text = @"";
    
    self.title = @"编辑收货地址";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [XDFactory addBackItemForVC:self];
    
    [self loaddata];
}


- (IBAction)deleteBtnClicked:(id)sender {
    
    NSString *user_id = [userDefault objectForKey:user_key_user_id];
    NSString *api_token = [userDefault objectForKey:user_key_token];
    NSString *address_id = self.addressidstr;
    NSDictionary *para = @{@"user_id":user_id,@"api_token":api_token,@"address_id":address_id};
    
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [manager POST:post_addressDelete parameters:para progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"dic-----%@",dic);
         
         
         if ([[dic objectForKey:@"code"] intValue]==400) {
             loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
             vc.relogin = @"1";
             ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
             [self.navigationController presentViewController:navi animated:YES completion:^{
                 
             }];
         }
         
         if ([[dic objectForKey:@"code"] intValue]==200) {
             [MBProgressHUD showSuccess:@"删除成功"];
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [MBProgressHUD showSuccess:@"请检查输入"];
         }
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"=====/n%@",error);
         [self.view showWarning:@"网络错误"];
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
     }];
    
}


-(void)loaddata
{
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *url = [NSString stringWithFormat:get_address,userid,token,self.addressidstr];
    
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
            NSArray *ditarr = [responseObject objectForKey:@"data"];
            NSDictionary *dit = [ditarr objectAtIndex:0];
            NSString *namestr = [dit objectForKey:@"address_name"];
            self.name.text = namestr;
            self.tele.text = [dit objectForKey:@"address_phone"];
            self.address.text = [dit objectForKey:@"address_adds"];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"=====/n%@",error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
        
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 10 : 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        NSString *str =  @"15013212661501321266150132126615013212661501321266150132126615013212661501321266";
        
        CGSize size = [str sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(self.address.size.width, 300) mode:NSLineBreakByCharWrapping];
        return size.height;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        // 点击保存按钮
        
        NSString *user_id = [userDefault objectForKey:user_key_user_id];
        NSString *api_token = [userDefault objectForKey:user_key_token];
        NSString *address_name=self.name.text;
        NSString *address_phone=self.tele.text;
        NSString *address_adds = self.address.text;
        NSString *address_id = self.addressidstr;
        NSDictionary *para = @{@"user_id":user_id,@"api_token":api_token,@"address_name":address_name,@"address_phone":address_phone,@"address_adds":address_adds,@"address_id":address_id};
        
        
        AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
        [manager POST:post_addressEdit parameters:para progress:^(NSProgress * _Nonnull uploadProgress)
         {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             NSLog(@"dic-----%@",dic);
             
   
             
             if ([[dic objectForKey:@"code"] intValue]==400) {
                 loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                 vc.relogin = @"1";
                 ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
                 [self.navigationController presentViewController:navi animated:YES completion:^{
                     
                 }];
             }
             
             if ([[dic objectForKey:@"code"] intValue]==200) {
                 [MBProgressHUD showSuccess:@"修改成功"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [MBProgressHUD showSuccess:@"请检查输入"];
             }
             
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"=====/n%@",error);
             [self.view showWarning:@"网络错误"];
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];// 关闭状态来网络请求指示
         }];

    }
}

- (void)textViewDidChange:(UITextView *)textView{
    /*
    CGRect boudns = textView.bounds;
    CGSize maxSize = CGSizeMake(boudns.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    size = newSize;
    maxSize = CGSizeMake(boudns.size.width, newSize.height);
    boudns.size = maxSize;
    textView.bounds = boudns;
     */
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}








@end
