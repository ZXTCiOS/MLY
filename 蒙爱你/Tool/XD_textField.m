//
//  XD_textField.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/27.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "XD_textField.h"

@implementation XD_textField

- (CGRect)borderRectForBounds:(CGRect)bounds

{
    
//    if (self.height) {
//        bounds.size.height = self.height;
//        
//        return bounds;
//    }
//    
    bounds.size.height = 44;
    
    return bounds;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
