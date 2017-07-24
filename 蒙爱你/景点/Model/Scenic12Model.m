//
//  Scenic12Model.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "Scenic12Model.h"

@implementation Scenic12Model
kCodingDesc


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [ScenicAreaModel class]
             };
}


@end


@implementation ScenicAreaModel

kCodingDesc

@end
