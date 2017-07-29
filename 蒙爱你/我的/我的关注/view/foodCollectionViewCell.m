//
//  foodCollectionViewCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "foodCollectionViewCell.h"
#import "shoucangfoodModel.h"

@interface foodCollectionViewCell()
@property (nonatomic,strong) UIImageView *foodimg;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIButton *carcleBtn;
@property (nonatomic,strong) shoucangfoodModel *fmodel;

@end

@implementation foodCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.foodimg];
        [self addSubview:self.contentlab];
        [self addSubview:self.carcleBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.foodimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-10*WIDTH_SCALE);
        make.height.mas_offset(150*WIDTH_SCALE);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.foodimg.mas_left);
        make.top.equalTo(weakSelf.foodimg.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.width.equalTo(weakSelf.foodimg);
        
    }];
    
    [self.carcleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-5);
    }];
}

#pragma mark - getters


-(UIImageView *)foodimg
{
    if(!_foodimg)
    {
        _foodimg = [[UIImageView alloc] init];
    }
    return _foodimg;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.numberOfLines = 2;
    }
    return _contentlab;
}

-(UIButton *)carcleBtn
{
    if(!_carcleBtn)
    {
        _carcleBtn = [[UIButton alloc] init];
        [_carcleBtn setTitle:@"取消收藏" forState:normal];
        [_carcleBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _carcleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_carcleBtn addTarget:self action:@selector(carclebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _carcleBtn;
}

#pragma mark -  实现方法

-(void)carclebtnclick
{
    [self.delegate myTabVClick1:self];
}

-(void)setdata:(shoucangfoodModel *)model
{
    self.fmodel = model;
    [self.foodimg sd_setImageWithURL:[NSURL URLWithString:model.home_pic]];
    NSString *str1 = model.home_name;
    NSString *str2 = model.home_description;
    NSString *newstr = [NSString stringWithFormat:@"%@%@",str1,str2];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:newstr];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0076b3"] range:NSMakeRange(0,str1.length)];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length,str2.length)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str1.length)];//设置所有的字体
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(str1.length, str2.length)];//设置所有的字体
    self.contentlab.attributedText = attstr;
}
@end
