//
//  myinfoCell1.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/8/2.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "myinfoCell1.h"

@interface myinfoCell1()

@end

@implementation myinfoCell1


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.infotext];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.typelab.frame = CGRectMake(14, 10, 100, 30);
    self.infotext.frame = CGRectMake(150, 10, kScreenW-14-150, 30);
    
}

#pragma mark - getters


-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _typelab;
}

-(UITextField *)infotext
{
    if(!_infotext)
    {
        _infotext = [[UITextField alloc] init];
        _infotext.textAlignment = NSTextAlignmentRight;
        _infotext.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _infotext;
}



@end
