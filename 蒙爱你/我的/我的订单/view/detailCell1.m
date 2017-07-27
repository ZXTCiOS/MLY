//
//  detailCell1.m
//  蒙爱你
//
//  Created by 王俊钢 on 2017/7/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "detailCell1.h"

@implementation detailCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
