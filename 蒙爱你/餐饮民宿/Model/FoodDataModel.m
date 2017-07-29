//
//  FoodDataModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/28.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodDataModel.h"

@implementation FoodDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [FoodDetailModel class]
             };
}

@end
@implementation FoodDetailModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"food": [FoodModel class],
             @"home": [FoodHeadModel class]
             };
}

@end

@implementation FoodHeadModel



@end

@implementation FoodModel



@end




