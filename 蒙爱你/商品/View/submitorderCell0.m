//
//  submitorderCell0.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "submitorderCell0.h"
#import "strisNull.h"
@interface submitorderCell0()
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *addresslab;

@end

@implementation submitorderCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.addresslab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
//    [self.traveImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf).with.offset(10*WIDTH_SCALE);
//        make.top.equalTo(weakSelf).with.offset(15*HEIGHT_SCALE);
//        make.right.equalTo(weakSelf).with.offset(-10*WIDTH_SCALE);
//        make.bottom.equalTo(weakSelf).with.offset(-60*HEIGHT_SCALE);
//    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(10*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    [self.addresslab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(5*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
    
}


-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        //_namelab.backgroundColor = [UIColor greenColor];
        _namelab.textColor = [UIColor colorWithHexString:@"999999"];
        _namelab.font = [UIFont systemFontOfSize:14];
        _namelab.text = @"王俊钢 15510922836";
    }
    return _namelab;
}

-(UILabel *)addresslab
{
    if(!_addresslab)
    {
        _addresslab = [[UILabel alloc] init];
       // _addresslab.backgroundColor = [UIColor orangeColor];
        _addresslab.textColor = [UIColor colorWithHexString:@"333333"];
        _addresslab.font = [UIFont systemFontOfSize:12];
        _addresslab.text = @"送至 ：北京市海淀区五道口";
    }
    return _addresslab;
}

-(void)setdata:(NSDictionary *)dic
{
   // NSString *addid = [dic objectForKey:@"addid"];
    if ([strisNull isNullToString:[dic objectForKey:@"address_adds"]]) {
        
        NSString *addressass = [dic objectForKey:@"addressass"];
        NSString *name = [dic objectForKey:@"name"];
        NSString *phone = [dic objectForKey:@"phone"];
        self.namelab.text = [NSString stringWithFormat:@"%@%@%@",name,@" ",phone];
        self.addresslab.text = addressass;
    }
    else
    {
        
        NSString *addressass = [dic objectForKey:@"address_adds"];
        NSString *name = [dic objectForKey:@"address_name"];
        NSString *phone = [dic objectForKey:@"address_phone"];
        self.namelab.text = [NSString stringWithFormat:@"%@%@%@",name,@" ",phone];
        self.addresslab.text = addressass;
    }
    
//    NSString *addressass = [dic objectForKey:@"addressass"];
//    NSString *name = [dic objectForKey:@"name"];
//    NSString *phone = [dic objectForKey:@"phone"];
//    self.namelab.text = [NSString stringWithFormat:@"%@%@%@",name,@" ",phone];
//    self.addresslab.text = addressass;
}

@end
