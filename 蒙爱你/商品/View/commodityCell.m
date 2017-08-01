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
    self.storedV.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.storedV addGestureRecognizer:singleTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {

    }
    return self;
}

- (void)setIsStored:(BOOL)isStored{
    


}




- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.delegate myTabVClick1:self];
    //do something....
    NSLog(@"'do something");
}

-(void)setData:(ShopGoodsModel *)model
{
    self.smodel = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:[UIImage imageNamed:@"1"]];

    if (model.isStored) {
        self.storedV.image = [UIImage imageNamed:@"sc-s"];
    }
    else
    {
        self.storedV.image = [UIImage imageNamed:@"sc-ns"];
    }
    
    self.nameL.text = model.goods_name;
    self.detailL.text = model.goods_detail;
    self.describeL.text = model.goods_description;
    self.priceL.text = [NSString stringWithFormat:@"%@%ld",@"¥",(long)model.goods_price];
    self.discountL.text = [NSString stringWithFormat:@"满%ld件批发单价%ld",(long)model.goods_lownum,(long)model.goods_lowprice];
}

@end
