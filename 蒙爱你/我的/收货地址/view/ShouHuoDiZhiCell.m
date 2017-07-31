//
//  ShouHuoDiZhiCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShouHuoDiZhiCell.h"
#import "addressModel.h"

@interface ShouHuoDiZhiCell()
@property (nonatomic,strong) addressModel *amodel;

@end

@implementation ShouHuoDiZhiCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.isDefault.layer.cornerRadius = 10;
    self.isDefault.layer.masksToBounds = YES;
    [self.editBtn bk_addEventHandler:^(id sender) {
        !_edit ?: _edit();
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.isDefault addTarget:self action:@selector(isDefaultclick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)isDefaultclick
{
    [self.delegate myTabVClick1:self];
}

-(void)setdata:(addressModel *)model
{
    self.amodel = model;
    if ([model.isDefaultstr isEqualToString:@"0"]) {
        [self.isDefault setImage:[UIImage imageNamed:@"shdz-s"] forState:normal];
    }
    else
    {
        [self.isDefault setImage:[UIImage imageNamed:@"shdi-ns"] forState:normal];
    }
    self.nameL.text = model.address_name;
    self.tele.text = model.address_phone;
    self.addressL.text = model.address_adds;
}
@end
