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

@interface HomeCityCVC ()

@property (nonatomic, assign) NSInteger meng_id;

@end

@implementation HomeCityCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCityCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [XDFactory addBackItemForVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    
    ScenicTVC *vc = [[ScenicTVC alloc] initWithArea_id:1];
    [self.navigationController pushViewController:vc animated:YES];
}






- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout meng_id:(NSInteger)meng_id{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.meng_id = meng_id;
    }
    return self;
}


@end
