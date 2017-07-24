//
//  ShouHuoDiZhiCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ShouHuoDiZhiCell.h"

@implementation ShouHuoDiZhiCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.isDefault.layer.cornerRadius = 10;
    self.isDefault.layer.masksToBounds = YES;
    [self.editBtn bk_addEventHandler:^(id sender) {
        !_edit ?: _edit();
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
