//
//  submitorderCell1.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitorderCell1.h"
#import "submitorderModel.h"
@interface submitorderCell1()
@property (nonatomic,strong) UIImageView *submitImg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *numlab;
@property (nonatomic,strong) UILabel *interlab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *pricelab;
@property (nonatomic,strong) submitorderModel *smodel;

@end

@implementation submitorderCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.submitImg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.numlab];
        [self.contentView addSubview:self.interlab];
        [self.contentView addSubview:self.contentlab];
        [self.contentlab addSubview:self.pricelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.submitImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.height.mas_equalTo(90*WIDTH_SCALE);
        make.width.mas_equalTo(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.submitImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_equalTo(120);
        make.height.mas_offset(15*HEIGHT_SCALE);
    }];
    
    [self.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.namelab.mas_top);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(100);
    }];
    
    [self.interlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.namelab.mas_left);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.interlab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.interlab);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
    [self.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.interlab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
}

#pragma mark - getters


-(UIImageView *)submitImg
{
    if(!_submitImg)
    {
        _submitImg = [[UIImageView alloc] init];

    }
    return _submitImg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];

        _namelab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _namelab.font  = [UIFont systemFontOfSize:18];

    }
    return _namelab;
}

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc] init];
        _numlab.textColor = [UIColor colorWithHexString:@"999999"];
        _numlab.textAlignment = NSTextAlignmentRight;
        _numlab.font = [UIFont systemFontOfSize:14];

    }
    return _numlab;
}

-(UILabel *)interlab
{
    if(!_interlab)
    {
        _interlab = [[UILabel alloc] init];
        _interlab.textColor = [UIColor colorWithHexString:@"333333"];
        _interlab.font = [UIFont systemFontOfSize:12];

    }
    return _interlab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.textColor = [UIColor colorWithHexString:@"999999"];
        _contentlab.font = [UIFont systemFontOfSize:14];
        _contentlab.numberOfLines = 2;

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

    }
    return _pricelab;
}


-(void)setdata:(submitorderModel *)model
{
    self.smodel = model;
    [self.submitImg sd_setImageWithURL:[NSURL URLWithString:model.orderimg] placeholderImage:[UIImage imageNamed:@"1"]];
    self.namelab.text = model.ordername;
    self.numlab.text = [NSString stringWithFormat:@"%@%@",@"X",model.ordernumber];
    self.pricelab.text = model.orderprice;
    self.interlab.text = model.orderinter;
    self.contentlab.text = model.ordercontent;
    
}




@end
