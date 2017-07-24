//
//  ShopPageController.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShopPageController.h"
#import "ShopVC.h"

@interface ShopPageController ()

@end

@implementation ShopPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.menuHeight = 44;
    //self.menuBGColor = [UIColor whiteColor];
    self.menuItemWidth = kScreenW / 3;
    self.titleColorSelected = [UIColor colorWithHexString:@"333333"];
    self.titleColorNormal = [UIColor colorWithHexString:@"80333333"];
    self.titleSizeNormal = 16;
    self.titleSizeSelected = 16;
    self.showOnNavigationBar = YES;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (NSArray<NSString *> *)titles{
    return @[@"旅游纪念品", @"民族工艺品", @"特色食品"];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    return [[ShopVC alloc] initWithShopType:index];
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
