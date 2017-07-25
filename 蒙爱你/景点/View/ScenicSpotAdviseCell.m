//
//  ScenicSpotAdviseCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicSpotAdviseCell.h"


@interface ScenicSpotAdviseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *likeIMG;


@end

@implementation ScenicSpotAdviseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.islike = NO;
}

- (void)setIslike:(BOOL)islike{
    _islike = islike;
    NSString *img = islike ? @"sc-s": @"sc-nc";
    [self.likeIMG setImage:[UIImage imageNamed:img]];
}


@end
