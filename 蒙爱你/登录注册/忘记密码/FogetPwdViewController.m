//
//  FogetPwdViewController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FogetPwdViewController.h"

@interface FogetPwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *teleNum;

@property (weak, nonatomic) IBOutlet UITextField *code;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *passwordCertify;

@property (weak, nonatomic) IBOutlet UIButton *getCode;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation FogetPwdViewController

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
    self.getCode.layer.cornerRadius = 8;
    self.getCode.layer.masksToBounds = YES;
    self.password.layer.cornerRadius = 8;
    self.password.layer.masksToBounds = YES;
    self.passwordCertify.layer.cornerRadius = 8;
    self.passwordCertify.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 8;
    self.submitBtn.layer.masksToBounds = YES;
}


- (IBAction)getCode:(UIButton *)sender {
    
    
}

- (IBAction)submite:(id)sender {
    
    
    
    
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
