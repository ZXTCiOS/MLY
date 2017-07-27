//
//  MinsuListModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MinsuListModel.h"

@implementation MinsuListModel


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [HomeFoodModel class]
             };
}


@end
