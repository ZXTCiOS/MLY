//
//  MinsuDetailModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/21.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MinsuDetailModel.h"

@implementation MinsuDetailModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": [MinsuDataModel class]
             
             };
}

@end

@implementation MinsuDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"art": [MinsuArtModel class],
             @"eat": [MinsuBedModel class],
             @"bed": [MinsuBedModel class],
             @"eval": [MinsuEvaluate class],
             @"home": [MinsuHomeModel class]
             };
}

@end

@implementation MinsuBedModel

@end


@implementation MinsuArtModel



@end

@implementation MinsuEvaluate



@end

@implementation MinsuHomeModel



@end




























