//
//  sotrageVC0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "sotrageVC0.h"
#import "attractionsCell.h"
#import "attractionModel.h"

@interface sotrageVC0 ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *attractionsTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end


static NSString *attractionidentfid = @"attractionidentfid";

@implementation sotrageVC0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    pn = 1;
    self.attractionsTableView.tableFooterView = [UIView new];
    [self addHeader];
    [self addFooter];
    [self.view addSubview:self.attractionsTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.attractionsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.attractionsTableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.attractionsTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"1",@"1"];
    [self.dataSource removeAllObjects];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                attractionModel *model = [[attractionModel alloc] init];
                model.scenic_id = [dic objectForKey:@"scenic_id"];
                model.recommend_id = [dic objectForKey:@"recommend_id"];
                model.scenic_name = [dic objectForKey:@"scenic_name"];
                model.scenic_pic = [dic objectForKey:@"scenic_pic"];
                model.scenic_intro = [dic objectForKey:@"scenic_intro"];
                model.min_price = [dic objectForKey:@"min_price"];
                [self.dataSource addObject:model];
            }
            [self.attractionsTableView reloadData];
        }else
        {
            
        }
        [self.attractionsTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.attractionsTableView.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn ++ ;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"1",pnstr];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                attractionModel *model = [[attractionModel alloc] init];
                model.scenic_id = [dic objectForKey:@"scenic_id"];
                model.recommend_id = [dic objectForKey:@"recommend_id"];
                model.scenic_name = [dic objectForKey:@"scenic_name"];
                model.scenic_pic = [dic objectForKey:@"scenic_pic"];
                model.scenic_intro = [dic objectForKey:@"scenic_intro"];
                model.min_price = [dic objectForKey:@"min_price"];
                [self.dataSource addObject:model];
            }
            [self.attractionsTableView reloadData];
        }else
        {
            
        }
        [self.attractionsTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.attractionsTableView.mj_footer endRefreshing];
    }];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    attractionsCell *cell = [tableView dequeueReusableCellWithIdentifier:attractionidentfid];
    cell = [[attractionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:attractionidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150*HEIGHT_SCALE;
}

//取消收藏
-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.attractionsTableView indexPathForCell:cell];
    attractionModel *model = self.dataSource[index.row];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *recommend_id = model.recommend_id;
    
    NSString *urlstr = [NSString stringWithFormat:get_quxiaoshoucang,userid,recommend_id];
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
        [self.attractionsTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
@end
