//
//  HomeTableCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

- (UICollectionView *)collectV{
    if (!_collectV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenH, 100) collectionViewLayout:layout];
        [self.contentView addSubview:_collectV];
        [_collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(0);
        }];
        
        _collectV.backgroundColor = [UIColor whiteColor];
        _collectV.showsHorizontalScrollIndicator = NO;
        UINib *scenicNib = [UINib nibWithNibName:NSStringFromClass([ScenicSpotAdviseCell class]) bundle:nil];
        [_collectV registerNib:scenicNib forCellWithReuseIdentifier:ScenicSpotAdviseC];
        UINib *travelNib = [UINib nibWithNibName:NSStringFromClass([TravelAdviseCell class]) bundle:nil];
        [_collectV registerNib:travelNib forCellWithReuseIdentifier:TravelAdviseC];
        UINib *foodNib = [UINib nibWithNibName:NSStringFromClass([FoodAndHotelCell class]) bundle:nil];
        [_collectV registerNib:foodNib forCellWithReuseIdentifier:FoodAndHotelC];
    }
    return _collectV;
}

#pragma mark - collection Delegate


/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.contentSize.width;
    if (self.offset_x < x) {
        !self.didScroll ?: self.didScroll(x, width);
    }
    self.offset_x = x;
}

*/
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
