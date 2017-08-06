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
#import "Transition_Travel.h"
#import "MBProgressHUD+XMG.h"

@interface ShunFengCheCVC ()<UINavigationControllerDelegate,mycellVdelegate>

@property (nonatomic, copy) NSString *searchtext;
@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) ShunFengCheViewModel *viewmodel;


@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *pan;

@end

@implementation ShunFengCheCVC

static NSString * const reuseIdentifier = @"Cell";

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        Transition_Travel *tran = [Transition_Travel TransitionWithTransitionType:TransitionTypePush pushsource:PushSourceList];
        return tran;
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
    
    self.navigationController.delegate = self;
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
            self.navigationController.delegate = nil;
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
                [self.collectionView endFooterRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endFooterRefresh];
            }
        }];
    } else {
        [self.viewmodel getDataWithMode:RequestModeMore url:get_shunFengChe_zhuye handller:^(NSError *error) {
            if (!error) {
                [self.collectionView reloadData];
                [self.collectionView endFooterRefresh];
            }else{
                [self.view.superview showWarning:@"网络错误"];
                [self.collectionView endFooterRefresh];
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
    cell.delegate = self;
    if (model.is_shoucang) {
        cell.shoucangImg.image = [UIImage imageNamed:@"sc-s"];
    }
    else
    {
        cell.shoucangImg.image = [UIImage imageNamed:@"sc-ns"];
    }
    cell.addressL.text = [NSString stringWithFormat:@"%@", model.trip_address];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld", indexPath.row);
    
    self.currentIndex = indexPath;
    HomeTravelVC *vc = [[HomeTravelVC alloc] initWithHomeTravelModel:self.viewmodel.datalist[indexPath.row] pushSource:PushSourceList];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)myTabVClick1:(UICollectionViewCell *)cell
{
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];

    HomeTravelModel *model = self.viewmodel.datalist[index.item];
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *type = @"2";
    NSString *isstr = [NSString stringWithFormat:@"%ld",(long)model.trip_id];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.delegate = self;
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
