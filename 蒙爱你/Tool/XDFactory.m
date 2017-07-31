//
//  XDFactory.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "XDFactory.h"
#import <MBProgressHUD.h>
@implementation XDFactory



+ (void)addSearchItemForVC:(UIViewController *)vc clickedHandler:(void (^)())handler{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"ss"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"ss-xss"] forState:UIControlStateHighlighted];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn bk_addEventHandler:^(id sender) {
        !handler ?: handler();
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 0;
    vc.navigationItem.rightBarButtonItems = @[spaceItem, backItem];
}


+ (void)addBackItemForVC:(UIViewController *)vc{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"dh-fh"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"dh-fh"] forState:UIControlStateHighlighted];
    backBtn.frame = CGRectMake(0, 0, 45, 44);
    [backBtn bk_addEventHandler:^(id sender) {
        [vc.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    //配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.leftBarButtonItems = @[spaceItem, backItem];
}








@end
