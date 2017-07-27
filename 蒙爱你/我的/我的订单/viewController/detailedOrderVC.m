//
//  detailedOrderVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "detailedOrderVC.h"
#import "detailCell0.h"
#import "detailCell1.h"

@interface detailedOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *detailtableView;

@property (nonatomic,strong) NSDictionary *detaldic;

@property (nonatomic,strong) NSString *orderidstr;
@property (nonatomic,strong) NSString *firsttimestr;
@property (nonatomic,strong) NSString *lasttimestr;
@property (nonatomic,strong) NSString *addresssstr;
@property (nonatomic,strong) NSString *pricestr;

@end

static NSString *detalcellidentfid0 = @"detalcellidentfid0";
static NSString *detalcellidentfid1 = @"detalcellidentfid1";

@implementation detailedOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.detaldic = [NSDictionary dictionary];
    self.detailtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.detailtableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)detailtableView
{
    if(!_detailtableView)
    {
        _detailtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _detailtableView.dataSource = self;
        _detailtableView.delegate = self;
    }
    return _detailtableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
    {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        detailCell0 *cell = [tableView dequeueReusableCellWithIdentifier:detalcellidentfid0];
        cell = [[detailCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalcellidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        detailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:detalcellidentfid1];
        cell = [[detailCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalcellidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"text";
        if (indexPath.row==0) {
            cell.textLabel.text = @"订单编号：";
            
        }
        if (indexPath.row==1) {
            
        }
        if (indexPath.row==2) {
            
        }
        if (indexPath.row==3) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==4) {
            
        }
        return cell;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 140*HEIGHT_SCALE;
    }else
    {
        return 40*HEIGHT_SCALE;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else
    {
        return 0.01f;
    }
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
