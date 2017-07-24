//
//  HomeModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
kCodingDesc






@end

@implementation HomeDataModel

kCodingDesc
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    NSDictionary *dic = @{@"jingdian": [HomeScenicModel class],
                          @"chuxing": [HomeTravelModel class],
                          @"minsu": [HomeFoodModel class],
                          @"lunbo": [HomeBannerModel class]
                          };
    return dic;
}


@end

