//
//  FoodListCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodListCVC.h"
#import "FoodCell.h"
#import "FoodDataModel.h"
#import "FoodInfoVC.h"




@interface FoodListCVC ()<UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>


@property (nonatomic, strong) FoodHeadModel *head;
@property (nonatomic, assign) NSInteger shop_id;

@property (nonatomic, strong) NSArray<FoodModel *> *foodlist;

@property (nonatomic, assign) PushSource source;
// animation
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *pan;

@end

@implementation FoodListCVC

static NSString * const reuseIdentifier = @"Cell";


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (self.source == PushSourceOther) {
        return nil;
    }
    if (operation == UINavigationControllerOperationPop) {
        Transition_Food *tran = [Transition_Food TransitionWithTransitionType:TransitionTypePop];
        return tran;
    }else {
        return nil;//[Transition_Food TransitionWithTransitionType:TransitionTypePush];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.percent;
}

- (void)addPanGesture{
    self.pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    self.pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.pan];
    
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)pan{
    float progress = [pan translationInView:self.view].x / kScreenW;
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.percent updateInteractiveTransition:progress];
    } else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [self.percent finishInteractiveTransition];
        } else {
            [self.percent cancelInteractiveTransition];
        }
        self.percent = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [XDFactory addBackItemForVC:self];
    self.navigationController.delegate = self;
    [self addPanGesture];
    
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
    return 1;
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
    self.imgV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    [self.imgV.imgV sd_setImageWithURL:self.img_url.xd_URL];
    if (!self.head) {
        self.imgV.frame = CGRectMake(0, 0, kScreenW, 192 + 20 + 20 + kScreenW);
        
        return self.imgV;
    }
    
    CGSize s1 = [self.head.home_description sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 20, 1000) mode:NSLineBreakByCharWrapping];
    CGSize s2 = [self.head.home_address sizeForFont:[UIFont systemFontOfSize:15] size:CGSizeMake(kScreenW - 100, 1000) mode:NSLineBreakByCharWrapping];
    self.imgV .frame = CGRectMake(0, 0, kScreenW, kScreenW + 192 + s1.height + s2.height + 20);
    //[self.imgV.imgV sd_setImageWithURL:self.head.home_pic.xd_URL placeholderImage:[UIImage imageNamed:@"33"]];
    self.imgV. shop_name.text = self.head.home_name;
    self.imgV.phone.text = self.head.home_phone;
    self.imgV.addres.text = self.head.home_address;
    [self starsView:self.imgV With:self.head.home_star];
    
    return self.imgV;
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

- (instancetype)initWithShop_ID:(NSInteger)shop_id pushSource:(PushSource)source{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    CGFloat width = (kScreenW - 80)/2;
    layout.itemSize = CGSizeMake(width, width + 30);
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 30, 30);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.shop_id = shop_id;
        self.source = source;
    }
    return self;
}






@end
