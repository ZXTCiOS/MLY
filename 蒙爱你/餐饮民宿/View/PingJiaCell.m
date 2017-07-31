//
//  PingJiaCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/31.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "PingJiaCell.h"

@implementation PingJiaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 20;
    self.imgV.layer.masksToBounds = YES;
    self.starV = [[WTKStarView alloc] initWithFrame:CGRectMake(65, 40, 65, 12) starSize:CGSizeMake(10, 10) withStyle:WTKStarTypeInteger];
    self.starV.star = 0;
    [self addSubview:self.starV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
