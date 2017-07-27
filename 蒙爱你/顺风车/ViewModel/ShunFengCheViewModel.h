//
//  ShunFengCheViewModel.h
//  蒙爱你
//
//  Created by mahaibo on 17/7/6.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShunFengCheModel.h"

typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

@interface ShunFengCheViewModel : NSObject

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray<HomeTravelModel *> *datalist;



- (void)getDataWithMode:(RequestMode) mode url:(NSString *)url handller:(void(^)(NSError *error)) handller;


//- (void)postDataWithTokenandMode:(RequestMode) mode url:(NSString *)url handller:(void(^)(NSError *error)) handller;




@end
