//
//  FoodandBedPageVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/14.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodandBedPageVC.h"
#import "ChooseView.h"
#import "SearchViewController.h"
#import "Transition_Minsu.h"
#import "Transition_Food.h"


@interface FoodandBedPageVC ()<UINavigationControllerDelegate>

@property (nonatomic, strong) ChooseView *chooseV;
@property (nonatomic, strong) UIView *bgV;

@property (nonatomic, strong) UIButton *chostBtn;

@end

@implementation FoodandBedPageVC

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        if (self.type == VCTypeOfBed) {
            Transition_Minsu *t = [Transition_Minsu TransitionWithTransitionType:TransitionTypePush pushsource:PushSourceList];
            return t;
        } else {
            Transition_Food *t = [Transition_Food TransitionWithTransitionType:TransitionTypePush];
            return t;
        }
    }
    return nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.menuItemWidth = 60;
    self.titleColorSelected = [UIColor colorWithHexString:@"aa1010"];
    self.titleColorNormal = [UIColor colorWithHexString:@"333333"];
    self.titleSizeNormal = 16;
    self.titleSizeSelected = 16;
    self.pageAnimatable = YES;
    self.menuViewStyle = WMMenuViewStyleLine;
    
    self.showOnNavigationBar = YES;
    
    
    [self addChooseBtn];
    [self addSearchBtn];
    
    
}

- (void)addChooseBtn{
    self.chostBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_chostBtn setTitle:@"筛选" forState: UIControlStateNormal];
    [_chostBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _chostBtn.frame = CGRectMake(0, 0, 60, 40);
    UIBarButtonItem *chose = [[UIBarButtonItem alloc] initWithCustomView:_chostBtn];
    self.navigationItem.leftBarButtonItem = chose;
    
    [_chostBtn bk_addEventHandler:^(id sender) {
        if (!self.type) {
            [UIView animateWithDuration:0.5 animations:^{
                [self.view layoutIfNeeded];
                self.bgV.alpha = 1;
                self.bgV.hidden = NO;
                [self.chooseV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(0);
                }];
            }];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)addSearchBtn{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 36, 36);
    [searchBtn setImage:[UIImage imageNamed:@"ss"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"ss-xss"] forState:UIControlStateHighlighted];
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = search;
    
    [searchBtn bk_addEventHandler:^(id sender) {
        SearchType t = self.type ? SearchTypeFood : SearchTypeMinsu;
        SearchViewController *search = [[SearchViewController alloc] initWithSearchType:t];
        self.navigationController.delegate = nil;
        [self.navigationController pushViewController:search animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}



- (NSArray<NSString *> *)titles{
    return @[@"民宿", @"美食"];
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    VCType type = ((FoodCollectionVC *)viewController).type;
    self.type = type;
    self.chostBtn.hidden = type;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (kScreenW - 30) / 2;
    layout.itemSize = CGSizeMake(width, width + 95);
    FoodCollectionVC *food = [[FoodCollectionVC alloc] initWithCollectionViewLayout:layout andType:index pushSource:PushSourceList];
    return food;
}

- (ChooseView *)chooseV{
    if (!_chooseV) {
        _chooseV = [[NSBundle mainBundle] loadNibNamed:@"ChooseView" owner:self options:nil].firstObject;
        [[[UIApplication sharedApplication] keyWindow] addSubview:_chooseV];
        [_chooseV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kScreenW, 220));
            make.bottom.equalTo(220);
            make.left.right.equalTo(0);
        }];
        
        
        
        _chooseV.slider.continuous = YES;
        _chooseV.slider.maximumValue = 3000;
        MJWeakSelf
        [_chooseV.slider bk_addEventHandler:^(id sender) {
            weakSelf.chooseV.topPrice.text = [NSString stringWithFormat:@"¥%.2f元", weakSelf.chooseV.slider.value];
        } forControlEvents:UIControlEventValueChanged];
        
        _chooseV.queding = ^(){
            [UIView animateWithDuration:1 animations:^{
                weakSelf.bgV.alpha = 0;
                [weakSelf.chooseV mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(220);
                }];
            }];
            
            NSMutableString *str;
            if (weakSelf.chooseV.star1.isSelect) {
                
                str = [NSMutableString stringWithFormat:@"1,"];
                
            }
            if (weakSelf.chooseV.star2.isSelect) {
                if (!str) {
                    str = [NSMutableString stringWithFormat:@"2,"];
                } else {
                    [str appendString:[NSString stringWithFormat:@"2,"]];
                    NSLog(@"%@", str);
                }
            }
            if (weakSelf.chooseV.star3.isSelect) {
                if (!str) {
                    str = [NSMutableString stringWithFormat:@"3,"];
                } else {
                    [str appendString:[NSString stringWithFormat:@"3,"]];
                    NSLog(@"%@", str);
                }
            }
            if (weakSelf.chooseV.star4.isSelect) {
                if (!str) {
                    str = [NSMutableString stringWithFormat:@"4,"];
                } else {
                    [str appendString:[NSString stringWithFormat:@"4,"]];
                    NSLog(@"%@", str);
                }
            }
            if (weakSelf.chooseV.star5.isSelect) {
                if (!str) {
                    str = [NSMutableString stringWithFormat:@"5,"];
                } else {
                    [str appendString:[NSString stringWithFormat:@"5,"]];
                    NSLog(@"%@", str);
                }
            }
            
            NSInteger price = weakSelf.chooseV.slider.value;
            [((FoodCollectionVC *)weakSelf.currentViewController) reloadDataWithStars:str andPrice:price];
            
        };
        
    }
    return _chooseV;
}

- (UIView *)bgV{
    if (!_bgV) {
        _bgV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgV.opaque = NO;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
        gesture.numberOfTapsRequired = 1;
        gesture.cancelsTouchesInView = NO;
        [_bgV addGestureRecognizer:gesture];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:_bgV];
    }
    return _bgV;
}

- (void)exitClick{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.chooseV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(220);
        }];
        self.bgV.alpha = 0;
        self.bgV.hidden = YES;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
