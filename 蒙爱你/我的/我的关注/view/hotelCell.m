//
//  hotelCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "hotelCell.h"
#import "WTKStarView.h"
@interface hotelCell()
@property (nonatomic,strong) UIImageView *hotelImg;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UILabel *demolab;
@property (nonatomic,strong) WTKStarView *starView;
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
        _starView.star = [@"3" floatValue];
        
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
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(40);
    }];
    
    //self.demolab.backgroundColor = [UIColor redColor];
    
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.demolab.mas_right).with.offset(5);
        make.top.equalTo(weakSelf.demolab.mas_top).with.offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-10);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
        make.bottom.equalTo(weakSelf).with.offset(-5);
    }];
    
    
}


#pragma mark - getters


-(UIImageView *)hotelImg
{
    if(!_hotelImg)
    {
        _hotelImg = [[UIImageView alloc] init];
        _hotelImg.backgroundColor = [UIColor orangeColor];
    }
    return _hotelImg;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.backgroundColor = [UIColor greenColor];
        _contentLab.numberOfLines = 2;
        _contentLab.text = @"请在Info.plist文件中配置你的MOBAppKey和MOBAppSecret.请在Info.plist文件中配置你的MOBAppKey和MOBAppSecret.";
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
    }
    return _cancleBtn;
}



@end
