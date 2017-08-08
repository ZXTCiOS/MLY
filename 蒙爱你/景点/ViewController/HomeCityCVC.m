//
//  HomeCityCVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeCityCVC.h"
#import "HomeCityCell.h"
#import "ScenicTVC.h"
#import "Scenic12Model.h"



@interface HomeCityCVC ()

@property (nonatomic, assign) NSInteger meng_id;

@property (nonatomic, strong) NSMutableArray<ScenicAreaModel *> *datalist;

@end

@implementation HomeCityCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DNNetworking getWithURLString:get_citylist parameters:@{@"id": @(self.meng_id)} success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            
            Scenic12Model *model = [Scenic12Model parse:obj];
            [self.datalist addObjectsFromArray:model.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
    }];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCityCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [XDFactory addBackItemForVC:self];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil;
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
    HomeCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ScenicAreaModel *model = self.datalist[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.area_pic.xd_URL placeholderImage:[UIImage imageNamed:@"7"]];
    cell.name.text = model.area_name;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    ScenicTVC *vc = [[ScenicTVC alloc] initWithArea_id:self.datalist[indexPath.row].area_id area_name:self.datalist[indexPath.row].area_name];
    [self.navigationController pushViewController:vc animated:YES];
}




- (NSMutableArray<ScenicAreaModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<ScenicAreaModel *> array];
    }
    return _datalist;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout meng_id:(NSInteger)meng_id meng_name:(NSString *)meng_name{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.meng_id = meng_id;
        self.title = meng_name;
    }
    return self;
}


@end
