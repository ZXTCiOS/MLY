//
//  HomePageTVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomePageTVC.h"
#import "HomeTableCell.h"
#import "ScenicSpotAdviseCell.h"
#import "TravelAdviseCell.h"
#import "FoodAndHotelCell.h"
#import <HYBLoopScrollView.h>
#import "HomeViewModel.h"
#import "WKWedViewController.h"
#import "HomeScenicCVC.h"
#import "ScenicVC.h"
#import "BedDetailTVC.h"
#import "HomeTravelVC.h"
#import "SearchViewController.h"



#define delayTime 1.5               //  延时请求
#define distanceToRight  (-50)       //  右滑距离右边的最远刷新距离


@interface HomePageTVC ()< UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) HYBLoopScrollView *loopView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeViewModel *viewModel;

@property (nonatomic, strong) UIView *naviBar;

@end

@implementation HomePageTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self tableView];
    [self configNaviBar];
    MJWeakSelf      // 添加头部刷新
    [self.tableView addHeaderRefresh:^{
        
        [weakSelf.viewModel GetRefreshHomeCompletionHandller:^(NSError *error) {
            if (!error) {
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderRefresh];
                [weakSelf reloadBanner];
                [weakSelf collectionViewReloadData];
            } else {
                [weakSelf.tableView endHeaderRefresh];
                [weakSelf.view.superview showWarning:@"网络错误"];
            }
        }];
    }];
    [self.tableView beginHeaderRefresh];
}

- (void)configNaviBar{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self setNeedsStatusBarAppearanceUpdate];
    self.naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
    [self.view addSubview:self.naviBar];
    self.naviBar.backgroundColor = [UIColor clearColor];
    UIControl *bgV = [[UIControl alloc] init];
    [self.naviBar addSubview:bgV];
    bgV.backgroundColor = krgb(50, 50, 50, 0.31);
    bgV.layer.cornerRadius = 17;
    bgV.layer.masksToBounds = YES;
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.bottom.equalTo(-5);
        make.height.equalTo(34);
    }];
    [bgV bk_addEventHandler:^(id sender) {
        SearchViewController *vc = [[SearchViewController alloc] initWithSearchType:SearchTypeScenic];
        [self.navigationController pushViewController:vc animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *search = [[UIImageView alloc] init];
    [bgV addSubview:search];
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(0);
        make.size.equalTo(CGSizeMake(17, 17));
    }];
    search.image = [UIImage imageNamed:@"sy-ss"];
    
    UILabel *label = [UILabel new];
    [bgV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(search.mas_right).equalTo(10);
        make.centerY.equalTo(bgV.mas_centerY);
        make.right.equalTo(bgV.mas_right).equalTo(-10);
    }];
    label.text = @"搜索景点,民宿或出行";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [shareBtn setImage:[UIImage imageNamed:@"sy-fx"] forState:UIControlStateNormal];
    shareBtn.tintColor = [UIColor whiteColor];
    [self.naviBar addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(bgV.mas_centerY);
        make.left.equalTo(bgV.mas_right).equalTo(15);
        make.size.equalTo(CGSizeMake(29, 26));
    }];
    
    [shareBtn bk_addEventHandler:^(id sender) {
        // 分享
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    
}




- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}



- (void)collectionViewReloadData{
    [((HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).collectV reloadData];
    [((HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).collectV reloadData];
    [((HomeTableCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]]).collectV reloadData];
}

- (HYBLoopScrollView *)loopScrollView{
    MJWeakSelf
    self.loopView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 0.5) imageUrls:@[] timeInterval:4 didSelect:^(NSInteger atIndex) {
        WKWedViewController *wkWebV = [[WKWedViewController alloc] initWithTitle:nil Url:weakSelf.viewModel.bannerList[atIndex].href.xd_URL];
        wkWebV.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:wkWebV animated:YES];
    } didScroll:nil];
    return self.loopView;
}

- (void)reloadBanner{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.viewModel.bannerList.count; i++) {
        [arr addObject:self.viewModel.bannerList[i].lunbo_pic];
    }
    self.loopView.imageUrls = arr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.collectV.tag = indexPath.section;
    cell.collectV.delegate = self;
    cell.collectV.dataSource = self;
    
    return cell;
}

