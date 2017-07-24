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

@interface ShunFengCheCVC ()


@property(nonatomic, strong) ShunFengCheViewModel *viewmodel;

@end

@implementation ShunFengCheCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.viewmodel getDataWithMode:RequestModeRefresh url:get_shunFengChe_zhuye handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView endHeaderRefresh];
            }else{
                [weakSelf.view.superview showWarning:@"网络错误"];
                [weakSelf.collectionView endHeaderRefresh];
            }
        }];
        
    
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.viewmodel getDataWithMode:RequestModeRefresh url:get_shunFengChe_zhuye handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView endFooterRefresh];
            }else{
                [weakSelf.view.superview showWarning:@"网络错误"];
                [weakSelf.collectionView endFooterRefresh];
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelAdviseCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;//self.viewmodel.datalist.count ? 1 : 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;//self.viewmodel.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelAdviseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (isDebug) {
        return cell;
    }
    HomeTravelModel *model = self.viewmodel.datalist[indexPath.row];
    [cell.imageV sd_setImageWithURL:model.trip_pic.xd_URL placeholderImage:img_shunFengChe_default];
    cell.nameL.text = model.trip_driver;
    cell.addressL.text = [NSString stringWithFormat:@"%@", model.trip_address];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld", indexPath.row);
    
    
    //HomeTravelVC *vc = [[HomeTravelVC alloc] initWithHomeTravelModel:self.viewmodel.datalist[indexPath.row]];
    HomeTravelVC *vc = [[HomeTravelVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
}



#pragma mark - lazy Loading

- (ShunFengCheViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [ShunFengCheViewModel new];
    }
    return _viewmodel;
}





@end
