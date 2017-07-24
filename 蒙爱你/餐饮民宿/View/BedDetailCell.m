//
//  BedDetailCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/17.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "BedDetailCell.h"

@implementation BedDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.kefuBtn bk_addEventHandler:^(id sender) {
        !_kefu ?: _kefu();
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.buyBtn bk_addEventHandler:^(id sender) {
        !_buynow ?: _buynow();
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.shouqiBtn bk_addEventHandler:^(id sender) {
        !_shouqizhankai ?: _shouqizhankai(_shouqiBtn);
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.imgV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
