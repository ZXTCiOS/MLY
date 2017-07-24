//
//  NewAddressCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/7.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "NewAddressCell.h"

@implementation NewAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config];
    }
    return self;
}



- (void)config{
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"新增地址";
    [label sizeToFit];
    label.textColor = krgb(212, 0, 52, 1);
    [view addSubview:img];
    [view addSubview:label];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(0);
        make.top.left.bottom.equalTo(0);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(img.mas_right).equalTo(8);
        make.right.equalTo(0);
    }];
    label.font = [UIFont systemFontOfSize:20];
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
