//
//  TravelAdviseCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/4.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "TravelAdviseCell.h"
#import "HomeTravelModel.h"

@interface TravelAdviseCell()
@property (nonatomic,strong) HomeTravelModel *hmodel;
@end

@implementation TravelAdviseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageV.layer.masksToBounds = YES;
    
}

- (void)setIsStored:(BOOL)isStored{
    _isStored = isStored;
    NSString *img = isStored ? @"sc-s": @"sc-ns";
    self.shoucangImg.image = [UIImage imageNamed:img];
    self.shoucangImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.shoucangImg addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
//    [self.delegate myTabVClick1:self];
    //do something....
    NSLog(@"do something......");
}

@end
