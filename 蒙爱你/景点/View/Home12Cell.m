//
//  Home12Cell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Home12Cell.h"

@implementation Home12Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
