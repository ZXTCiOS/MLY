//
//  subbuttomView.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/30.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "subbuttomView.h"

@implementation subbuttomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pricelab];
        [self addSubview:self.submitBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.pricelab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)pricelab
{
    if(!_pricelab)
    {
        _pricelab = [[UILabel alloc] init];
        _pricelab.font = [UIFont systemFontOfSize:14];
        _pricelab.textAlignment = NSTextAlignmentCenter;
        _pricelab.text = @"价格价格价格";
    }
    return _pricelab;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setImage:[UIImage imageNamed:@"dd-btn-tjdd"] forState:normal];
    }
    return _submitBtn;
}




@end
