//
//  evaluaBtn.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "evaluaBtn.h"

@implementation evaluaBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.evalualab];
        [self addSubview:self.evaluaimg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.evalualab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(5);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(20);
        make.top.equalTo(weakSelf);
    }];
    [self.evaluaimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.evalualab.mas_right).with.offset(5);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
}

#pragma mark - getters

-(UIImageView *)evaluaimg
{
    if(!_evaluaimg)
    {
        _evaluaimg = [[UIImageView alloc] init];

    }
    return _evaluaimg;
}

-(UILabel *)evalualab
{
    if(!_evalualab)
    {
        _evalualab = [[UILabel alloc] init];
        _evalualab.font = [UIFont systemFontOfSize:12];
        _evalualab.textAlignment = NSTextAlignmentRight;
    }
    return _evalualab;
}




@end
