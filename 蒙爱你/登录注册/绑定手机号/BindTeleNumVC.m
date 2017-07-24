//
//  BindTeleNumVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "BindTeleNumVC.h"

@interface BindTeleNumVC ()

@property (weak, nonatomic) IBOutlet UITextField *teleNum;

@property (weak, nonatomic) IBOutlet UITextField *code;

@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;


@end

@implementation BindTeleNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setCornerRadius];
    [XDFactory addBackItemForVC:self];
    self.navigationItem.title = @"";
    
}

- (void)setCornerRadius{
    self.teleNum.layer.cornerRadius = 8;
    self.teleNum.layer.masksToBounds = YES;
    self.code.layer.cornerRadius = 8;
    self.code.layer.masksToBounds = YES;
    self.getCodeBtn.layer.cornerRadius = 8;
    self.getCodeBtn.layer.masksToBounds = YES;
    
    self.bindBtn.layer.cornerRadius = 8;
    self.bindBtn.layer.masksToBounds = YES;
}


- (IBAction)getCode:(UIButton *)sender {
    
    __block NSInteger time = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        [sender setTitle:[NSString stringWithFormat:@"%lds后再试", (long)time] forState:UIControlStateDisabled];
        time -= 1;
        if (time == 0) {
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    } repeats:NO];
    
}

- (IBAction)Bind:(id)sender {
    
    
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
