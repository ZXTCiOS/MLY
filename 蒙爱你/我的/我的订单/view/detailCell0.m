//
//  detailCell0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "detailCell0.h"

@interface detailCell0()
@property (nonatomic,strong) UIImageView *detalimg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *numLab;

@end

@implementation detailCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.detalimg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentLab addSubview:self.numLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.detalimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.height.mas_equalTo(90*WIDTH_SCALE);
        make.width.mas_equalTo(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);

    }];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.detalimg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_equalTo(120);
        
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_top);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.detalimg.mas_right).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];

}

#pragma mark - getters

-(UIImageView *)detalimg
{
    if(!_detalimg)
    {
        _detalimg = [[UIImageView alloc] init];
        _detalimg.backgroundColor = [UIColor orangeColor];
    }
    return _detalimg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _nameLab.font  = [UIFont systemFontOfSize:18];
        _nameLab.text = @"大床房";
        
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.numberOfLines = 2;
        _contentLab.text = @"接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）接下来还需要您在服务器上绑定您的域名（主机域名绑定），同时将域名指向您的网站（就是通过域名解析将域名与服务器 IP 地址绑定）";
    }
    return _contentLab;
}


-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = [UIColor colorWithHexString:@"df0842"];
        _priceLab.font = [UIFont systemFontOfSize:15];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.text = @"90/天";
    }
    return _priceLab;
}

-(UILabel *)numLab
{
    if(!_numLab)
    {
        _numLab = [[UILabel alloc] init];
        _numLab.textColor = [UIColor colorWithHexString:@"999999"];
        _numLab.textAlignment = NSTextAlignmentRight;
        _numLab.font = [UIFont systemFontOfSize:14];
        _numLab.text = @"X2";
    }
    return _numLab;
}







@end
