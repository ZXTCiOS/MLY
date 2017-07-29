//
//  submitorderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitorderVC.h"

@interface submitorderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *submittableView;
@end
static NSString *submitVCidentfid0 = @"submitVCidentfid0";
static NSString *submitVCidentfid1 = @"submitVCidentfid1";
static NSString *submitVCidentfid2 = @"submitVCidentfid2";
@implementation submitorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提交订单";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.submittableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters


-(UITableView *)submittableView
{
    if(!_submittableView)
    {
        _submittableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _submittableView.dataSource = self;
        _submittableView.delegate = self;
    }
    return _submittableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
    }
    if (indexPath.section==1) {
        
    }
    if (indexPath.section==2) {
        
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 80*HEIGHT_SCALE;
    }
    if (indexPath.section==1) {
        return 160*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        return 60*HEIGHT_SCALE;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
