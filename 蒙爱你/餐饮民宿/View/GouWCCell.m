//
//  GouWCCell.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/29.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "GouWCCell.h"

@interface GouWCCell ()

@property (weak, nonatomic) IBOutlet UIButton *sub;

@property (weak, nonatomic) IBOutlet UIButton *plus;

@end


@implementation GouWCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)plus:(id)sender {
    NSInteger i = self.count.text.integerValue;
    self.count.text = [NSString stringWithFormat:@"%ld", ++i];
    
}
- (IBAction)sub:(id)sender {
    NSInteger i = self.count.text.integerValue;
    if (i == 1) return;
    self.count.text = [NSString stringWithFormat:@"%ld", --i];
}

- (void)setIsSel:(BOOL)isSel{
    _isSel = isSel;
    NSString *img = isSel ? @"shdz-s": @"shdi-ns";
    [_isselected setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
