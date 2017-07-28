//
//  shoucanggoodsCell1.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "shoucanggoodsCell1.h"
#import "shoucanggoodsModel.h"
@interface shoucanggoodsCell1()

@property (nonatomic,strong) UILabel *numlab;

@property (nonatomic,strong) UIButton *canclebtn;
@property (nonatomic,strong) UIButton *paybtn;
@property (nonatomic,strong) shoucanggoodsModel *smodel;
@end

@implementation shoucanggoodsCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.numlab];
        [self.contentView addSubview:self.canclebtn];
        [self.contentView addSubview:self.paybtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.paybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf).with.offset(-14);
    }];
    [self.canclebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.paybtn.mas_top);
        make.width.mas_equalTo(58*WIDTH_SCALE);
        make.height.mas_equalTo(25*HEIGHT_SCALE);
        make.right.mas_equalTo(weakSelf.paybtn.mas_left).with.offset(-8*WIDTH_SCALE);
    }];
    [self.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.paybtn.mas_top);
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.width.mas_offset(320*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc] init];
        _numlab.textColor = [UIColor colorWithHexString:@"999999"];
        _numlab.text = @"GET请求的链接-----";
        _numlab.font = [UIFont systemFontOfSize:14];
    }
    return _numlab;
}

-(UIButton *)canclebtn
{
    if(!_canclebtn)
    {
        _canclebtn = [[UIButton alloc] init];
        [_canclebtn addTarget:self action:@selector(canclebtnclick) forControlEvents:UIControlEventTouchUpInside];
        _canclebtn.layer.masksToBounds = YES;
        _canclebtn.layer.borderWidth = 1;
        _canclebtn.layer.borderColor = [UIColor colorWithHexString:@"d5d5d5"].CGColor;
        [_canclebtn setTitle:@"取消收藏" forState:normal];
        _canclebtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_canclebtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:normal];
    }
    return _canclebtn;
}

-(UIButton *)paybtn
{
    if(!_paybtn)
    {
        _paybtn = [[UIButton alloc] init];
        [_paybtn addTarget:self action:@selector(paybtnclick) forControlEvents:UIControlEventTouchUpInside];
        _paybtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dd-btn-fk"]];
        [_paybtn setTitleColor:[UIColor whiteColor] forState:normal];
        [_paybtn setTitle:@"购买" forState:normal];
    }
    return _paybtn;
}

#pragma mark - 数据源方法

-(void)setdata:(shoucanggoodsModel *)model
{
    self.smodel = model;
    
    self.numlab.text = [NSString stringWithFormat:@"%@%@%@%@",@"满",model.goods_lownum,@"件批发价单价¥",model.goods_lowprice];
    
}


#pragma mark - 实现方法

-(void)canclebtnclick
{
    [self.delegate myTabVClick1:self];
}

-(void)paybtnclick
{
    [self.delegate myTabVClick2:self];
}

@end
