//
//  RegisterViewController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "RegisterViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *teleNum;

@property (weak, nonatomic) IBOutlet UITextField *code;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *passwordCertify;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XDFactory addBackItemForVC:self];
    self.navigationItem.title = @"注册";
    [self setCornerRadius];
}

- (void)setCornerRadius{
    self.teleNum.layer.cornerRadius = 8;
    self.teleNum.layer.masksToBounds = YES;
    self.code.layer.cornerRadius = 8;
    self.code.layer.masksToBounds = YES;
    self.getCodeBtn.layer.cornerRadius = 8;
    self.getCodeBtn.layer.masksToBounds = YES;
    self.password.layer.cornerRadius = 8;
    self.password.layer.masksToBounds = YES;
    self.passwordCertify.layer.cornerRadius = 8;
    self.passwordCertify.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 8;
    self.loginBtn.layer.masksToBounds = YES;
}


- (IBAction)getCodeClicked:(UIButton *)sender {
    
    
    if (self.teleNum.text.length != 11) {
        [self.view showWarning:@"手机号错误,请重新输入"];
        [self.teleNum becomeFirstResponder];
        return;
    }
    
    
    
    // 发送验证码
    [DNNetworking postWithURLString:get_yanzhengma parameters:@{@"phone": self.teleNum.text} success:^(id obj) {
        
        sender.enabled = NO;
        __block NSInteger time = 5;
        [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
            time--;
            sender.tintColor = [UIColor clearColor];
            sender.backgroundColor = [UIColor clearColor];
            //sender.titleLabel.text = [NSString stringWithFormat:@"%ld秒后再试", time];
            [sender setTitle:@(time).stringValue forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor grayColor];
            if (!time) {
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.enabled = YES;
                [timer invalidate];
                sender.backgroundColor = [UIColor colorWithRed:225/225.0 green:53/225.0 blue:121/225.0 alpha:1];
            }
        } repeats:YES];
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *data = [obj valueForKey:@"data"];
            NSString *v = [NSString stringWithFormat:@"%@",[data valueForKey:@"verify"]];
            self.code.text = v;
        } else {
            [self.view showWarning:[obj valueForKey:@"message"]];
        }
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
    
    
    
    
    
    
    
    
}


- (IBAction)registerBtnClicked:(id)sender {
    
    if (self.password.text.length < 6) {
        [self.view showWarning:@"密码太短,重新输入"];
        [self.password becomeFirstResponder];
        return;
    }
    if (![self.password.text isEqualToString:self.passwordCertify.text]) {
        [self.view showWarning:@"重新输入密码"];
        self.password.text = @"";
        self.passwordCertify.text = @"";
        [self.password becomeFirstResponder];
        return;
    }
    
    NSDictionary *dic = @{@"user_phone":self.teleNum.text, @"user_pwd":self.password.text, @"code": self.code.text};
    [DNNetworking postWithURLString:post_register parameters:dic success:^(id obj) {
        
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
            if ([self.relogin isEqualToString:@"1"]) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            } else {
                TabBarController *tab = [[TabBarController alloc] init];
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = tab;
            }
        } else {
            
            [self.view showWarning:message];
            [self.teleNum becomeFirstResponder];
            self.teleNum.text = @"";
            self.password.text = @"";
        }
        
        
        
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络异常"];
    }];
    
}







- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
