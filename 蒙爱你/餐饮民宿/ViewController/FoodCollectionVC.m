//
//  FoodCollectionVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodCollectionVC.h"
#import "FoodViewModel.h"
#import "FoodAndHotelCell.h"
#import "BedDetailTVC.h"
#import "FoodListCVC.h"


@interface FoodCollectionVC ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) FoodViewModel *viewmodel;


@property (nonatomic, copy) NSString *stars;

@property (nonatomic, assign) NSInteger price;

@end

@implementation FoodCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.price = 0;
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf.viewmodel getDataWithRequestMode:RequestModeRefresh type:weakSelf.type stars:weakSelf.stars price:weakSelf.price handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView endHeaderRefresh];
                [weakSelf.collectionView reloadData];
            } else {
                [weakSelf.collectionView endHeaderRefresh];
                [weakSelf.view.superview showWarning:@"网络错误"];
            }
        }];
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf.viewmodel getDataWithRequestMode:RequestModeMore type:weakSelf.type stars:weakSelf.stars price:weakSelf.price handller:^(NSError *error) {
            if (!error) {
                [weakSelf.collectionView endFooterRefresh];
                [weakSelf.collectionView reloadData];
            } else {
                [weakSelf.collectionView endFooterRefresh];
                [weakSelf.view.superview showWarning:@"网络错误"];
            }
        }];
    }];
    [self.collectionView beginHeaderRefresh];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FoodAndHotelCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}


- (void)reloadDataWithStars:(NSString *)arr andPrice:(NSInteger)price{
    
    self.stars = arr;
    self.price = price;
    [self.collectionView beginHeaderRefresh];
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
    FoodAndHotelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    [cell.imgV setImageWithURL:self.viewmodel.datalist[indexPath.row].home_pic.xd_URL placeholder:img_canyinMinsu_default];
    cell.isStored = self.viewmodel.datalist[indexPath.row].is_shoucang;
    cell.desc.text = self.viewmodel.datalist[indexPath.row].home_description;
    cell.star = self.viewmodel.datalist[indexPath.row].home_star;
    cell.detailL.text = self.viewmodel.datalist[indexPath.row].home_description;
    
    return cell;
}




#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.type == VCTypeOfBed) {
        UIStoryboard *stb = [UIStoryboard storyboardWithName:@"BedDetailTVC" bundle:nil];
        BedDetailTVC *vc = [stb instantiateInitialViewController];
        vc.minsu_id = self.viewmodel.datalist[indexPath.row].home_id;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        FoodListCVC *v = [[FoodListCVC alloc] initWithShop_ID:self.viewmodel.datalist[indexPath.row].home_id];
        [self.navigationController pushViewController:v animated:YES];
    }
}

#pragma mark <UICollectionViewFlowLayout>

- (UICollectionViewLayout *)collectionViewLayout{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(20, 18, 18, 18);
    layout.itemSize = CGSizeMake((kScreenW - 45) /2 , 239 + (kScreenW - 45) /2 - 150);
    return layout;
}




- (FoodViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [[FoodViewModel alloc] init];
    }
    return _viewmodel;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andType:(VCType)type{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.type = type;
    }
    return self;
}



@end
