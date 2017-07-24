//
//  TabBarController.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "TabBarController.h"
#import "ZXTCNavigationViewController.h"
#import "MineTVC.h"
#import "HomePageTVC.h"
#import "ShunFengCheCVC.h"
#import "ShopPageController.h"
#import "FoodandBedPageVC.h"

@interface TabBarController ()

@property (nonatomic, strong) MineTVC *mine;



@property (nonatomic, strong) ShopPageController *shop;

@property (nonatomic, strong) ShunFengCheCVC *travel;

@property (nonatomic, strong) FoodandBedPageVC *food;


@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomePageTVC *vc1 = [HomePageTVC new];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"cd-sy-ns"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"cd-sy-s"];
    self.tabBar.tintColor = krgb(250, 0, 48, 1);
    
    
    ZXTCNavigationViewController *navi1 = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc1];
    
    ZXTCNavigationViewController *navi2 = [[ZXTCNavigationViewController alloc] initWithRootViewController: self.food];
    
    ZXTCNavigationViewController *navi3 = [[ZXTCNavigationViewController alloc] initWithRootViewController:self.shop];
    
    ZXTCNavigationViewController *navi4 = [[ZXTCNavigationViewController alloc] initWithRootViewController:self.travel];
    
    ZXTCNavigationViewController *navi5 = [[ZXTCNavigationViewController alloc] initWithRootViewController:self.mine];
    
    self.viewControllers = @[navi1, navi2, navi3, navi4, navi5];
}

- (MineTVC *)mine{
    if (!_mine) {
        UIStoryboard *Main = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        _mine = [Main instantiateInitialViewController];
        
        _mine.title = @"我的";
        _mine.tabBarItem.image = [UIImage imageNamed:@"cd-w-ns"];
        _mine.tabBarItem.selectedImage = [UIImage imageNamed:@"cd-w-s"];
    }
    return _mine;
}

- (ShunFengCheCVC *)travel{
    if (!_travel) {
        
         UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
         layout.minimumLineSpacing = 10;
         layout.minimumInteritemSpacing = 10;
         layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
         CGFloat width = (kScreenW - 30) / 2;
         layout.itemSize = CGSizeMake(width, width * 14 / 15.0);
        _travel = [[ShunFengCheCVC alloc] initWithCollectionViewLayout:layout];
        _travel.title = @"说走就走";
        _travel.tabBarItem.image = [UIImage imageNamed:@"cd-szjz-ns"];
        _travel.tabBarItem.selectedImage = [UIImage imageNamed:@"cd-szjz-s"];
        
    }
    return _travel;
}

- (ShopPageController *)shop{
    if (!_shop) {
        _shop = [[ShopPageController alloc] init];
        _shop.title = @"商品";
        _shop.tabBarItem.image = [UIImage imageNamed:@"cd-sp-ns"];
        _shop.tabBarItem.selectedImage = [UIImage imageNamed:@"cd-sp-s"];
    }
    return _shop;
}


- (FoodandBedPageVC *)food{
    if (!_food) {
        
        _food = [[FoodandBedPageVC alloc] init];
        _food.title = @"餐饮民宿";
        _food.tabBarItem.image = [UIImage imageNamed:@"cd-ms-ns"];
        _food.tabBarItem.selectedImage = [UIImage imageNamed:@"cd-ms-s"];
    }
    return _food;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
