//
//  FoodAndHotelCell.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodAndHotelCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (weak, nonatomic) IBOutlet UILabel *desc;


@property (nonatomic, assign) NSInteger star;

@property (nonatomic, assign) BOOL isStored;

@property (weak, nonatomic) IBOutlet UILabel *detailL;


@end
