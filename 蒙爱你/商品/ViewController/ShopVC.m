//
//  ShopVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShopVC.h"
#import "commodityCell.h"
#import "ShopDetailVC.h"

#import "MBProgressHUD+XMG.h"
#import "ShopGoodsModel.h"

@interface ShopVC ()
{
    int pn1;
    int pn2;
    int pn3;
}
@property (nonatomic, strong) ShopViewModel *viewmodel;
@property (nonatomic,  assign) ShopType type;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    pn1 = 1;
    pn2 = 1;
    pn3 = 1;
    self.dataSource = [NSMutableArray array];
    [self addHeader];
    [self addFooter];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([commodityCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    if (self.type==ShopTypeSovenir) {
        NSLog(@"纪念品");
        
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *urlstr = [NSString stringWithFormat:get_shop_sovenir,userid,@"1"];
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            [self.dataSource removeAllObjects];
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endHeaderRefresh];
        } failure:^(NSError *error) {
            [self.tableView endHeaderRefresh];
        }];
    }
    if (self.type==ShopTypeArt) {
        NSLog(@"艺术品");
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *urlstr = [NSString stringWithFormat:get_shop_art,userid,@"1"];
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            [self.dataSource removeAllObjects];
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endHeaderRefresh];
        } failure:^(NSError *error) {
            [self.tableView endHeaderRefresh];
        }];

    }
    if (self.type==ShopTypeFood) {
        NSLog(@"食品");
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *urlstr = [NSString stringWithFormat:get_shop_food,userid,@"1"];
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            [self.dataSource removeAllObjects];
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endHeaderRefresh];
        } failure:^(NSError *error) {
            [self.tableView endHeaderRefresh];
        }];

    }
}

-(void)footerRefreshEndAction
{
    if (self.type==ShopTypeSovenir) {
        NSLog(@"纪念品");
        pn1 ++;
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *pnstr = [NSString stringWithFormat:@"%d",pn1];
        NSString *urlstr = [NSString stringWithFormat:get_shop_sovenir,userid,pnstr];
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endFooterRefresh];
        } failure:^(NSError *error) {
            [self.tableView endFooterRefresh];
        }];
    }
    if (self.type==ShopTypeArt) {
        NSLog(@"艺术品");
        pn2 ++;
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *pnstr = [NSString stringWithFormat:@"%d",pn2];
        NSString *urlstr = [NSString stringWithFormat:get_shop_art,userid,pnstr];
        
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endFooterRefresh];
        } failure:^(NSError *error) {
            [self.tableView endFooterRefresh];
        }];
    }
    if (self.type==ShopTypeFood) {
        NSLog(@"食品");
        pn3 ++;
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *pnstr = [NSString stringWithFormat:@"%d",pn3];
        NSString *urlstr = [NSString stringWithFormat:get_shop_food,userid,pnstr];
        
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            if ([[obj objectForKey:@"code"] intValue]==200) {
                NSArray *dataArr = [obj objectForKey:@"data"];
                for (int i = 0; i<dataArr.count; i++) {
                    ShopGoodsModel *model = [[ShopGoodsModel alloc] init];
                    NSDictionary *dit = [dataArr objectAtIndex:i];
                    model.goods_id = [[dit objectForKey:@"goods_id"] intValue];
                    model.goods_img = [dit objectForKey:@"goods_pic"];
                    model.goods_name = [dit objectForKey:@"goods_name"];
                    model.goods_type = [[dit objectForKey:@"goods_type"] intValue];
                    model.goods_price = [[dit objectForKey:@"goods_price"] intValue];
                    if ([[dit objectForKey:@"is_shoucang"] intValue]==0) {
                        model.isStored = NO;
                    }else
                    {
                        model.isStored = YES;
                    }
                    model.time = [[dit objectForKey:@"time"] intValue];
                    model.goods_lownum = [[dit objectForKey:@"goods_lownum"] intValue];
                    model.goods_lowprice = [[dit objectForKey:@"goods_lowprice"] intValue];
                    model.goods_detail = [dit objectForKey:@"goods_intro"];
                    model.goods_description = [dit objectForKey:@"goods_description"];
                    [self.dataSource addObject:model];
                }
                [self.tableView reloadData];
            }else
            {
                NSString *toast = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:toast];
            }
            [self.tableView endFooterRefresh];
        } failure:^(NSError *error) {
            [self.tableView endFooterRefresh];
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    commodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataSource.count==0) {
        return;
    }
    ShopGoodsModel *model = self.dataSource[indexPath.row];
    
    NSString *idstr = [NSString stringWithFormat:@"%ld",(long)model.goods_id];
    NSString *imgstr = model.goods_img;
    NSString *namestr = model.goods_name;
    NSString *typestr = [NSString stringWithFormat:@"%ld",(long)model.goods_type];
    NSString *pricestr = [NSString stringWithFormat:@"%ld",(long)model.goods_price];
    NSString *introstr = model.goods_detail;
    NSString *descripstr = model.goods_description;
    ShopDetailVC *vc = [[ShopDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.infodic = [NSDictionary dictionary];
    vc.infodic = @{@"id":idstr,@"img":imgstr,@"name":namestr,@"type":typestr,@"price":pricestr,@"descrip":descripstr,@"intro":introstr};
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (ShopViewModel *)viewmodel{
    if(!_viewmodel) {
        _viewmodel = [[ShopViewModel alloc] initWithShopType:self.type];
    }
    return _viewmodel;
}

- (instancetype)initWithShopType:(ShopType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

@end
