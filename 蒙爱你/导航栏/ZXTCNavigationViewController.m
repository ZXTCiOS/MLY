//
//  ZXTCNavigationViewController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ZXTCNavigationViewController.h"

@interface ZXTCNavigationViewController ()

@end

@implementation ZXTCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:20],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    //设置NavigationBar背景颜色
    //[[UINavigationBar appearance] setBarTintColor:krgb(211, 0, 52, 1)];
    //self.navigationBar.backIndicatorImage = [UIImage imageNamed:@""];
    //UIImage *bgImg = [self imageByApplyingAlpha:1];
    //[self.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    
    
    
    
}


- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha{
    CGSize size = CGSizeMake(kScreenW, 64);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, size.width, size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, nil);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
