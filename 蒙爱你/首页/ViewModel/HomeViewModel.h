//
//  HomeViewModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeBannerModel.h"
#import "HomeFoodModel.h"
#import "HomeTravelModel.h"
#import "HomeScenicModel.h"
#import "HomeModel.h"


typedef NS_ENUM(NSUInteger, HomeMoreOfType) {
    HomeMoreOfTypeScenic,
    HomeMoreOfTypeTravel,
    HomeMoreOfTypeFood,
};

@interface HomeViewModel : NSObject


@property (nonatomic, strong) NSMutableArray<HomeBannerModel *> *bannerList;

@property (nonatomic, strong) NSMutableArray<HomeScenicModel *> *scenicList;

@property (nonatomic, strong) NSMutableArray<HomeTravelModel *> *travelList;

@property (nonatomic, strong) NSMutableArray<HomeFoodModel *> *foodList;

@property (nonatomic, assign) NSInteger scenicNum;

@property (nonatomic, assign) NSInteger travelNum;

@property (nonatomic, assign) NSInteger foodNum;



















- (void)PostMoreType:(HomeMoreOfType) type completionHandller:(void (^)(NSError *error)) handller;

- (void)GetRefreshHomeCompletionHandller:(void (^)(NSError *error)) handller;



@end
