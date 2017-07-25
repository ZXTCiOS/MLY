//
//  ScenicViewModel.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/12.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ScenicViewModel.h"



@interface ScenicViewModel ()
@property(nonatomic, assign) NSInteger page;
@end

@implementation ScenicViewModel










- (void)getScenicDetailDataWithScenic_id:(NSInteger)scenic_id handller:(void (^)(NSError *))handller{
    
    [DNNetworking getWithURLString:@"MLY/api.php/Scenic/jingdianDetail" parameters:@{@"id":@(scenic_id)} success:^(id obj) {
        
        id data = [obj valueForKey:@"data"];
        self.model = [ScenicModel parse:data];
        !handller ?: handller(nil);
        
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
    
}



- (void)getDataWithRequestMode:(RequestMode)mode withID:(NSInteger)area_id handller:(void (^)(NSError *))handller{
    
    if (mode == RequestModeRefresh) {
        self.page = 1;
    }
    NSDictionary *dic;
    
    
    NSInteger user_id = [[NSUserDefaults standardUserDefaults] integerForKey:user_key_user_id];
    if ([userDefault integerForKey:user_key_user_id]) {
        dic = @{@"page":@(self.page), @"id":@(area_id), @"user_id": @(user_id)};
    }
    dic = @{@"page":@(self.page), @"id":@(area_id)};
    [DNNetworking getWithURLString:get_sceniclist parameters:dic success:^(id obj) {
        if (mode == RequestModeRefresh) {
            [self.datalist removeAllObjects];
        }
        ScenicListModel *model = [ScenicListModel parse:obj];
        [self.datalist addObjectsFromArray:model.data];
        !handller ?: handller(nil);
    } failure:^(NSError *error) {
        !handller ?: handller(error);
    }];
}


- (NSMutableArray<ScenicelEmentModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<ScenicelEmentModel *> array];
    }
    return _datalist;
}




@end
