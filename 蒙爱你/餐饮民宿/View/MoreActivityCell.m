//
//  MoreActivityCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MoreActivityCell.h"

@implementation MoreActivityCell


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self img];
        [self title];
    }
    return self;
}


- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.size.equalTo(CGSizeMake(33, 33));
            make.centerY.equalTo(0);
        }];
    }
    return _img;
}



- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [self addSubview:_title];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = krgb(50, 53, 55, 1);
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(self.img.mas_right).equalTo(13);
            make.size.equalTo(CGSizeMake(65, 20));
        }];
    }
    return _title;
}

@end
