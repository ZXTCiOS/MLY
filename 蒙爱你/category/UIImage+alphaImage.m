//
//  UIImage+alphaImage.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/13.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "UIImage+alphaImage.h"

@implementation UIImage (alphaImage)



+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
