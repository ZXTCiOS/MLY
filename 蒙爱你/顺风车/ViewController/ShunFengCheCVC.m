//
//  ShunFengCheCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/6.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShunFengCheCVC.h"
#import "TravelAdviseCell.h"
#import "HomeTravelVC.h"
#import "ShunFengCheViewModel.h"
#import "SearchViewController.h"

@interface ShunFengCheCVC ()

@property (nonatomic, copy) NSString *searchtext;
@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) ShunFengCheViewModel *viewmodel;

@end

@implementation ShunFengCheCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf HeadRefresh];
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf FoodRefresh];
    }];
    [self.collectionView beginHeaderRefresh];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelAdviseCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    if (self.searchType == SearchTypeChuxing) {
        [XDFactory addBackItemForVC:self];
        self.title = @"搜索结果";
    } else {
        [XDFactory addSearchItemForVC:self clickedHandler:^{
            SearchViewController *vc = [[SearchViewController alloc] initWithSearchType:SearchTypeChuxing];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
}


- (void)HeadRefresh{
    if (self.searchType == SearchTypeChuxing) {
        [self.viewmodel getDataWithMode:RequestModeRefresh SearchText:self.searchtext handller:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endHeaderRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endHeaderRefresh];
            }
        }];
    } else {
        [self.viewmodel getDataWithMode:RequestModeRefresh url:get_shunFengChe_zhuye handller:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endHeaderRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endHeaderRefresh];
            }
        }];
    }
}

- (void)FoodRefresh{
    if (self.searchType == SearchTypeChuxing) {
        [self.viewmodel getDataWithMode:RequestModeMore SearchText:self.searchtext handller:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endHeaderRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endHeaderRefresh];
            }
        }];
    } else {
        [self.viewmodel getDataWithMode:RequestModeMore url:get_shunFengChe_zhuye handller:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endHeaderRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endHeaderRefresh];
            }
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewmodel.datalist.count ? 1 : 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.viewmodel.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelAdviseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    HomeTravelModel *model = self.viewmodel.datalist[indexPath.row];
    [cell.imageV sd_setImageWithURL:model.trip_pic.xd_URL placeholderImage:img_shunFengChe_default];
    cell.nameL.text = model.trip_driver;
//    NSDictionary *dic = (NSDictionary*)model;
//    [dic objectForKey:@"trip_address"];
//    
//    
//    if (model.is_shoucang) {
//        cell.shoucangImg.image = [UIImage imageNamed:@"sc-ns"];
//    }
//    else
//    {
//        cell.shoucangImg.image = [UIImage imageNamed:@"sc-s"];
//    }
    cell.addressL.text = [NSString stringWithFormat:@"%@", model.trip_address];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld", indexPath.row);
    

    HomeTravelVC *vc = [[HomeTravelVC alloc] initWithHomeTravelModel:self.viewmodel.datalist[indexPath.row]];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
}



#pragma mark - lazy Loading

- (ShunFengCheViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [ShunFengCheViewModel new];
    }
    return _viewmodel;
}

- (instancetype)initWithSearchText:(NSString *)text searchType:(SearchType)searchType{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (kScreenW - 30) / 2;
    layout.itemSize = CGSizeMake(width, width * 14 / 15.0);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.searchType = searchType;
        self.searchtext = text;
    }
    return self;
}



@end
