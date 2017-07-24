//
//  commodityCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "commodityCell.h"


@interface commodityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storedV;

@end


@implementation commodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





- (void)setIsStored:(BOOL)isStored{
    
    UIImage *image = [UIImage imageNamed:isStored ? @"" : @""];
    self.storedV.image = image;
}






@end
