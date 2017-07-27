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


@property (weak, nonatomic) IBOutlet UIImageView *star1;

@property (weak, nonatomic) IBOutlet UIImageView *star2;

@property (weak, nonatomic) IBOutlet UIImageView *star3;

@property (weak, nonatomic) IBOutlet UIImageView *star4;

@property (weak, nonatomic) IBOutlet UIImageView *star5;



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


- (void)setStar:(NSInteger)star{
    _star = star;
    
    self.star1.image = [UIImage imageNamed:@"xj-ns"];
    self.star2.image = [UIImage imageNamed:@"xj-ns"];
    self.star3.image = [UIImage imageNamed:@"xj-ns"];
    self.star4.image = [UIImage imageNamed:@"xj-ns"];
    self.star5.image = [UIImage imageNamed:@"xj-ns"];
    
    
    if (star < 1) return;
    self.star1.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 2) return;
    self.star2.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 3) return;
    self.star3.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 4) return;
    self.star4.image = [UIImage imageNamed:@"xj-s-b"];
    if (star < 5) return;
    self.star5.image = [UIImage imageNamed:@"xj-s-b"];
    
}


@end
