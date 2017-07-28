//
//  attractionsCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "attractionsCell.h"

@interface attractionsCell()
@property (nonatomic,strong) UIImageView *attraImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation attractionsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.attraImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.cancelBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.attraImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.height.mas_equalTo(120*HEIGHT_SCALE);
        make.width.mas_equalTo(90*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attraImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(30*HEIGHT_SCALE);
        make.width.mas_equalTo(120);
        
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.attraImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.attraImg.mas_right).with.offset(15*WIDTH_SCALE);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(15*HEIGHT_SCALE);
        make.height.mas_equalTo(20);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.height.mas_equalTo(30*HEIGHT_SCALE);
        make.width.mas_equalTo(80*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters


-(UIImageView *)attraImg
{
    if(!_attraImg)
    {
        _attraImg = [[UIImageView alloc] init];
        _attraImg.backgroundColor = [UIColor orangeColor];
        
    }
    return _attraImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"0b79b6"];
        _nameLab.font  = [UIFont systemFontOfSize:18];
        _nameLab.text = @"杭锦旗蒙古包";
        
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor colorWithHexString:@"333333"];
        _contentLab.numberOfLines = 2;
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.text = @"杭锦旗蒙古包杭锦旗蒙古包杭锦旗蒙古包杭锦旗蒙古包杭锦旗蒙古包杭锦旗蒙古包杭锦旗蒙古包";
    }
    return _contentLab;
}

-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"总价：120";
        _priceLab.font = [UIFont systemFontOfSize:18];
        
    }
    return _priceLab;
}

-(UIButton *)cancelBtn
{
    if(!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消收藏" forState:normal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.cornerRadius = 4;
        _cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"d5d5d5"].CGColor;
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"999999"] forState:normal];
        [_cancelBtn addTarget:self action:@selector(cancelbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(void)cancelbtnclick
{
    [self.delegate myTabVClick1:self];
}





@end
