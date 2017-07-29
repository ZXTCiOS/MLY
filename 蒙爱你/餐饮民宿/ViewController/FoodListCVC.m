//
//  FoodListCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodListCVC.h"
#import "FoodCell.h"
#import "FoodListHeaderView.h"
#import "FoodDataModel.h"
#import "FoodInfoVC.h"


@interface FoodListCVC ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger shop_id;

@property (nonatomic, strong) NSArray<FoodModel *> *foodlist;
@property (nonatomic, strong) FoodHeadModel *head;

@end

@implementation FoodListCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XDFactory addBackItemForVC:self];
    
    
    
    NSString *path = [NSString stringWithFormat:@"/MLY/api.php/Food/foodDetail?id=%ld", self.shop_id];
    [DNNetworking getWithURLString:path success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            FoodDataModel *model = [FoodDataModel parse:obj];
            self.foodlist = [NSArray arrayWithArray:model.data.food];
            self.head = model.data.home;
            self.title = model.data.home.home_name;
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FoodCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FoodListHeaderView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.foodlist.count ? 1 : 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodlist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    [cell.imageV sd_setImageWithURL:self.foodlist[indexPath.row].bedeat_pic.xd_URL placeholderImage:[UIImage imageNamed:@"1"]];
    cell.nameL.text = self.foodlist[indexPath.row].bedeat_name;
    cell.priceL.text = [NSString stringWithFormat:@"¥%.2f", self.foodlist[indexPath.row].bedeat_price];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FoodModel *model = self.foodlist[indexPath.row];
    FoodInfoVC *vc = [[FoodInfoVC alloc] initWithFoodModel:model home_id:self.shop_id];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FoodListHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    if (!self.head) {
        view.frame = CGRectMake(0, 0, kScreenW, 392 + 20 + 20);
        return view;
    }
    
    CGSize s1 = [self.head.home_description sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 20, 1000) mode:NSLineBreakByCharWrapping];
    CGSize s2 = [self.head.home_address sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 100, 1000) mode:NSLineBreakByCharWrapping];
    view .frame = CGRectMake(0, 0, kScreenW, 392 + s1.height + s2.height + 20);
    [view.imgV sd_setImageWithURL:self.head.home_pic.xd_URL placeholderImage:[UIImage imageNamed:@"33"]];
    view. shop_name.text = self.head.home_name;
    view.phone.text = self.head.home_phone;
    view.addres.text = self.head.home_address;
    [self starsView:view With:self.head.home_star];
    
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (!self.head) {
        return CGSizeMake( kScreenW, 392 + 20);
    } else {
        CGSize s1 = [self.head.home_description sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 20, 1000) mode:NSLineBreakByCharWrapping];
        CGSize s2 = [self.head.home_address sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 100, 1000) mode:NSLineBreakByCharWrapping];
        
        return CGSizeMake(kScreenW, 392 + s1.height + s2.height);
    }
}


- (void)starsView:(FoodListHeaderView *)view With:(NSInteger) star{
    if (star < 1) return;
    view.star1.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 2) return;
    view.star2.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 3) return;
    view.star3.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 4) return;
    view.star4.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 5) return;
    view.star5.image = [UIImage imageNamed:@"xj-s-b"];
    
}

- (instancetype)initWithShop_ID:(NSInteger)shop_id{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    CGFloat width = (kScreenW - 80)/2;
    layout.itemSize = CGSizeMake(width, width + 30);
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 30, 30);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.shop_id = shop_id;
    }
    return self;
}






@end