static BOOL ok = YES;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (scrollView.tag == 300) {
        if (offset.y < -23 || offset.y > 100) {
            self.naviBar.hidden = YES;
        } else {
            self.naviBar.hidden = NO;
        }
        return;
    }
    
    
    HomeMoreOfType type = HomeMoreOfTypeScenic;
    switch (scrollView.tag) {
        case 0:
            type = HomeMoreOfTypeScenic;
            break;
        case 1:
            type = HomeMoreOfTypeTravel;
            break;
        case 2:
            type = HomeMoreOfTypeFood;
            break;
        default:
            break;
    }
    HomeTableCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:scrollView.tag]];
    __weak typeof(cell) weakCell = cell;
    float contentOffset_x = offset.x;
    float contentSize_width = scrollView.contentSize.width;
    
    
    if (contentOffset_x > contentSize_width -  distanceToRight - kScreenW) {
            //  加延时处理
        if (ok) {
            ok = NO;
            NSLog(@"%f, %f", contentOffset_x, contentSize_width);
            [self.viewModel PostMoreType:type completionHandller:^(NSError *error) {
                if (!error) {
                [weakCell.collectV reloadData];
                } else {
                    [self.view showWarning:@"网络错误"];
                }
            }];
            [NSTimer bk_scheduledTimerWithTimeInterval: delayTime block:^(NSTimer *timer) {
                ok = YES;
            } repeats:NO];
        }
    };
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 47)];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-12);
        make.left.equalTo(30);
    }];
    label.font = kFont(16);
    switch (section) {
        case 0:
            label.text = @"景点推荐";
            break;
        case 1:
            label.text = @"出行推荐";
            break;
        case 2:
            label.text = @"餐饮民宿";
            break;
        default:
            break;
    }
    [label sizeToFit];
    UIControl *control = [[UIControl alloc] init];
    [view addSubview:control];
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-8);
        make.top.equalTo(8);
        make.bottom.equalTo(-8);
        make.width.equalTo(100);
    }];
    UILabel *ctrLabel = [[UILabel alloc] init];
    [control addSubview:ctrLabel];
    [ctrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-4);
        make.right.equalTo(-22);
    }];
    ctrLabel.text = @"查看全部";
    ctrLabel.font = kFont(14);
    ctrLabel.textColor = [UIColor colorWithHexString:@"999999"];
    MJWeakSelf
    [control bk_addEventHandler:^(id sender) {
        switch (section) {
            case 0:
            {
                // 景点推荐
                HomeScenicCVC *vc = [[HomeScenicCVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                // 出行
                self.tabBarController.selectedIndex = 3;
                
            }
                break;
            case 2:
            {
                // 餐饮民宿
                self.tabBarController.selectedIndex = 1;
                
            }
                break;
                
            default:
                break;
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 240;
            break;
        case 1:
            return 160;
            break;
        case 2:
            return 220;
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - Cell  delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (collectionView.tag) {
        case 0:
        {
            ScenicVC *vc = [[ScenicVC alloc] initWithScenic_id:self.viewModel.scenicList[indexPath.row].scenic_id];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
            HomeTravelVC *vc = [[HomeTravelVC alloc] initWithHomeTravelModel:self.viewModel.travelList[indexPath.row]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UIStoryboard *stb = [UIStoryboard storyboardWithName:@"BedDetailTVC" bundle:nil];
            BedDetailTVC *vc = [stb instantiateInitialViewController];
            vc.hidesBottomBarWhenPushed = YES;
            vc.minsu_id = self.viewModel.foodList[indexPath.row].home_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
}
}


#pragma mark - Cell  datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (collectionView.tag) {
        case 0:
            return self.viewModel.scenicList.count;
            break;
        case 1:
            return self.viewModel.travelList.count;
            break;
        case 2:
            return self.viewModel.foodList.count;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (collectionView.tag) {
        case 0:
            return [self ScenicSpotAdviseCellWithColltionView:collectionView IndexPath:indexPath];
            break;
            
        case 1:
            
            return [self TravelAdviseCellWithColltionView:collectionView IndexPath:indexPath];
            
            break;
        case 2:
            
            return [self FoodAndHotelCellWithColltionView:collectionView IndexPath:indexPath];
            
            break;
        default:
            break;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (collectionView.tag) {
        case 0:
            return CGSizeMake(150, 222);
            break;
        case 1:
            return CGSizeMake(150, 140);
            break;
        case 2:
            return CGSizeMake(150, 200);
            break;
        default:
            break;
    }
    return CGSizeZero;
}


- (ScenicSpotAdviseCell *)ScenicSpotAdviseCellWithColltionView:(UICollectionView *)collection IndexPath:(NSIndexPath *)indexPath{
    ScenicSpotAdviseCell *cell = [collection dequeueReusableCellWithReuseIdentifier:ScenicSpotAdviseC forIndexPath:indexPath];
    [cell.imgV sd_setImageWithURL:self.viewModel.scenicList[indexPath.row].scenic_pic.xd_URL placeholderImage:[UIImage imageNamed:@"15"]];
    cell.name.text = self.viewModel.scenicList[indexPath.row].scenic_name;
    cell.islike = self.viewModel.scenicList[indexPath.row].is_shoucang;
    return cell;
}

- (TravelAdviseCell *)TravelAdviseCellWithColltionView:(UICollectionView *)collection IndexPath:(NSIndexPath *)indexPath{
    TravelAdviseCell *cell = [collection dequeueReusableCellWithReuseIdentifier:TravelAdviseC forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:self.viewModel.travelList[indexPath.row].trip_pic.xd_URL placeholderImage:[UIImage imageNamed:@"39"]];
    cell.nameL.text = self.viewModel.travelList[indexPath.row].trip_driver;
    cell.addressL.text = self.viewModel.travelList[indexPath.row].trip_address;
    
    return cell;
}

- (FoodAndHotelCell *)FoodAndHotelCellWithColltionView:(UICollectionView *)collection IndexPath:(NSIndexPath *)indexPath{
    FoodAndHotelCell *cell = [collection dequeueReusableCellWithReuseIdentifier:FoodAndHotelC forIndexPath:indexPath];
    [cell.imgV sd_setImageWithURL:self.viewModel.foodList[indexPath.row].home_pic.xd_URL placeholderImage:[UIImage imageNamed:@"1"]];
    cell.desc.text = self.viewModel.foodList[indexPath.row].home_name;
    cell.star = self.viewModel.foodList[indexPath.row].home_star;
    cell.isStored = self.viewModel.foodList[indexPath.row].is_shoucang;
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
}


- (HomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}



- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = self.view.frame;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height+20) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self loopScrollView];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[HomeTableCell class] forCellReuseIdentifier:@"cell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.tag = 300;
    }
    return _tableView;
}


@end
