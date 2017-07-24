//
//  RegisterViewController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "RegisterViewController.h"

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
    
    
    // 发送验证码
    [DNNetworking getWithURLString:get_yanzhengma parameters:@{@"tele": self.teleNum.text} success:^(id obj) {
        
        
        
        
        
        
        
        
        
        
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
    
    
    
    sender.enabled = NO;
    __block NSInteger time = 59;
    [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        time--;
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
    
    NSDictionary *dic = @{@"phone":self.teleNum.text, @"pwd":self.password.text, @"code": self.code.text};
    [DNNetworking postWithURLString:post_register parameters:dic success:^(id obj) {
        
        //1 信息不完整 2 不能重复注册
        NSString *error_code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"error_code"]];
        if ([error_code isEqualToString:@"1"]) {
            [self.view showWarning:@"信息不完整"];
        } else if ([error_code isEqualToString:@"2"]) {
            [self.view showWarning:@"重复注册"];
        }
        
        
        
        
        if ([obj objectForKey:@"message"]) {
            NSString *user_id = [NSString stringWithFormat:@"%@", obj[@"user_id"]];
            NSString *token = [obj objectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
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
