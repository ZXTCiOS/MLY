//
//  VerifiedVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "VerifiedVC.h"

@interface VerifiedVC ()

@end

@implementation VerifiedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"实名认证";
    [XDFactory addBackItemForVC:self];
    
    
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
