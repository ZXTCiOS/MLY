//
//  NaviBar.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/20.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "NaviBar.h"

@implementation NaviBar






- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:17];
        _titleL.textColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(10);
            make.size.equalTo(CGSizeMake(kScreenW - 100, 18));
        }];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}


- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightBtn.frame = CGRectMake(15, 30, 20, 20);
        [_rightBtn setImage:[UIImage imageNamed:@"dh-fh-w"] forState:UIControlStateNormal];
        _rightBtn.tintColor = [UIColor whiteColor];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _backBtn.frame = CGRectMake(15, 30, 20, 20);
        [_backBtn setImage:[UIImage imageNamed:@"dh-fh-w"] forState:UIControlStateNormal];
        _backBtn.tintColor = [UIColor whiteColor];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [super initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
}



@end
