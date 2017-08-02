//
//  myinfoCell0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/2.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myinfoCell0.h"

@interface myinfoCell0()
@property (nonatomic,strong) UILabel *namelab;

@end

@implementation myinfoCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
       // [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.infoimg];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.namelab.frame = CGRectMake(14, 10, 100, 30);
    self.infoimg.frame = CGRectMake(kScreenW-14-60, 30, 60, 60);
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"头像";
        
    }
    return _namelab;
}

-(UIImageView *)infoimg
{
    if(!_infoimg)
    {
        _infoimg = [[UIImageView alloc] init];
        _infoimg.layer.masksToBounds = YES;
        _infoimg.layer.cornerRadius = 30;
    }
    return _infoimg;
}



@end
