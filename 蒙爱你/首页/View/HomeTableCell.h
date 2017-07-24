//
//  HomeTableCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScenicSpotAdviseCell.h"
#import "TravelAdviseCell.h"
#import "FoodAndHotelCell.h"


#define ScenicSpotAdviseC @"ScenicSpotAdviseCell"
#define TravelAdviseC @"TravelAdviseCell"
#define FoodAndHotelC @"FoodAndHotelCell"

@class HomeTableCell;


@interface HomeTableCell : UITableViewCell<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectV;

@property (nonatomic, strong) void(^didScroll)(CGFloat contentOffset_x, CGFloat contenSize_w);

@property (nonatomic, assign) NSInteger offset_x;

@end
