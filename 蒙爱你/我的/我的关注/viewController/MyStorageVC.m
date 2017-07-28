//
//  MyStorageVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MyStorageVC.h"
#import "UIParameter.h"
#import "NinaPagerView.h"

@interface MyStorageVC ()
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@end

@implementation MyStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.ninaPagerView];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}


#pragma mark - NinaParaArrays

- (NSArray *)ninaTitleArray {
    return @[
             @"景点",
             @"出行",
             @"民宿",
             @"商品",
             @"美食"
             ];
}

- (NSArray *)ninaVCsArray {
    return @[
             @"sotrageVC0",
             @"storaveVC1",
             @"sotrageVC2",
             @"sotrageVC3",
             @"sotrageVC4"
             ];
}

#pragma mark - LazyLoad

- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        _ninaPagerView.unSelectTitleColor = [UIColor whiteColor];
        
        CGRect pagerRect = CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:vcsArray];
        _ninaPagerView.titleScale = 1;
        _ninaPagerView.unSelectTitleColor = [UIColor colorWithHexString:@"333333"];
        _ninaPagerView.selectTitleColor = [UIColor colorWithHexString:@"df0843"];
        _ninaPagerView.underlineColor = [UIColor colorWithHexString:@"df0842"];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
    }
    return _ninaPagerView;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
