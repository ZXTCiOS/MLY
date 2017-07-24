//
//  ScenicViewModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeScenicModel.h"
#import "ScenicModel.h"
#import "Scenic12Model.h"

typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

@interface ScenicViewModel : NSObject

@property (nonatomic, strong) ScenicModel *model;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, strong) NSMutableArray<ScenicAreaModel *> *datalist;











- (void)getDataWithRequestMode:(RequestMode)mode withID:(NSInteger) area_id handller:(void (^)(NSError *))handller;

- (void)getScenicDetailDataWithScenic_id:(NSInteger) scenic_id handller:(void(^)(NSError *error))handller;




@end
