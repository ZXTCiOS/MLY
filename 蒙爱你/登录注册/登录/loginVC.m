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

@property (weak, nonatomic) IBOutlet UIControl *QQ;

@property (weak, nonatomic) IBOutlet UIControl *WX;



@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCornerRadius];
    
    
}

- (void)setCornerRadius{
    self.QQ.layer.cornerRadius = 8;
    self.QQ.layer.masksToBounds = YES;
    self.WX.layer.cornerRadius = 8;
    self.WX.layer.masksToBounds = YES;
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
    
    NSDictionary *dic = @{@"user_phone":self.teleNum.text, @"user_pwd":self.password.text, @"type": @(1)};
    [DNNetworking postWithURLString:post_login parameters:dic success:^(id obj) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        // 为userdefaults 赋值
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        NSString *message = [NSString stringWithFormat:@"%@", [obj valueForKey:@"message"]];
        //success.intValue
        if ([code isEqualToString:@"200"]) {
            NSDictionary *data = [obj valueForKey:@"data"];
            NSString *token = [data objectForKey:@"api_token"];
            NSString *user_id = [NSString stringWithFormat:@"%@", [data objectForKey:@"user_id"]];
            [user setValue:token forKey:user_key_token];
            [user setValue:user_id forKey:user_key_user_id];
            TabBarController *tab = [[TabBarController alloc] init];
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = tab;
        } else {
            
            [self.view showWarning:message];
            [self.teleNum becomeFirstResponder];
            self.teleNum.text = @"";
            self.password.text = @"";
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
