//
//  ScenicCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicCell.h"

@interface ScenicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *likeV;


@end

@implementation ScenicCell







- (void)setIsLike:(BOOL)isLike{
    NSString *img = isLike ? @"" :@"";
    self.likeV.image = [UIImage imageNamed:img];
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
