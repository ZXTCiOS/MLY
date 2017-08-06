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
    _isLike = isLike;
    NSString *img = isLike ? @"sc-s" :@"sc-ns";
    self.likeV.image = [UIImage imageNamed:img];
}








- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shoucangImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.shoucangImg addGestureRecognizer:singleTap];
    // Initialization code
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    [self.delegate myTabVClickticket:self];
    //do something....
    NSLog(@"do something......");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
