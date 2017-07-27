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
    
    self.kefuBtn.layer.borderWidth = 1.5;
    self.kefuBtn.layer.borderColor = krgb(135, 135, 135, 1).CGColor;
    
}

@end
