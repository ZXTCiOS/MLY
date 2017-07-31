//
//  submitorderCell2.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitorderCell2.h"

@interface submitorderCell2()
@property (nonatomic,strong) UILabel *typelab;


@end

@implementation submitorderCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.numlab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(5*HEIGHT_SCALE);
        make.width.mas_offset(160*WIDTH_SCALE);
        make.bottom.equalTo(weakSelf).with.offset(-5*HEIGHT_SCALE);
    }];
    [self.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.typelab.mas_right).with.offset(60*WIDTH_SCALE);
        make.top.equalTo(weakSelf.typelab);
        make.bottom.equalTo(weakSelf.typelab);
        make.right.equalTo(weakSelf).with.offset(-34*WIDTH_SCALE);
    }];
    
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"使用优惠券";
        _typelab.textColor = [UIColor colorWithHexString:@"999999"];
        _typelab.font = [UIFont systemFontOfSize:14];
    }
    return _typelab;
}

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc] init];
        _numlab.textAlignment = NSTextAlignmentRight;
        _numlab.font = [UIFont systemFontOfSize:14];

        _numlab.textColor = [UIColor colorWithHexString:@"df0842"];
    }
    return _numlab;
}




@end
