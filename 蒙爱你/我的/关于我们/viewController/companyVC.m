//
//  companyVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/2.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "companyVC.h"
#import<WebKit/WebKit.h>
@interface companyVC ()
@property (nonatomic,strong) WKWebView *webview;

@end

@implementation companyVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
        NSString *urlstr = [NSString stringWithFormat:get_config,@"3"];
        _webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
        NSURL *url = [NSURL URLWithString:urlstr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webview loadRequest:request];
    }
    return _webview;
}



@end
