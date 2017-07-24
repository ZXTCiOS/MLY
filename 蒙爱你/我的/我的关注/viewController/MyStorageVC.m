//
//  MyStorageVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyStorageVC.h"






@interface MyStorageVC ()

@end

@implementation MyStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titles = @[@"民宿", @"商品", @"出行"];
    
    
}


- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    
    
    return nil;
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
