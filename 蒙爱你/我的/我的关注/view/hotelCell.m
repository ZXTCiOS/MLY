//
//  hotelCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "hotelCell.h"
#import "WTKStarView.h"

#import "shoucanghomeModel.h"

@interface hotelCell()
@property (nonatomic,strong) UIImageView *hotelImg;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UILabel *demolab;
@property (nonatomic,strong) WTKStarView *starView;
@property (nonatomic,strong) shoucanghomeModel *hmodel;
@end

@implementation hotelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotelImg];
        [self addSubview:self.contentLab];
        [self addSubview:self.cancleBtn];
        [self addSubview:self.demolab];
        _starView = [[WTKStarView alloc]initWithFrame:CGRectMake(75 / 2.0, 100, 80, 30) starSize:CGSizeZero withStyle:WTKStarTypeFloat];
        _starView.isTouch = NO;
      
        
        [self addSubview:_starView];
        
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.hotelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-10*WIDTH_SCALE);
        make.height.mas_offset(150*WIDTH_SCALE);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.hotelImg.mas_left);
        make.right.equalTo(weakSelf.hotelImg.mas_right);
        make.top.equalTo(weakSelf.hotelImg.mas_bottom).with.offset(10);
    }];
    
    [self.demolab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.hotelImg.mas_left);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.height.mas_equalTo(20*HEIGHT_SCALE);
        make.width.mas_equalTo(40);
    }];
    
    //self.demolab.backgroundColor = [UIColor redColor];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.demolab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.demolab.mas_top).with.offset(-5*HEIGHT_SCALE);
        make.height.mas_equalTo(20*HEIGHT_SCALE);
        make.width.mas_equalTo(50);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-5);
        make.width.mas_offset(60);
        make.height.mas_offset(15*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
    }];
    
}


#pragma mark - getters


-(UIImageView *)hotelImg
{
    if(!_hotelImg)
    {
        _hotelImg = [[UIImageView alloc] init];

    }
    return _hotelImg;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];

        _contentLab.numberOfLines = 2;
        
    }
    return _contentLab;
}

-(UILabel *)demolab
{
    if(!_demolab)
    {
        _demolab = [[UILabel alloc] init];
        _demolab.text = @"等级：";
        _demolab.textColor = [UIColor blackColor];
        _demolab.font = [UIFont systemFontOfSize:13];
    }
    return _demolab;
}

-(UIButton *)cancleBtn
{
    if(!_cancleBtn)
    {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setTitle:@"取消收藏" forState:normal];
        [_cancleBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancleBtn addTarget:self action:@selector(canclebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

-(void)canclebtnclick
{
    [self.delegate myTabVClick1:self];
}

#pragma mark - 数据源

-(void)setdata:(shoucanghomeModel *)model
{
    self.hmodel = model;
    [self.hotelImg sd_setImageWithURL:[NSURL URLWithString:model.home_pic] placeholderImage:[UIImage imageNamed:@"1"]];
    NSString *str1 = model.home_name;
    NSString *str2 = model.home_description;
    NSString *newestr = [NSString stringWithFormat:@"%@%@",model.home_name,model.home_description];
    self.starView.star = [model.home_star floatValue];
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:newestr];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0076b3"] range:NSMakeRange(0,str1.length)];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(str1.length,str2.length)];
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str1.length)];//设置所有的字体
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(str1.length, str2.length)];//设置所有的字体
    self.contentLab.attributedText = attstr;
}

@end
