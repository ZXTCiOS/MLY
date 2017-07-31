//
//  MyListVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyListVC.h"

#import "UIParameter.h"
#import "NinaPagerView.h"


@interface MyListVC ()
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@end

@implementation MyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.ninaPagerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = NO;
    
}


#pragma mark - NinaParaArrays

- (NSArray *)ninaTitleArray {
    return @[
             @"待付款",
             @"已付款",
             @"已发货",
             @"退款／售后",
             @"已完成",
             @"全部"
             ];
}

- (NSArray *)ninaVCsArray {
    return @[
             @"myOrderVC0",
             @"myOrderVC1",
             @"myOrderVC2",
             @"myOrderVC3",
             @"myOrderVC4",
             @"myOrderVC5",
             ];
}

#pragma mark - LazyLoad

- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        _ninaPagerView.unSelectTitleColor = [UIColor whiteColor];
        
        CGRect pagerRect = CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:vcsArray];
        _ninaPagerView.titleScale = 1;
        _ninaPagerView.unSelectTitleColor = [UIColor colorWithHexString:@"333333"];
        _ninaPagerView.selectTitleColor = [UIColor colorWithHexString:@"df0843"];
        _ninaPagerView.underlineColor = [UIColor colorWithHexString:@"df0842"];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
    }
    return _ninaPagerView;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
