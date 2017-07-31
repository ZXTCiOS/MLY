//
//  FoodViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/10.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "FoodViewModel.h"
#import "HomeFoodModel.h"

@interface FoodViewModel ()

@property (nonatomic, assign) NSInteger page;

@end

@implementation FoodViewModel



- (void)getDataWithRequestMode:(RequestMode)mode type:(NSInteger)type searchText:(NSString *)text handller:(void (^)(NSError *))handller{
    if (mode == RequestModeRefresh) {
        self.page = 1;
    }
    NSDictionary *dic;
    NSInteger user_id = [[NSUserDefaults standardUserDefaults] integerForKey:user_key_user_id];
    if ([userDefault integerForKey:user_key_user_id]) {
        dic = @{@"page":@(self.page), @"user_id": @(user_id), @"type": @(3), @"search": text};
    }
    dic = @{@"page":@(self.page), @"user_id": @(user_id), @"type": @(type), @"search": text};
    [DNNetworking getWithURLString:get_search_other parameters:dic success:^(id obj) {
        if (mode == RequestModeRefresh) {
            [self.datalist removeAllObjects];
        }
        NSArray *arr = [NSArray modelArrayWithClass:[HomeFoodModel class] json:[[obj valueForKey:@"data"] valueForKey:@"minsu"]];
        [self.datalist addObjectsFromArray:arr];
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
}



- (void)getDataWithRequestMode:(RequestMode)mode type:(NSInteger)type stars:(NSString *)stars price:(NSInteger)price handller:(void (^)(NSError *))handller{
    
    // 筛选
    NSString *path = nil;
    if (type) {
        path = get_food_main; // 美食路径
    } else {
        path = get_bed_main; // 民宿
    }
    
    if (mode == RequestModeRefresh) {
        self.page = 1;
    }
    
    if (price || stars) {
        path = get_shaixuan;  // 筛选
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@(self.page) forKey:@"page"];
    NSString *user_id = [userDefault valueForKey:user_key_user_id];
    if (user_id) {
        [dic setValue:user_id forKey:@"user_id"];
    }
    //  添加  星级数组   价格
    if (price) {
        [dic setObject:@(price) forKey:@"price"];
        [dic setObject:stars forKey:@"star"];
    }
    
    [DNNetworking getWithURLString:path parameters:dic success:^(id obj) {
        NSString *code = [NSString stringWithFormat:@"%@", [obj valueForKey:@"code"]];
        if ([code isEqualToString:@"200"]) {
            if (mode == RequestModeRefresh) {
                [self.datalist removeAllObjects];
            }
            MinsuListModel *model = [MinsuListModel parse:obj];
            [self.datalist addObjectsFromArray:model.data];
            self.page++;
            
        }
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
