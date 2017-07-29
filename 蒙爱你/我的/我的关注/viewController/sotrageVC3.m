//
//  sotrageVC3.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "sotrageVC3.h"
#import "shoucanggoodsCell0.h"
#import "shoucanggoodsCell1.h"
#import "shoucanggoodsModel.h"
@interface sotrageVC3 ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *goodstableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *goodsshoucangidentfid0 = @"goodsshoucangidentfid0";
static NSString *goodsshoucangidentfid1 = @"goodsshoucangidentfid1";

@implementation sotrageVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    self.goodstableView.tableFooterView = [UIView new];
    pn = 1;
    [self addHeader];
    [self addFooter];
    
    [self.view addSubview:self.goodstableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.goodstableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.goodstableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.goodstableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    pn = 1;
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    userid = @"1";
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"4",@"1"];
    [self.dataSource removeAllObjects];
    [DNNetworking getWithURLString:url success:^(id obj) {
        NSLog(@"obj-------%@",obj);
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                shoucanggoodsModel *model = [[shoucanggoodsModel alloc] init];
                model.recommend_id = [dit objectForKey:@"recommend_id"];
                model.user_id = [dit objectForKey:@"user_id"];
                model.recommend_pid = [dit objectForKey:@"recommend_pid"];
                model.recommend_type = [dit objectForKey:@"recommend_type"];
                model.time = [dit objectForKey:@"time"];
                model.goods_id = [dit objectForKey:@"goods_id"];
                model.goods_name = [dit objectForKey:@"goods_name"];
                model.goods_pic = [dit objectForKey:@"goods_pic"];
                model.goods_price = [dit objectForKey:@"goods_price"];
                model.goods_lownum = [dit objectForKey:@"goods_lownum"];
                model.goods_lowprice = [dit objectForKey:@"goods_lowprice"];
                model.goods_intro = [dit objectForKey:@"goods_intro"];
                model.goods_description = [dit objectForKey:@"goods_description"];
                model.goods_type = [dit objectForKey:@"goods_type"];
                [self.dataSource addObject:model];
            }
            [self.goodstableView reloadData];
        }else
        {
            
        }
        [self.goodstableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.goodstableView.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"4",pnstr];
    [DNNetworking getWithURLString:url success:^(id obj) {
        NSLog(@"obj-------%@",obj);
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                shoucanggoodsModel *model = [[shoucanggoodsModel alloc] init];
                model.recommend_id = [dit objectForKey:@"recommend_id"];
                model.user_id = [dit objectForKey:@"user_id"];
                model.recommend_pid = [dit objectForKey:@"recommend_pid"];
                model.recommend_type = [dit objectForKey:@"recommend_type"];
                model.time = [dit objectForKey:@"time"];
                model.goods_id = [dit objectForKey:@"goods_id"];
                model.goods_name = [dit objectForKey:@"goods_name"];
                model.goods_pic = [dit objectForKey:@"goods_pic"];
                model.goods_price = [dit objectForKey:@"goods_price"];
                model.goods_lownum = [dit objectForKey:@"goods_lownum"];
                model.goods_lowprice = [dit objectForKey:@"goods_lowprice"];
                model.goods_intro = [dit objectForKey:@"goods_intro"];
                model.goods_description = [dit objectForKey:@"goods_description"];
                model.goods_type = [dit objectForKey:@"goods_type"];
                [self.dataSource addObject:model];
            }
            [self.goodstableView reloadData];
        }else
        {
            
        }
        [self.goodstableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.goodstableView.mj_footer endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)goodstableView
{
    if(!_goodstableView)
    {
        _goodstableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-44)];
        _goodstableView.dataSource = self;
        _goodstableView.delegate = self;
        
    }
    return _goodstableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        shoucanggoodsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:goodsshoucangidentfid0];
        cell = [[shoucanggoodsCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsshoucangidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.dataSource[indexPath.section]];
        
        return cell;
    }
    if (indexPath.row==1) {
        shoucanggoodsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:goodsshoucangidentfid1];
        cell = [[shoucanggoodsCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsshoucangidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.dataSource[indexPath.section]];
        cell.delegate = self;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120*HEIGHT_SCALE;
    }else
    {
        return 45*HEIGHT_SCALE;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - celldelegate

-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.goodstableView indexPathForCell:cell];
    shoucanggoodsModel *model = self.dataSource[index.section];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *recommend_id = model.recommend_id;
    
    NSString *urlstr = [NSString stringWithFormat:get_quxiaoshoucang,userid,recommend_id];
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
        [self.goodstableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)myTabVClick2:(UITableViewCell *)cell
{
    NSLog(@"购买");
}

@end
