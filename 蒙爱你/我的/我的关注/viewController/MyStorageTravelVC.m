//
//  MyStorageTravelVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyStorageTravelVC.h"
#import "ShunFengCheViewModel.h"
#import "TravelAdviseCell.h"
#import "HomeTravelVC.h"

@interface MyStorageTravelVC ()

@property(nonatomic, strong) ShunFengCheViewModel *viewmodel;

@end

@implementation MyStorageTravelVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.viewmodel postDataWithTokenandMode:RequestModeRefresh url:post_shunFengChe_shouCang handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView endHeaderRefresh];
            }else{
                [weakSelf.view showWarning:@"网络错误"];
                [weakSelf.collectionView endHeaderRefresh];
            }
        }];
        
        
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.viewmodel postDataWithTokenandMode:RequestModeRefresh url:post_shunFengChe_shouCang handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView endFooterRefresh];
            }else{
                [weakSelf.view showWarning:@"网络错误"];
                [weakSelf.collectionView endFooterRefresh];
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TravelAdviseCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewmodel.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelAdviseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
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
    
    
    HomeTravelVC *vc = [[HomeTravelVC alloc] initWithHomeTravelModel:self.viewmodel.datalist[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}







#pragma mark - lazy Loading

- (ShunFengCheViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [ShunFengCheViewModel new];
    }
    return _viewmodel;
}



@end
