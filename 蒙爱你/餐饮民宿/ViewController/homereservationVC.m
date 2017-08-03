//
//  homereservationVC.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/2.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "homereservationVC.h"

@interface homereservationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MinsuBedModel *model;

@end

@implementation homereservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"民宿预订";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithMinsuBedEatModel:(MinsuBedModel *)model{
    self = [super init];
    if (self ) {
        self.model = model;
    }
    return self;
}

#pragma mark - getters

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
