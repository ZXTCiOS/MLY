//
//  travelCell.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "travelCell.h"

@interface travelCell()
@property (nonatomic,strong) UIImageView *traveImg;
@property (nonatomic,strong) UILabel *addressLab;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation travelCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.traveImg];
        [self addSubview:self.addressLab];
        [self addSubview:self.cancelBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.traveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-10*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-60*HEIGHT_SCALE);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.traveImg.mas_left);
        make.top.equalTo(weakSelf.traveImg.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.width.equalTo(weakSelf.traveImg);
        
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-10);
        make.width.mas_offset(60);
        make.height.mas_offset(20);
        make.bottom.equalTo(weakSelf).with.offset(-5);
    }];
    
}

#pragma mark - getters


-(UIImageView *)traveImg
{
    if(!_traveImg)
    {
        _traveImg = [[UIImageView alloc] init];
        _traveImg.backgroundColor = [UIColor orangeColor];
        
    }
    return _traveImg;
}

-(UILabel *)addressLab
{
    if(!_addressLab)
    {
        _addressLab = [[UILabel alloc] init];
        _addressLab.text = @"包头->鄂尔多斯";
    }
    return _addressLab;
}


-(UIButton *)cancelBtn
{
    if(!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消收藏" forState:normal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"df0842"] forState:normal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _cancelBtn;
}





@end
