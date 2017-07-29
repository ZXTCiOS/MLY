//
//  ChooseView.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/14.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    StarBtn *lastBtn = nil;
    for (int i = 0; i < 5; i++) {
        
        StarBtn *btn = [[StarBtn alloc] init];
        [btn bk_addEventHandler:^(StarBtn *sender) {
            
            sender.isSelect = !sender.isSelect;
            
        } forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        btn.star.text = [NSString stringWithFormat:@"%d", i];
        [self addSubview:btn];
        btn.isSelect = NO;
        if (i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(10);
                make.top.equalTo(50);
                make.height.equalTo(30);
            }];
        } else if (i == 4) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-10);
                make.height.equalTo(30);
                make.top.equalTo(50);
                make.left.equalTo(lastBtn.mas_right).equalTo(10);
                make.width.equalTo(lastBtn.mas_width);
            }];
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastBtn.mas_right).equalTo(10);
                make.height.equalTo(30);
                make.top.equalTo(50);
                make.width.equalTo(lastBtn.mas_width);
            }];
            
        }
        lastBtn = btn;
        
        switch (i) {
            case 0:
                _star1 = btn;
                break;
            case 1:
                _star2 = btn;
                break;
            case 2:
                _star3 = btn;
                break;
            case 3:
                _star4 = btn;
                break;
            case 4:
                _star5 = btn;
                break;
            default:
                break;
        }
        
        
    }
    
    [self.quedignBtn bk_addEventHandler:^(id sender) {
        
        
        
        !_queding ?: _queding();
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
