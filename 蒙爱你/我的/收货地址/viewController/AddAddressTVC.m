//
//  AddAddressTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "AddAddressTVC.h"
#import "UITextView+Placeholder.h"
#import "MBProgressHUD+XMG.h"
@interface AddAddressTVC ()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameL;

@property (weak, nonatomic) IBOutlet UITextField *telephone;

@property (weak, nonatomic) IBOutlet UITextView *textView;

//@property (nonatomic, strong) UIPickerView *picker;

@end

@implementation AddAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.title = @"添加收货地址";
    self.textView.placeholder = @"省市县街道,楼层,门牌号等";
    self.textView.delegate = self;
    [XDFactory addBackItemForVC:self];
}


- (IBAction)finish:(UIButton *)sender {
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *user_id=userid;
    NSString *address_name=self.nameL.text;
    NSString *address_phone=self.telephone.text;
    NSString *address_adds = self.textView.text;
    NSString *api_token = token;
    
    NSDictionary *para = @{@"user_id":user_id,@"address_name":address_name,@"address_phone":address_phone,@"address_adds":address_adds,@"api_token":api_token};
    
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    [manager POST:post_addaddress parameters:para progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"dic-----%@",dic);
         
         if ([[dic objectForKey:@"code"] intValue]==200) {
             [MBProgressHUD showSuccess:@"添加成功"];
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

/*
- (void)showPickerView{
    [self.picker mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).equalTo(kScreenW);
    }];
}

- (void)hidePickerView{
    [self.picker mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).equalTo(0);
    }];
}


- (UIPickerView *)picker{
    if (!_picker) {
        _picker = [[UIPickerView alloc] init];
        [self.view addSubview:_picker];
        _picker.delegate = self;
        _picker.dataSource = self;
        [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kScreenW, kScreenW));
            make.top.equalTo(self.view.mas_bottom).equalTo(0);
        }];
    }
    return _picker;
}

*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        return size.height + 2 > 44 ? size.height + 2: 44;
    }
    return 44;
}

static CGSize size;
- (void)textViewDidChange:(UITextView *)textView{
    CGRect boudns = textView.bounds;
    CGSize maxSize = CGSizeMake(boudns.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    size = newSize;
    maxSize = CGSizeMake(boudns.size.width, newSize.height);
    boudns.size = maxSize;
    textView.bounds = boudns;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 10 : 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
