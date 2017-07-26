//
//  myorderCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myorderCell.h"

@interface myorderCell()
@property (nonatomic,strong) UIImageView *orderImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *totalLab;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *payBtn;
@end

@implementation myorderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.orderImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.totalLab];
        [self.contentView addSubview:self.cancelBtn];
        [self.contentView addSubview:self.payBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    
}

#pragma mark - getters


-(UIImageView *)orderImg
{
    if(!_orderImg)
    {
        _orderImg = [[UIImageView alloc] init];
        _orderImg.backgroundColor = [UIColor orangeColor];
    }
    return _orderImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _nameLab.font  = [UIFont systemFontOfSize:18];
        
    }
    return _nameLab;
}


-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = [UIColor colorWithHexString:@"df0842"];
        _priceLab.font = [UIFont systemFontOfSize:15];
        
    }
    return _priceLab;
}



@end
