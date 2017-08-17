//
//  sotrageVC4.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "sotrageVC4.h"
#import "foodCollectionViewCell.h"
#import "shoucangfoodModel.h"
@interface sotrageVC4 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,mycellVdelegate>
{
    int pn ;
}

@property (nonatomic,strong) UICollectionView *myCollectionV;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

static NSString *foodcellidentfid = @"foodcellidentfid";

@implementation sotrageVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray array];
    [self addTheCollectionView];
    [self empty];
    pn = 1;
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.myCollectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.myCollectionV.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.myCollectionV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    //userid = @"1";
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"6",@"1"];
    [self.dataSource removeAllObjects];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                shoucangfoodModel *model = [[shoucangfoodModel alloc] init];
                model.recommend_id = [dic objectForKey:@"recommend_id"];
                model.home_id = [dic objectForKey:@"home_id"];
                model.home_pic = [dic objectForKey:@"home_pic"];
                model.home_name = [dic objectForKey:@"home_name"];
                model.home_description = [dic objectForKey:@"home_description"];
                [self.dataSource addObject:model];
            }
            [self.myCollectionV reloadData];
        }else
        {
            
        }
        [self.myCollectionV.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.myCollectionV.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn ++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    //userid = @"1";
    NSString *url = [NSString stringWithFormat:get_shoucang,userid,@"6",pnstr];
    [DNNetworking getWithURLString:url success:^(id obj) {
        if ([[obj objectForKey:@"code"] intValue]==200) {
            NSArray *dataarr = [obj objectForKey:@"data"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dic = [dataarr objectAtIndex:i];
                shoucangfoodModel *model = [[shoucangfoodModel alloc] init];
                model.recommend_id = [dic objectForKey:@"recommend_id"];
                model.home_id = [dic objectForKey:@"home_id"];
                model.home_pic = [dic objectForKey:@"home_pic"];
                model.home_name = [dic objectForKey:@"home_name"];
                model.home_description = [dic objectForKey:@"home_description"];
                [self.dataSource addObject:model];
            }
            [self.myCollectionV reloadData];
        }else
        {
            
        }
        [self.myCollectionV.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.myCollectionV.mj_footer endRefreshing];
    }];
}

#pragma mark - getters

//创建视图

-(void)addTheCollectionView{
    
    //=======================1===========================
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //格子的大小 (长，高)
    flowL.itemSize = CGSizeMake(170*WIDTH_SCALE, 235*HEIGHT_SCALE);
    //横向最小距离
    flowL.minimumInteritemSpacing = 1.f;
    //    flowL.minimumLineSpacing=60.f;//代表的是纵向的空间间隔
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowL.sectionInset = UIEdgeInsetsMake(16*HEIGHT_SCALE, 14*WIDTH_SCALE, 4*HEIGHT_SCALE, 14*WIDTH_SCALE);
    //创建一个UICollectionView
    _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -8, kScreenW, kScreenH-64-44) collectionViewLayout:flowL];
    //设置代理为当前控制器
    _myCollectionV.backgroundColor = [UIColor whiteColor];
    _myCollectionV.delegate = self;
    _myCollectionV.dataSource = self;
    [_myCollectionV registerClass:[foodCollectionViewCell class] forCellWithReuseIdentifier:foodcellidentfid];
    //添加视图
    [self.view addSubview:_myCollectionV];
    
}

#pragma mark --UICollectionView dataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化每个单元格
    foodCollectionViewCell *cell = (foodCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:foodcellidentfid forIndexPath:indexPath];
    [cell setdata:self.dataSource[indexPath.item]];
    cell.delegate = self;
    return cell;
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

//取消收藏
-(void)myTabVClick1:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [self.myCollectionV indexPathForCell:cell];
    shoucangfoodModel *model = self.dataSource[index.item];
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *recommend_id = model.recommend_id;
    
    NSString *urlstr = [NSString stringWithFormat:get_quxiaoshoucang,userid,recommend_id];
    [DNNetworking getWithURLString:urlstr success:^(id obj) {
         [self headerRefreshEndAction];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - empty

-(void)empty
{
    // method one 配置方法1
    typeof(self) weakSelf = self;
    [self.myCollectionV emptyViewConfigerBlock:^(FOREmptyAssistantConfiger *configer) {
        configer.emptyTitle = @"暂无此类信息";
        configer.emptyTitleFont = [UIFont boldSystemFontOfSize:14];
        configer.emptyTitleColor = [UIColor colorWithHexString:@"d5d5d5"];
        configer.emptyImage = [UIImage imageNamed:@"dd-kby"];
        configer.emptySpaceHeight = 20;
        configer.emptyViewTapBlock = ^{
            [weakSelf.myCollectionV.mj_header beginRefreshing];
            //[self addHeader];
        };
    }];
}

@end
