//
//  commodityCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "commodityCell.h"
#import "ShopGoodsModel.h"

@interface commodityCell ()

@property (weak, nonatomic) IBOutlet UIImageView *storedV;
@property (nonatomic,strong) ShopGoodsModel *smodel;
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



-(void)setData:(ShopGoodsModel *)model
{
    self.smodel = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:nil];
    self.nameL.text = model.goods_name;
    self.detailL.text = model.goods_detail;
    self.describeL.text = model.goods_description;
    self.priceL.text = [NSString stringWithFormat:@"%@%ld",@"$",(long)model.goods_price];
    self.discountL.text = [NSString stringWithFormat:@"满%ld件批发单价%ld",(long)model.goods_lownum,(long)model.goods_lowprice];
}


@end
