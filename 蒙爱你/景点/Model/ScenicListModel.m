//
//  ScenicListModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/24.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicListModel.h"

@implementation ScenicListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [ScenicelEmentModel class]
             };
}

@end
@implementation ScenicelEmentModel



@end
