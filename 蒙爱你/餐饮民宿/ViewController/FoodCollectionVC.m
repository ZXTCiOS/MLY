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
#import "MBProgressHUD+XMG.h"

@interface FoodCollectionVC ()<UICollectionViewDelegateFlowLayout,mycellVdelegate>

@property (nonatomic, strong) FoodViewModel *viewmodel;


@property (nonatomic, copy) NSString *stars;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, assign) SearchType searchType;

@end

@implementation FoodCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.price = 0;
    MJWeakSelf
    [self.collectionView addHeaderRefresh:^{
        [weakSelf HeadRefresh];
    }];
    [self.collectionView addFooterRefresh:^{
        [weakSelf FoodRefresh];
    }];
    [self.collectionView beginHeaderRefresh];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FoodAndHotelCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)HeadRefresh{
    if (self.searchType == SearchTypeMinsu | self.searchType == SearchTypeFood) {
        [self.viewmodel getDataWithRequestMode:RequestModeRefresh type:self.searchType searchText:self.searchText handller:^(NSError *error) {
            if (!error) {
                [self.collectionView endHeaderRefresh];
                [self.collectionView reloadData];
            } else {
                [self.collectionView endHeaderRefresh];
                [self.view.superview showWarning:@"网络错误"];
            }
        }];
    } else {
        [self.viewmodel getDataWithRequestMode:RequestModeRefresh type:self.type stars:self.stars price:self.price handller:^(NSError *error) {
            if (!error) {
                [self.collectionView endHeaderRefresh];
                [self.collectionView reloadData];
            } else {
                [self.collectionView endHeaderRefresh];
                [self.view.superview showWarning:@"网络错误"];
            }
        }];
    }
}

- (void)FoodRefresh{
    if (self.searchType == SearchTypeMinsu | self.searchType == SearchTypeFood) {
        [self.viewmodel getDataWithRequestMode:RequestModeMore type:self.searchType searchText:self.searchText handller:^(NSError *error) {
            if (!error) {
                [self.collectionView endHeaderRefresh];
                [self.collectionView reloadData];
            } else {
                [self.collectionView endHeaderRefresh];
                [self.view.superview showWarning:@"网络错误"];
            }
        }];
    } else {
        [self.viewmodel getDataWithRequestMode:RequestModeMore type:self.type stars:self.stars price:self.price handller:^(NSError *error) {
            if (!error) {
                [self.collectionView endHeaderRefresh];
                [self.collectionView reloadData];
            } else {
                [self.collectionView endHeaderRefresh];
                [self.view.superview showWarning:@"网络错误"];
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.title = @"搜索";
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
    cell.delegate = self;
    return cell;
}

-(void)myTabVClick1:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];
    //收藏的类型 1景点 2出行 3民宿 4商品 6美食
//    NSDictionary *dic = self.viewmodel.datalist[index.item];
    
    if (self.type == VCTypeOfBed) {
        
        NSLog(@"民宿");
        HomeFoodModel *model = self.viewmodel.datalist[index.item];

        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *type = @"3";
        NSString *isstr = [NSString stringWithFormat:@"%ld",(long)model.home_id];
        NSString *is_shoucang  = @"";
        if (model.is_shoucang==1) {
            is_shoucang = @"0";
        }else
        {
            is_shoucang = @"1";
        }
        NSString *urlstr = [NSString stringWithFormat:get_recommend,userid,isstr,type,is_shoucang];
        
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            if ([[obj objectForKey:@"code"]intValue]==200) {
                [self.collectionView.mj_header beginRefreshing];
                [MBProgressHUD showSuccess:@"操作成功"];
            }
            else
            {
                NSString *hud = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:hud];
            }
        } failure:^(NSError *error) {
            
        }];
    }else
    {
        
        NSLog(@"美食");
        HomeFoodModel *model = self.viewmodel.datalist[index.item];
        NSString *userid = [userDefault objectForKey:user_key_user_id];
        NSString *type = @"6";
        NSString *isstr = [NSString stringWithFormat:@"%ld",(long)model.home_id];
        NSString *is_shoucang  = @"";
        if (model.is_shoucang==1) {
            is_shoucang = @"0";
        }else
        {
            is_shoucang = @"1";
        }
        NSString *urlstr = [NSString stringWithFormat:get_recommend,userid,isstr,type,is_shoucang];
        
        [DNNetworking getWithURLString:urlstr success:^(id obj) {
            
            if ([[obj objectForKey:@"code"]intValue]==200) {
                [self.collectionView.mj_header beginRefreshing];
                [MBProgressHUD showSuccess:@"操作成功"];
            }
            else
            {
                NSString *hud = [obj objectForKey:@"message"];
                [MBProgressHUD showSuccess:hud];
            }
        } failure:^(NSError *error) {
            
        }];
    }
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

- (instancetype)initWithSearchType:(SearchType)type Searchtext:(NSString *)text{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (kScreenW - 30) / 2;
    layout.itemSize = CGSizeMake(width, width * 4 / 3.0);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.searchType = type;
        self.searchText = text;
        //self.type = VCTypeOfBed;
    }
    return self;
}

@end
