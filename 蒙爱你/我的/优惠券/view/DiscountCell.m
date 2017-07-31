//
//  DiscountCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "DiscountCell.h"
#import "discountModel.h"
@interface DiscountCell()
@property (nonatomic,strong) discountModel *dmodel;

@end

@implementation DiscountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setdata:(discountModel *)model
{
    self.dmodel = model;
    self.youhui.text = model.discount_jian;
    self.youhuiman.text = model.discount_man;
}

@end
