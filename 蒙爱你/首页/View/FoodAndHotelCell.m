//
//  FoodAndHotelCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodAndHotelCell.h"


@interface FoodAndHotelCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shoucang;


@end
@implementation FoodAndHotelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setIsStored:(BOOL)isStored{
    _isStored = isStored;
    NSString *img = isStored ? @"sc-s": @"sc-ns";
    self.shoucang.image = [UIImage imageNamed:img];
}

@end
