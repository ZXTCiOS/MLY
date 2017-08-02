//
//  submitBtn.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/1.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitBtn.h"

@interface submitBtn()
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UILabel *titlelab;
@end

@implementation submitBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgimg];
        [self addSubview:self.titlelab];
    }
    return self;
}

#pragma mark - getters


-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        _bgimg.image = [UIImage imageNamed:@"dd-btn-fk"];
        _bgimg.frame = CGRectMake(0, 0, 60, 30);
    }
    return _bgimg;
}


-(UILabel *)titlelab
{
    if(!_titlelab)
    {
        _titlelab = [[UILabel alloc] init];
        _titlelab.text = @"提交";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:14];
        _titlelab.textColor = [UIColor whiteColor];
        _titlelab.frame = CGRectMake(0, 0, 60, 30);
    }
    return _titlelab;
}



@end
