//
//  FoodViewModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeFoodModel.h"



typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

@interface FoodViewModel : NSObject


@property (nonatomic, strong) NSMutableArray<HomeFoodModel *> *datalist;












- (void)getDataWithRequestMode:(RequestMode) mode type:(NSInteger)type stars:(NSArray *)stars price:(NSInteger)price handller:(void(^)(NSError *error)) handller;






@end
