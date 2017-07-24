//
//  FoodViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodViewModel.h"


@interface FoodViewModel ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation FoodViewModel







- (void)getDataWithRequestMode:(RequestMode)mode type:(NSInteger)type stars:(NSArray *)stars price:(NSInteger)price handller:(void (^)(NSError *))handller{
    
    // 筛选
    NSString *path = nil;
    if (type) {
        path = @""; // 美食路径
    } else {
        path = @""; // 民宿
    }
    
    
    
    if (mode == RequestModeRefresh) {
        self.page = 0;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(self.page) forKey:@"page"];
    
    //  添加  星级数组   价格
    
    
    [DNNetworking getWithURLString:get_food_main parameters:dic success:^(id obj) {
        if (mode == RequestModeRefresh) {
            [self.datalist removeAllObjects];
        }
        //   处理数据    json 待定
        
        
        self.page++;
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
    
}


- (NSMutableArray<HomeFoodModel *> *)datalist{
    if(!_datalist) {
        _datalist = [NSMutableArray<HomeFoodModel *> array];
    }
    return _datalist;
}

@end
