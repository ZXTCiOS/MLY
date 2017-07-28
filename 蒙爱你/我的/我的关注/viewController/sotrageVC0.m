//
//  sotrageVC0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "sotrageVC0.h"
#import "attractionsCell.h"
@interface sotrageVC0 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *attractionsTableView;

@end


static NSString *attractionidentfid = @"attractionidentfid";

@implementation sotrageVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.attractionsTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)attractionsTableView
{
    if(!_attractionsTableView)
    {
        _attractionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kScreenW , kScreenH-64-44)];
        _attractionsTableView.dataSource = self;
        _attractionsTableView.delegate = self;
    }
    return _attractionsTableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    attractionsCell *cell = [tableView dequeueReusableCellWithIdentifier:attractionidentfid];
    cell = [[attractionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:attractionidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150*HEIGHT_SCALE;
}

@end
