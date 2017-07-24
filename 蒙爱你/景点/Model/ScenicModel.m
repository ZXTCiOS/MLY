//
//  ScenicModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicModel.h"

@implementation ScenicModel



+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"jingdian_ticket": [tickets class],
             @"jingdian_lunbo": [ScenicBannerModel class]
             };
}




@end



@implementation tickets



@end


@implementation ScenicBannerModel



@end


@implementation ScenicDetailModel



@end


