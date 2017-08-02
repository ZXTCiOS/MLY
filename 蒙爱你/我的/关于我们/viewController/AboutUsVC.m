//
//  AboutUsVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/11.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "AboutUsVC.h"
#import "UIParameter.h"
#import "NinaPagerView.h"
@interface AboutUsVC ()
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"简介";
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.view addSubview:self.ninaPagerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden = YES;
}



#pragma mark - NinaParaArrays

- (NSArray *)ninaTitleArray {
    return @[
             @"公司简介",
             @"平台简介"
             ];
}

- (NSArray *)ninaVCsArray {
    return @[
             @"companyVC",
             @"platformVC"
             ];
}

#pragma mark - LazyLoad

- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        _ninaPagerView.unSelectTitleColor = [UIColor whiteColor];
        
        CGRect pagerRect = CGRectMake(0, 64, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithVCs:vcsArray];
        _ninaPagerView.titleScale = 1;
        _ninaPagerView.unSelectTitleColor = [UIColor colorWithHexString:@"333333"];
        _ninaPagerView.selectTitleColor = [UIColor colorWithHexString:@"df0843"];
        _ninaPagerView.underlineColor = [UIColor colorWithHexString:@"df0842"];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
    }
    return _ninaPagerView;
}


-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
