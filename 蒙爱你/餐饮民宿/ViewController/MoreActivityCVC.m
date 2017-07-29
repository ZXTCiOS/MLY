//
//  MoreActivityCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MoreActivityCVC.h"
#import "MoreActivityCell.h"



@interface MoreActivityCVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<MinsuArtModel *> *datalist;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MoreActivityCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)addBackBtn{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 60, kScreenW, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    [btn setTitle:nil forState:UIControlStateNormal];
    [btn setTintColor:[UIColor lightGrayColor]];
    [btn setImage:[UIImage imageNamed:@"xtb-gb"] forState:UIControlStateNormal];
    btn.frame = CGRectMake((kScreenW - 40)/2, kScreenH - 50, 40, 40);
    [btn bk_addEventHandler:^(id sender) {
        [self dismissViewControllerAnimated:self completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datalist.count ? 1 : 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MoreActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MinsuArtModel *model = self.datalist[indexPath.row];
    [cell.img sd_setImageWithURL:model.art_logo.xd_URL placeholderImage:[UIImage imageNamed:@"action"]];
    cell.title.text = model.art_name;
    cell.userInteractionEnabled = NO;
    return cell;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout andActionList:(NSArray<MinsuArtModel *> *)datalist{
    self = [super init];
    if (self) {
        self.datalist = datalist;
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
        [self.collectionView registerClass:[MoreActivityCell class] forCellWithReuseIdentifier:@"cell"];
        [self addBackBtn];
    }
    return self;
}


@end
