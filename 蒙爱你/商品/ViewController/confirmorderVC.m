//
//  confirmorderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "confirmorderVC.h"
#import "submitorderCell0.h"
#import "submitorderCell1.h"
#import "submitorderCell2.h"
#import "subbuttomView.h"
#import "submitorderModel.h"

@interface confirmorderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *confirtableView;

@end

static NSString *confirmorderidentfid0 = @"confirmorderidentfid0";

@implementation confirmorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.confirtableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters


-(UITableView *)confirtableView
{
    if(!_confirtableView)
    {
        _confirtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
        _confirtableView.dataSource = self;
        _confirtableView.delegate = self;
    }
    return _confirtableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
