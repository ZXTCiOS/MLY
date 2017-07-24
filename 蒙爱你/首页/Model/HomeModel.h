//
//  HomeModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeScenicModel.h"
#import "HomeTravelModel.h"
#import "HomeFoodModel.h"
#import "HomeBannerModel.h"

@class HomeDataModel;
@interface HomeModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) HomeDataModel *data;

@property (nonatomic, copy) NSString *message;


@end

@interface HomeDataModel : NSObject

@property (nonatomic, strong) NSArray<HomeScenicModel *> *jingdian;

@property (nonatomic, strong) NSArray<HomeTravelModel *> *chuxing;

@property (nonatomic, strong) NSArray<HomeFoodModel *> *minsu;

@property (nonatomic, strong) NSArray<HomeBannerModel *> *lunbo;


@end
