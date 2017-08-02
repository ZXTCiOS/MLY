//
//  MineTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MineTVC.h"
#import "ModifyInfoVC.h"
#import "MyStorageVC.h"
#import "ShouHuoDiZhiTVC.h"
#import "MyListVC.h"
#import "discountTVC.h"
#import "AboutUsVC.h"


@interface MineTVC ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *tele;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;


@end

@implementation MineTVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contentInit];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.tableFooterView = [UIView new];
//    self.icon.image = [UIImage imageNamed:@"touxiang"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loaddata];
}

-(void)loaddata
{
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *url = [NSString stringWithFormat:get_info,userid,token];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        if ([[dic objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [dic objectForKey:@"data"];
            self.name.text = [datadic objectForKey:@"user_nickname"];
            NSString *user_nickname = [datadic objectForKey:@"user_nickname"];
            NSString *user_picture = [datadic objectForKey:@"user_picture"];
            NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
            [defat setValue:user_nickname forKey:@"user_nicknamestr"];
            [defat setValue:user_picture forKey:@"user_picturestr"];
            [defat synchronize];
            [self.icon sd_setImageWithURL:[NSURL URLWithString:[datadic objectForKey:@"user_picture"]]];
            self.tele.text = [datadic objectForKey:@"user_phone"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


- (void)contentInit{
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2.0;
    self.icon.layer.masksToBounds = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"]) {
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        self.name.text = name;
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"icon"]) {
        UIImage *img = [[NSUserDefaults standardUserDefaults] objectForKey:@"icon"];
        self.icon.image = img;
        
    } else {
        self.icon.image = [UIImage imageNamed:@"icon_default"];
        
    }
}

- (IBAction)myList:(id)sender {
    MyListVC *vc = [[MyListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    }

- (IBAction)discount:(id)sender {
    discountTVC *vc = [[discountTVC alloc] initWithStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)address:(id)sender {
    ShouHuoDiZhiTVC *vc = [[ShouHuoDiZhiTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)stored:(id)sender {
    MyStorageVC *vc = [[MyStorageVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}




#pragma mark - tableview  delegate



- (IBAction)modifyInfo:(id)sender {
    ModifyInfoVC *vc = [[ModifyInfoVC alloc] initWithNibName:@"ModifyInfoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        switch (indexPath.row) {
            case 0:// 我要合作
            {
                
            }
                break;
            case 1:// 客服中心
            {
                NSString *phone = kefudianhua;
                NSLog(@"phone = %@",phone);
                
                UIWebView *webView = [[UIWebView alloc] init];
                NSString *string = [NSString stringWithFormat:@"tel://%@",phone];
                NSURL *url = [NSURL URLWithString:string];
                
                [webView loadRequest:[NSURLRequest requestWithURL:url]];
                
                [self.view addSubview:webView];
            }
                break;
            case 2:// 关于我们
            {
                AboutUsVC *vc = [[AboutUsVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            
            default:
                break;
        }
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
