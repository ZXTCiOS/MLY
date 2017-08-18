//
//  LaunchViewController.m
//  蒙爱你
//
//  Created by apple on 17/8/17.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *file = [[NSBundle mainBundle] pathForResource:@"launching" ofType:@"jpg"];
    UIImageView *img = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:img];
    //img.image = [UIImage imageWithContentsOfFile:file];
    img.image = [UIImage imageNamed:@"launching"];
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
