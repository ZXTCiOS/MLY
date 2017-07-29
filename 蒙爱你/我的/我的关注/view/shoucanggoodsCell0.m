//
//  shoucanggoodsCell0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "shoucanggoodsCell0.h"
#import "shoucanggoodsModel.h"

@interface shoucanggoodsCell0()
@property (nonatomic,strong) UIImageView *goodsimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *totallab;
@property (nonatomic,strong) shoucanggoodsModel *smodel;

@end

@implementation shoucanggoodsCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.goodsimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.pricelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.totallab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.goodsimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.height.mas_equalTo(90*WIDTH_SCALE);
        make.width.mas_equalTo(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
        
    }];
    
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsimg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_equalTo(120);
        
    }];
    
    [self.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.namelab.mas_top);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(100);
    }];

    [self.totallab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.namelab.mas_left);
        make.right.equalTo(weakSelf).with.offset(-14);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.totallab.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.totallab.mas_left);
        make.right.equalTo(weakSelf.totallab.mas_right);
    }];
    
}

#pragma mark - getters


-(UIImageView *)goodsimg
{
    if(!_goodsimg)
    {
        _goodsimg = [[UIImageView alloc] init];
        _goodsimg.backgroundColor = [UIColor orangeColor];
        
    }
    return _goodsimg;
}


-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _namelab.font  = [UIFont systemFontOfSize:18];
        _namelab.text = @"大床房";
    }
    return _namelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentlab.font = [UIFont systemFontOfSize:13];
        _contentlab.numberOfLines = 2;
        _contentlab.text = @"接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）";
    }
    return _contentlab;
}

-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.textColor = [UIColor colorWithHexString:@"df0842"];
        _pricelab.font = [UIFont systemFontOfSize:15];
        _pricelab.textAlignment = NSTextAlignmentRight;
        _pricelab.text = @"90/天";
    }
    return _pricelab;
}

-(UILabel *)totallab
{
    if(!_totallab)
    {
        _totallab = [[UILabel alloc] init];
        _totallab.textColor = [UIColor colorWithHexString:@"999999"];
        _totallab.font = [UIFont systemFontOfSize:12];
        _totallab.text = @"GET请求的链接--";
    }
    return _totallab;
}

#pragma mark - 数据源方法

-(void)setdata:(shoucanggoodsModel *)model
{
    self.smodel = model;
    [self.goodsimg sd_setImageWithURL:[NSURL URLWithString:model.goods_pic] placeholderImage:nil];
    self.namelab.text = model.goods_name;
    self.contentlab.text = model.goods_intro;
    self.pricelab.text = [NSString stringWithFormat:@"%@%@",model.goods_price,@"／天"];
    self.totallab.text = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"单价¥",model.goods_price,@",满",model.goods_lownum,@"件批发价单价¥",model.goods_lowprice];
    
}

@end
