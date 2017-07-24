//
//  loginVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "loginVC.h"
#import "RegisterViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "WKWedViewController.h"


@interface loginVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UITextField *teleNum;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCornerRadius];
    
    
}

- (void)setCornerRadius{
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    self.teleNum.layer.cornerRadius = 8;
    self.teleNum.layer.masksToBounds = YES;
    self.password.layer.cornerRadius = 8;
    self.password.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 8;
    self.loginBtn.layer.masksToBounds = YES;
}

- (IBAction)WeChatLogin:(id)sender {
}

- (IBAction)QQLogin:(id)sender {
}

- (IBAction)VisitorLogin:(id)sender {
    //  清空 userdefaults
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    TabBarController *tab = [[TabBarController alloc] init];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = tab;
}





- (IBAction)loginBtnClicked:(UIButton *)sender {
    
    if (self.teleNum.text.length != 11) {
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入正确的手机号" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *qued = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self. teleNum becomeFirstResponder];
        }];
        [a addAction:qued];
        [self.navigationController presentViewController:a animated:YES completion:nil];
        return;
    
    }else if (!self.password.text.length){
        UIAlertController *a = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入密码" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *qued = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.password becomeFirstResponder];
        }];
        [a addAction:qued];
        [self.navigationController presentViewController:a animated:YES completion:nil];
        return;
    }
    
    NSDictionary *dic = @{@"phone":self.teleNum.text, @"pwd":self.password.text};
    [DNNetworking postWithURLString:post_login parameters:dic success:^(id obj) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        // 为userdefaults 赋值
        NSString *success = [NSString stringWithFormat:@"%@", [obj objectForKey:@"message"]];
        NSString *error = [NSString stringWithFormat:@"%@", [obj objectForKey:@"error"]];
        //success.intValue
        if ([success isEqualToString:@"1"]) {
            NSString *token = [obj objectForKey:@"token"];
            NSString *user_id = [NSString stringWithFormat:@"%@", [obj objectForKey:@"user_id"]];
            [user setObject:token forKey:user_key_token];
            [user setObject:user_id forKey:user_key_user_id];
            TabBarController *tab = [[TabBarController alloc] init];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = tab;
        } else {
            if ([error isEqualToString:@"0"]) {
                [self.view showWarning:@"账号不存在"];
                [self.teleNum becomeFirstResponder];
                self.teleNum.text = @"";
            } else if (error.intValue){
                [self.view showWarning:@"密码错误"];
                self.password.text = @"";
                [self.password becomeFirstResponder];
            }
        }
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
}



- (IBAction)registerBtnClicked:(UIButton *)sender {
    
}

- (IBAction)fogetPwd:(UIButton *)sender {
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
