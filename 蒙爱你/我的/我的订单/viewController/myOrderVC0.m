//
//  myOrderVC0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myOrderVC0.h"
#import "myorderCell.h"

@interface myOrderVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *ordertableView;
@end
static NSString *myordercell0 = @"myordercell0identfid";
@implementation myOrderVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.ordertableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters


-(UITableView *)ordertableView
{
    if(!_ordertableView)
    {
        _ordertableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenW , kScreenH)];
        _ordertableView.dataSource = self;
        _ordertableView.delegate = self;
    }
    return _ordertableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myorderCell *cell = [tableView dequeueReusableCellWithIdentifier:myordercell0];
    cell =  [[myorderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myordercell0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
@end
