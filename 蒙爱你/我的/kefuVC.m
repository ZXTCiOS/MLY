//
//  kefuVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "kefuVC.h"
#import<WebKit/WebKit.h>
@interface kefuVC ()
@property (nonatomic,strong) WKWebView *webview;
@end

@implementation kefuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"客服中心";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(WKWebView *)webview
{
    if(!_webview)
    {
        NSString *urlstr = [NSString stringWithFormat:get_config,@"2"];
        _webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    }
    return _webview;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
