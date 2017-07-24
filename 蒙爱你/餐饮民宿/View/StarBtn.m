//
//  StarBtn.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/14.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "StarBtn.h"

@implementation StarBtn





- (instancetype)init{
    self = [super init];
    if (self) {
        [self star];
        _isSelect = NO;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 2;
        
    }
    return self;
}


- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (isSelect) {
        self.backgroundColor = krgb(211, 0, 52, 1);
        self.star.textColor = [UIColor whiteColor];
        self.img.image = [UIImage imageNamed:@"ms-sx-xx-w"];
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.star.textColor = [UIColor blackColor];
        self.img.image = [UIImage imageNamed:@"ms-sx-xx-g"];
    }
}



- (UILabel *)star{
    if (!_star) {
        _star = [[UILabel alloc] init];
        _star.font = [UIFont systemFontOfSize:14];
        [self addSubview:_star];
        [_star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(20);
        }];
    }
    return _star;
}

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ms-sx-xx-g"]];
        [self addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-20);
            make.size.equalTo(CGSizeMake(14, 14));
        }];
    }
    return _img;
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
