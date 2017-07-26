//
//  MyListVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyListVC.h"
#import "CKPagingManager.h"
#import "myOrderVC0.h"
#import "myOrderVC1.h"
#import "myOrderVC2.h"
#import "myOrderVC3.h"
#import "myOrderVC4.h"
#import "myOrderVC5.h"
#import "myOrderVC6.h"

@interface MyListVC ()<IPagingManager>
@property (nonatomic,strong) CKPagingManager *manager;

@end

@implementation MyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.manager = [CKPagingManager manager];
    self.manager.delegate = self;
    
    [self.manager loadPagingWithConfig:^(CKSegmentBarConfig *config) {
        //标题普通颜色
        config.nor_color([UIColor colorWithHexString:@"333333"]);
        //标题选中颜色
        config.sel_color([UIColor colorWithHexString:@"df0842"]);
        //下划线颜色
        config.line_color([UIColor colorWithHexString:@"df0842"]);
        //选项卡背景颜色
        config.backgroundColor = [UIColor clearColor];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
/**
 控制器集合
 @return 控制器集合
 */

- (NSArray<UIViewController *> *)pagingControllerComponentChildViewControllers {
    
    return @[[myOrderVC0 new],
             [myOrderVC1 new],
             [myOrderVC2 new],
             [myOrderVC3 new],
             [myOrderVC4 new],
             [myOrderVC5 new],
             [myOrderVC6 new]
             ];
}

/**
 选项卡标题
 
 @return @[]
 */
- (NSArray<NSString *> *)pagingControllerComponentSegmentTitles {
    
    return @[@"待付款",@"已付款",
             @"待发货",@"已发货",
             @"退款／售后",@"已完成",@"全部"];
}

/**
 选项卡位置 中间控制器view 高度
 
 @return CGFloat
 */

- (CGFloat)pagingControllerComponentContainerViewHeight {
    
    return self.view.bounds.size.height - 64;
}

- (CKPagingComponentBarStyle)style {
    
    return CKPagingComponentStyleNormal;
}

- (CGRect)pagingControllerComponentSegmentFrame {
    
    return CGRectMake(0, 64, self.view.bounds.size.width, 44);
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
