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


@interface ShopVC ()

@property (nonatomic, strong) ShopViewModel *viewmodel;

@property (nonatomic,  assign) ShopType type;

@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MJWeakSelf
//    [self.tableView addHeaderRefresh:^{
//        [weakSelf.viewmodel getDataWithRequestMode:RequestModeRefresh handler:^(NSError *error) {
//            if (!error) {
//                [weakSelf.tableView reloadData];
//                [weakSelf.tableView endHeaderRefresh];
//            } else {
//                [weakSelf.view.superview.superview showWarning:@"网络错误"];
//                [weakSelf.tableView endHeaderRefresh];
//            }
//        }];
//    }];
//    [self.tableView addFooterRefresh:^{
//        [weakSelf.viewmodel getDataWithRequestMode:RequestModeMore handler:^(NSError *error) {
//            if (!error) {
//                [weakSelf.tableView reloadData];
//                [weakSelf.tableView endFooterRefresh];
//            } else {
//                
//                [weakSelf.view.superview.superview showWarning:@"网络错误"];
//                [weakSelf.tableView endFooterRefresh];
//            }
//        }];
//    }];
//    [self.tableView beginHeaderRefresh];
    
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
        
        NSLog(@"url-----%@",get_shop_sovenir);
        
        [DNNetworking getWithURLString:get_shop_sovenir success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            if ([[obj objectForKey:@"code"] intValue]==200) {
                
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
    }
    if (self.type==ShopTypeFood) {
        NSLog(@"食品");
    }
}

-(void)footerRefreshEndAction
{
    if (self.type==ShopTypeSovenir) {
        NSLog(@"纪念品");
        
        NSLog(@"url-----%@",get_shop_sovenir);
        
        [DNNetworking getWithURLString:get_shop_sovenir success:^(id obj) {
            NSLog(@"obj-----%@",obj);
            
        } failure:^(NSError *error) {
            [self.tableView endFooterRefresh];
        }];
    }
    if (self.type==ShopTypeArt) {
        NSLog(@"艺术品");
    }
    if (self.type==ShopTypeFood) {
        NSLog(@"食品");
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isDebug) {
        return 1;
    }
    return self.viewmodel.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isDebug) return 10;
    return self.viewmodel.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    commodityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (isDebug) return cell;
    
    [cell.imageV sd_setImageWithURL:[self.viewmodel imageURLatIndexPath:indexPath] placeholderImage:img_canyinMinsu_default];
    cell.isStored = [self.viewmodel isStoredAtIndexPath:indexPath];
    cell.nameL.text = [self.viewmodel nameAtIndexPath:indexPath];
    cell.detailL.text = [self.viewmodel detailAtIndexPath:indexPath];
    cell.describeL.text = [self.viewmodel descriptionAtIndexPath:indexPath];
    cell.priceL.text = [self.viewmodel discountAtIndexPath:indexPath];
    cell.discountL.text = [self.viewmodel priceAtIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopDetailVC *vc = [[ShopDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
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
